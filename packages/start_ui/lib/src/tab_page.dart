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

import 'tab_bar.dart';
import 'tab_controller.dart';
import 'theme.dart';

class TabPage extends StatefulWidget {
  TabPage({
    Key key,
    @required this.tabBar,
    @required this.tabBuilder,
    this.controller,
    this.backgroundColor,
    this.applySafeArea = true,
  })  : assert(tabBar != null),
        assert(tabBuilder != null),
        assert(
            controller == null || controller.index < tabBar.items.length,
            'The TabController\'s current index ${controller.index} is '
            'out of bounds for the tab bar with ${tabBar.items.length} tabs'),
        super(key: key);

  final TabBar tabBar;

  final TabController controller;

  final IndexedWidgetBuilder tabBuilder;

  final Color backgroundColor;

  final bool applySafeArea;

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _updateTabController();
  }

  void _updateTabController({bool disposeOldController = false}) {
    final TabController newController = widget.controller ??
        TabController(initialIndex: widget.tabBar.currentIndex);
    if (newController == _controller) {
      return;
    }
    if (disposeOldController) {
      _controller?.dispose();
    } else if (_controller?.isDisposed == false) {
      _controller.removeListener(_onCurrentIndexChange);
    }
    newController.addListener(_onCurrentIndexChange);
    _controller = newController;
  }

  void _onCurrentIndexChange() {
    assert(
        _controller.index >= 0 &&
            _controller.index < widget.tabBar.items.length,
        'The $runtimeType\'s current index ${_controller.index} is '
        'out of bounds for the tab bar with ${widget.tabBar.items.length} tabs');
    setState(() {});
  }

  @override
  void didUpdateWidget(TabPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController(
        disposeOldController: oldWidget.controller == null,
      );
    } else if (_controller.index >= widget.tabBar.items.length) {
      _controller.index = widget.tabBar.items.length - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Could we use a single MediaQuery?
    final MediaQueryData existingMediaQuery = MediaQuery.of(context);
    MediaQueryData newMediaQuery = MediaQuery.of(context);

    final content = _TabSwitchingView(
      currentTabIndex: _controller.index,
      tabNumber: widget.tabBar.items.length,
      tabBuilder: widget.tabBuilder,
    );
    EdgeInsets contentPadding = EdgeInsets.zero;

    if (widget.applySafeArea) {
      newMediaQuery = newMediaQuery.removeViewInsets(removeBottom: true);
      contentPadding = EdgeInsets.only(
        bottom: existingMediaQuery.viewInsets.bottom,
      );
    }

    if (widget.tabBar != null &&
        (!widget.applySafeArea ||
            widget.tabBar.preferredSize.height >
                existingMediaQuery.viewInsets.bottom)) {
      final double bottomPadding = widget.tabBar.preferredSize.height +
          existingMediaQuery.padding.bottom;

      if (widget.tabBar.opaque(context)) {
        contentPadding = EdgeInsets.only(bottom: bottomPadding);
      } else {
        newMediaQuery = newMediaQuery.copyWith(
          padding: newMediaQuery.padding.copyWith(
            bottom: bottomPadding,
          ),
        );
      }
    }

    // TODO: Opaque tab bar
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Theme.of(context).backgroundColor,
      ),
      child: Stack(
        children: <Widget>[
          MediaQuery(
            data: newMediaQuery,
            child: Padding(
              padding: contentPadding,
              child: content,
            ),
          ),
          MediaQuery(
            data: existingMediaQuery.copyWith(textScaleFactor: 1),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: widget.tabBar.copyWith(
                currentIndex: _controller.index,
                onTap: (int newIndex) {
                  _controller.index = newIndex;
                  if (widget.tabBar.onTap != null)
                    widget.tabBar.onTap(newIndex);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    } else if (_controller?.isDisposed == false) {
      _controller.removeListener(_onCurrentIndexChange);
    }
    super.dispose();
  }
}

class _TabSwitchingView extends StatefulWidget {
  const _TabSwitchingView({
    @required this.currentTabIndex,
    @required this.tabNumber,
    @required this.tabBuilder,
  })  : assert(currentTabIndex != null),
        assert(tabNumber != null && tabNumber > 0),
        assert(tabBuilder != null);

  final int currentTabIndex;
  final int tabNumber;
  final IndexedWidgetBuilder tabBuilder;

  @override
  _TabSwitchingViewState createState() => _TabSwitchingViewState();
}

class _TabSwitchingViewState extends State<_TabSwitchingView> {
  List<bool> shouldBuildTab;
  List<FocusScopeNode> tabFocusNodes;

  @override
  void initState() {
    super.initState();
    shouldBuildTab = List<bool>.filled(
      widget.tabNumber,
      false,
      growable: true,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusActiveTab();
  }

  @override
  void didUpdateWidget(_TabSwitchingView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final int lengthDiff = widget.tabNumber - shouldBuildTab.length;
    if (lengthDiff > 0) {
      shouldBuildTab.addAll(List<bool>.filled(lengthDiff, false));
    } else if (lengthDiff < 0) {
      shouldBuildTab.removeRange(widget.tabNumber, shouldBuildTab.length);
    }
    _focusActiveTab();
  }

  void _focusActiveTab() {
    if (tabFocusNodes?.length != widget.tabNumber) {
      tabFocusNodes = List<FocusScopeNode>.generate(
        widget.tabNumber,
        (index) => FocusScopeNode(debugLabel: 'Tab Focus Scope $index'),
      );
    }
    FocusScope.of(context).setFirstFocus(
      tabFocusNodes[widget.currentTabIndex],
    );
  }

  @override
  void dispose() {
    for (FocusScopeNode focusScopeNode in tabFocusNodes) {
      focusScopeNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Stack or other widgets?
    // TODO: Avoid rebuilding created widget.
    return Stack(
      fit: StackFit.expand,
      children: List<Widget>.generate(widget.tabNumber, (int index) {
        final bool selected = index == widget.currentTabIndex;
        shouldBuildTab[index] = selected || shouldBuildTab[index];
        return Offstage(
          offstage: !selected,
          child: TickerMode(
            enabled: selected,
            child: FocusScope(
              node: tabFocusNodes[index],
              child: shouldBuildTab[index]
                  ? widget.tabBuilder(context, index)
                  : Container(),
            ),
          ),
        );
      }),
    );
  }
}
