// MIT License
//
// Copyright (c) 2017-present qazyn951230 qazyn951230@gmail.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

const Duration _kTabScrollDuration = Duration(milliseconds: 300);

class TabController extends ChangeNotifier {
  TabController({
    int initialIndex = 0,
  })  : _index = initialIndex,
        assert(initialIndex != null),
        assert(initialIndex >= 0);

  bool _disposed = false;
  bool get isDisposed => _disposed;

  int _index;
  int get index => _index;
  set index(int value) {
    assert(value != null);
    assert(value >= 0);
    if (_index == value) {
      return;
    }
    _index = value;
    notifyListeners();
  }

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }
}

class AnimatedTabController extends TabController {
  AnimatedTabController({
    int initialIndex = 0,
    @required this.length,
    @required TickerProvider vsync,
  })  : assert(length != null && length >= 0),
        assert(initialIndex != null &&
            initialIndex >= 0 &&
            (length == 0 || initialIndex < length)),
        _index = initialIndex,
        _previousIndex = initialIndex,
        _animationController = AnimationController.unbounded(
          value: initialIndex.toDouble(),
          vsync: vsync,
        );

  AnimatedTabController._({
    int index,
    int previousIndex,
    AnimationController animationController,
    @required this.length,
  })  : _index = index,
        _previousIndex = previousIndex,
        _animationController = animationController;

  final int length;

  Animation<double> get animation => _animationController?.view;
  AnimationController _animationController;

  int get index => _index;
  int _index;
  set index(int value) {
    _changeIndex(value);
  }

  int get previousIndex => _previousIndex;
  int _previousIndex;

  bool get indexIsChanging => _indexIsChangingCount != 0;
  int _indexIsChangingCount = 0;

  double get offset => _animationController.value - _index.toDouble();
  set offset(double value) {
    assert(value != null);
    assert(value >= -1.0 && value <= 1.0);
    assert(!indexIsChanging);
    if (value == offset) return;
    _animationController.value = value + _index.toDouble();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }

  void animateTo(
    int value, {
    Duration duration = _kTabScrollDuration,
    Curve curve = Curves.ease,
  }) {
    _changeIndex(value, duration: duration, curve: curve);
  }

  AnimatedTabController copyWith({
    int index,
    int length,
    int previousIndex,
  }) {
    return AnimatedTabController._(
      index: index ?? _index,
      length: length ?? this.length,
      animationController: _animationController,
      previousIndex: previousIndex ?? _previousIndex,
    );
  }

  void _changeIndex(int value, {Duration duration, Curve curve}) {
    assert(value != null);
    assert(value >= 0 && (value < length || length == 0));
    assert(duration != null || curve == null);
    assert(_indexIsChangingCount >= 0);
    if (value == _index || length < 2) return;
    _previousIndex = index;
    _index = value;
    if (duration != null) {
      _indexIsChangingCount += 1;
      // Because the value of indexIsChanging may have changed.
      notifyListeners();
      _animationController
          .animateTo(_index.toDouble(), duration: duration, curve: curve)
          .whenCompleteOrCancel(() {
        _indexIsChangingCount -= 1;
        notifyListeners();
      });
    } else {
      _indexIsChangingCount += 1;
      _animationController.value = _index.toDouble();
      _indexIsChangingCount -= 1;
      notifyListeners();
    }
  }
}

class AnimatedTabControllerProvider extends StatefulWidget {
  const AnimatedTabControllerProvider({
    Key key,
    @required this.length,
    this.initialIndex = 0,
    @required this.child,
  })  : assert(initialIndex != null),
        assert(length >= 0),
        assert(initialIndex >= 0 && initialIndex < length),
        super(key: key);

  final int length;
  final int initialIndex;
  final Widget child;

  static AnimatedTabController of(BuildContext context) {
    final _TabControllerScope scope =
        context.inheritFromWidgetOfExactType(_TabControllerScope);
    return scope?.controller;
  }

  @override
  _AnimatedTabControllerProviderState createState() =>
      _AnimatedTabControllerProviderState();
}

class _AnimatedTabControllerProviderState
    extends State<AnimatedTabControllerProvider>
    with SingleTickerProviderStateMixin {
  AnimatedTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimatedTabController(
      vsync: this,
      length: widget.length,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _TabControllerScope(
      controller: _controller,
      enabled: TickerMode.of(context),
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(AnimatedTabControllerProvider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.length != widget.length) {
      int newIndex;
      int previousIndex = _controller.previousIndex;
      if (_controller.index >= widget.length) {
        newIndex = math.max(0, widget.length - 1);
        previousIndex = _controller.index;
      }
      _controller = _controller.copyWith(
        length: widget.length,
        index: newIndex,
        previousIndex: previousIndex,
      );
    }
  }
}

class _TabControllerScope extends InheritedWidget {
  const _TabControllerScope({
    Key key,
    this.controller,
    this.enabled,
    Widget child,
  }) : super(key: key, child: child);

  final AnimatedTabController controller;
  final bool enabled;

  @override
  bool updateShouldNotify(_TabControllerScope old) {
    return enabled != old.enabled || controller != old.controller;
  }
}
