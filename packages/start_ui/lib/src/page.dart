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

import 'package:flutter/widgets.dart';

import 'obstructing.dart';
import 'theme.dart';

class Page extends StatefulWidget {
  const Page({
    Key key,
    this.navigationBar,
    this.backgroundColor,
    this.applySafeArea = true,
    @required this.child,
  })  : assert(child != null),
        assert(applySafeArea != null),
        super(key: key);

  final ObstructingWidget navigationBar;
  final Widget child;
  final Color backgroundColor;
  final bool applySafeArea;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  final _primaryScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    var child = widget.child;
    if (widget.navigationBar != null) {
      final topPadding =
          widget.navigationBar.preferredSize.height + mediaQuery.padding.top;
      final bottomPadding =
          widget.applySafeArea ? mediaQuery.viewInsets.bottom : 0.0;
      final viewInsets = widget.applySafeArea
          ? mediaQuery.viewInsets.copyWith(bottom: 0.0)
          : mediaQuery.viewInsets;
      final opaque = widget.navigationBar.opaque(context);
      if (opaque) {
        child = MediaQuery(
          data: mediaQuery.removePadding(removeTop: true).copyWith(
                viewInsets: viewInsets,
              ),
          child: Padding(
            padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
            child: child,
          ),
        );
      } else {
        child = MediaQuery(
          data: mediaQuery.copyWith(
            padding: mediaQuery.padding.copyWith(
              top: topPadding,
            ),
            viewInsets: viewInsets,
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: child,
          ),
        );
      }
    } else {
      final double bottomPadding =
          widget.applySafeArea ? mediaQuery.viewInsets.bottom : 0.0;
      child = Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: child,
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Theme.of(context).backgroundColor,
      ),
      child: Stack(
        children: <Widget>[
          PrimaryScrollController(
            controller: _primaryScrollController,
            child: child,
          ),
          if (widget.navigationBar != null)
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: MediaQuery(
                data: mediaQuery.copyWith(textScaleFactor: 1),
                child: widget.navigationBar,
              ),
            ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            height: mediaQuery.padding.top,
            child: GestureDetector(
              excludeFromSemantics: true,
              onTap: _onStatusBarTap,
            ),
          ),
        ],
      ),
    );
  }

  void _onStatusBarTap() {
    if (_primaryScrollController.hasClients) {
      _primaryScrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
      );
    }
  }
}
