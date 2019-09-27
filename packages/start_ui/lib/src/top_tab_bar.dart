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

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:start_ui/src/tab_box.dart';

import 'colors.dart';
import 'tab_controller.dart';
import 'tab_decoration.dart';
import 'tab_flex.dart';
import 'tab_indicator.dart';

class TopTabBar extends StatefulWidget {
  const TopTabBar({
    this.controller,
    this.scrollable = false,
    this.decoration = const UnderlineDecoration(),
    this.dragStartBehavior = DragStartBehavior.start,
    this.onTap,
  })  : assert(scrollable != null),
        assert(dragStartBehavior != null);

  final AnimatedTabController controller;
  final bool scrollable;
  final TabDecoration decoration;
  final DragStartBehavior dragStartBehavior;
  final ValueChanged<int> onTap;

  @override
  _TopTabBarState createState() => _TopTabBarState();
}

class _TopTabBarState extends State<TopTabBar> implements TabPainterDelegate {
  AnimatedTabController _controller;
  int _currentIndex;
  double _tabWidth;
  List<double> _tabXOffsets;

  bool get _controllerIsValid => _controller?.animation != null;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
//    _updateTabController();
  }

  @override
  void didUpdateWidget(TopTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TabDecoratedBox(
      // decoration: widget.decoration.resolve(context),
      decoration: UnderlineDecoration(
        side: BorderSide(width: 10.0, color: UIColor.lightBlue),
      ),
      position: DecorationPosition.foreground,
      delegate: this,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: UIColor.lightGray4,
        ),
        child: TabFlex(
          onPerformLayout: _onTabPerformLayout,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text('1'),
              ),
            ),
            Expanded(
              child: Center(
                child: Text('2'),
              ),
            ),
            Expanded(
              child: Center(
                child: Text('3'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_controllerIsValid) {
//      _controller.animation.removeListener(_handleAnimationTick);
      _controller.removeListener(_handleControllerTick);
    }
    _controller = null;
    super.dispose();
  }

  void _updateTabController() {
    final controller =
        widget.controller ?? AnimatedTabControllerProvider.of(context);
    assert(() {
      if (controller == null) {
        throw FlutterError('No TabController for ${widget.runtimeType}.\n'
            'When creating a ${widget.runtimeType}, you must either provide an explicit '
            'TabController using the "controller" property, or you must ensure that there '
            'is a DefaultTabController above the ${widget.runtimeType}.\n'
            'In this case, there was neither an explicit controller nor a default controller.');
      }
      return true;
    }());
    if (controller == _controller) {
      return;
    }
    if (_controllerIsValid) {
//      _controller.animation.removeListener(_handleAnimationTick);
      _controller.removeListener(_handleControllerTick);
    }
    _controller = controller;
    if (_controller != null) {
//      _controller.animation.addListener(_handleAnimationTick);
      _controller.addListener(_handleControllerTick);
      _currentIndex = _controller.index;
    }
  }

//  void _handleAnimationTick() {
//    assert(mounted);
//  }

  void _handleControllerTick() {
    if (_controller.index != _currentIndex) {
      _currentIndex = _controller.index;
    }
    setState(() {
      // Rebuild the tabs after a (potentially animated) index change
      // has completed.
    });
  }

  void _onTabPerformLayout(
    TextDirection textDirection,
    double width,
    List<double> xOffsets,
  ) {
    _tabWidth = width;
    _tabXOffsets = xOffsets;
  }

  @override
  int currentIndex() {
    return _currentIndex;
  }

  @override
  double currentProgress() {
    // TODO: implement currentProgress
    return null;
  }

  @override
  bool isIndexChanging() {
    // TODO: implement isIndexChanging
    return null;
  }

  @override
  double labelWidth(int index) {
    // TODO: implement labelWidth
    return null;
  }

  @override
  bool shouldRepaint() {
    // TODO: implement shouldRepaint
    return null;
  }

  @override
  int tabCount() {
    // TODO: implement tabCount
    return null;
  }

  @override
  double tabWidth(int index) {
    // TODO: implement tabWidth
    return null;
  }
}
