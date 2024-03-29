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
import 'bottom_tab_bar.dart';
import 'theme.dart';

/// Coordinates tab selection between a [TabBar] and a [TabScaffold].
///
/// The [index] property is the index of the selected tab. Changing its value
/// updates the actively displayed tab of the [TabScaffold] the
/// [TabController] controls, as well as the currently selected tab item of
/// its [TabBar].
///
/// {@tool sample}
///
/// [TabController] can be used to switch tabs:
///
/// ```dart
/// class MyTabScaffoldPage extends StatefulWidget {
///   @override
///   _TabScaffoldPageState createState() => _TabScaffoldPageState();
/// }
///
/// class _TabScaffoldPageState extends State<MyTabScaffoldPage> {
///   final TabController _controller = TabController();
///
///   @override
///   Widget build(BuildContext context) {
///     return TabScaffold(
///       tabBar: TabBar(
///         items: <BottomNavigationBarItem> [
///           // ...
///         ],
///       ),
///       controller: _controller,
///       tabBuilder: (BuildContext context, int index) {
///         return Center(
///           child: Button(
///             child: const Text('Go to first tab'),
///             onPressed: () => _controller.index = 0,
///           )
///         );
///       }
///     );
///   }
///
///   @override
///   void dispose() {
///     _controller.dispose();
///     super.dispose();
///   }
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
/// * [TabScaffold], a tabbed application root layout that can be
///   controlled by a [TabController].
class TabController extends ChangeNotifier {
  /// Creates a [TabController] to control the tab index of [TabScaffold]
  /// and [TabBar].
  ///
  /// The [initialIndex] must not be null and defaults to 0. The value must be
  /// greater than or equal to 0, and less than the total number of tabs.
  TabController({ int initialIndex = 0 })
    : _index = initialIndex,
      assert(initialIndex != null),
      assert(initialIndex >= 0);

  bool _isDisposed = false;

  /// The index of the currently selected tab.
  ///
  /// Changing the value of [index] updates the actively displayed tab of the
  /// [TabScaffold] controlled by this [TabController], as well
  /// as the currently selected tab item of its [TabScaffold.tabBar].
  ///
  /// The value must be greater than or equal to 0, and less than the total
  /// number of tabs.
  int get index => _index;
  int _index;
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
    _isDisposed = true;
  }
}

/// Implements a tabbed iOS application's root layout and behavior structure.
///
/// The scaffold lays out the tab bar at the bottom and the content between or
/// behind the tab bar.
///
/// A [tabBar] and a [tabBuilder] are required. The [TabScaffold]
/// will automatically listen to the provided [TabBar]'s tap callbacks
/// to change the active tab.
///
/// A [controller] can be used to provide an initially selected tab index and manage
/// subsequent tab changes. If a controller is not specified, the scaffold will
/// create its own [TabController] and manage it internally. Otherwise
/// it's up to the owner of [controller] to call `dispose` on it after finish
/// using it.
///
/// Tabs' contents are built with the provided [tabBuilder] at the active
/// tab index. The [tabBuilder] must be able to build the same number of
/// pages as there are [tabBar.items]. Inactive tabs will be moved [Offstage]
/// and their animations disabled.
///
/// Adding/removing tabs, or changing the order of tabs is supported but not
/// recommended. Doing so is against the iOS human interface guidelines, and
/// [TabScaffold] may lose some tabs' state in the process.
///
/// Use [TabView] as the root widget of each tab to support tabs with
/// parallel navigation state and history. Since each [TabView] contains
/// a [Navigator], rebuilding the [TabView] with a different
/// [WidgetBuilder] instance in [TabView.builder] will not recreate
/// the [TabView]'s navigation stack or update its UI. To update the
/// contents of the [TabView] after it's built, trigger a rebuild
/// (via [State.setState], for instance) from its descendant rather than from
/// its ancestor.
///
/// {@tool sample}
///
/// A sample code implementing a typical iOS information architecture with tabs.
///
/// ```dart
/// TabScaffold(
///   tabBar: TabBar(
///     items: <BottomNavigationBarItem> [
///       // ...
///     ],
///   ),
///   tabBuilder: (BuildContext context, int index) {
///     return TabView(
///       builder: (BuildContext context) {
///         return PageScaffold(
///           navigationBar: NavigationBar(
///             middle: Text('Page 1 of tab $index'),
///           ),
///           child: Center(
///             child: Button(
///               child: const Text('Next page'),
///               onPressed: () {
///                 Navigator.of(context).push(
///                   StartPageRoute<void>(
///                     builder: (BuildContext context) {
///                       return PageScaffold(
///                         navigationBar: NavigationBar(
///                           middle: Text('Page 2 of tab $index'),
///                         ),
///                         child: Center(
///                           child: Button(
///                             child: const Text('Back'),
///                             onPressed: () { Navigator.of(context).pop(); },
///                           ),
///                         ),
///                       );
///                     },
///                   ),
///                 );
///               },
///             ),
///           ),
///         );
///       },
///     );
///   },
/// )
/// ```
/// {@end-tool}
///
/// To push a route above all tabs instead of inside the currently selected one
/// (such as when showing a dialog on top of this scaffold), use
/// `Navigator.of(rootNavigator: true)` from inside the [BuildContext] of a
/// [TabView].
///
/// See also:
///
///  * [TabBar], the bottom tab bar inserted in the scaffold.
///  * [TabController], the selection state of this widget
///  * [TabView], the typical root content of each tab that holds its own
///    [Navigator] stack.
///  * [StartPageRoute], a route hosting modal pages with iOS style transitions.
///  * [PageScaffold], typical contents of an iOS modal page implementing
///    layout with a navigation bar on top.
///  * [iOS human interface guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/bars/tab-bars/).
class TabScaffold extends StatefulWidget {
  /// Creates a layout for applications with a tab bar at the bottom.
  ///
  /// The [tabBar] and [tabBuilder] arguments must not be null.
  TabScaffold({
    Key key,
    @required this.tabBar,
    @required this.tabBuilder,
    this.controller,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  }) : assert(tabBar != null),
       assert(tabBuilder != null),
       assert(
         controller == null || controller.index < tabBar.items.length,
         "The TabController's current index ${controller.index} is "
         'out of bounds for the tab bar with ${tabBar.items.length} tabs'
       ),
       super(key: key);

  /// The [tabBar] is a [TabBar] drawn at the bottom of the screen
  /// that lets the user switch between different tabs in the main content area
  /// when present.
  ///
  /// The [TabBar.currentIndex] is only used to initialize a
  /// [TabController] when no [controller] is provided. Subsequently
  /// providing a different [TabBar.currentIndex] does not affect the
  /// scaffold or the tab bar's active tab index. To programmatically change
  /// the active tab index, use a [TabController].
  ///
  /// If [TabBar.onTap] is provided, it will still be called.
  /// [TabScaffold] automatically also listen to the
  /// [TabBar]'s `onTap` to change the [controller]'s `index`
  /// and change the actively displayed tab in [TabScaffold]'s own
  /// main content area.
  ///
  /// If translucent, the main content may slide behind it.
  /// Otherwise, the main content's bottom margin will be offset by its height.
  ///
  /// By default `tabBar` has its text scale factor set to 1.0 and does not
  /// respond to text scale factor changes from the operating system, to match
  /// the native iOS behavior. To override this behavior, wrap each of the `tabBar`'s
  /// items inside a [MediaQuery] with the desired [MediaQueryData.textScaleFactor]
  /// value. The text scale factor value from the operating system can be retrieved
  /// int many ways, such as querying [MediaQuery.textScaleFactorOf] against
  /// [App]'s [BuildContext].
  ///
  /// Must not be null.
  final TabBar tabBar;

  /// Controls the currently selected tab index of the [tabBar], as well as the
  /// active tab index of the [tabBuilder]. Providing a different [controller]
  /// will also update the scaffold's current active index to the new controller's
  /// index value.
  ///
  /// Defaults to null.
  final TabController controller;

  /// An [IndexedWidgetBuilder] that's called when tabs become active.
  ///
  /// The widgets built by [IndexedWidgetBuilder] is typically a [TabView]
  /// in order to achieve the parallel hierarchies information architecture seen
  /// on iOS apps with tab bars.
  ///
  /// When the tab becomes inactive, its content is still cached in the widget
  /// tree [Offstage] and its animations disabled.
  ///
  /// Content can slide under the [tabBar] when they're translucent.
  /// In that case, the child's [BuildContext]'s [MediaQuery] will have a
  /// bottom padding indicating the area of obstructing overlap from the
  /// [tabBar].
  ///
  /// Must not be null.
  final IndexedWidgetBuilder tabBuilder;

  /// The color of the widget that underlies the entire scaffold.
  ///
  /// By default uses [Theme]'s `scaffoldBackgroundColor` when null.
  final Color backgroundColor;

  /// Whether the [child] should size itself to avoid the window's bottom inset.
  ///
  /// For example, if there is an onscreen keyboard displayed above the
  /// scaffold, the body can be resized to avoid overlapping the keyboard, which
  /// prevents widgets inside the body from being obscured by the keyboard.
  ///
  /// Defaults to true and cannot be null.
  final bool resizeToAvoidBottomInset;

  @override
  _TabScaffoldState createState() => _TabScaffoldState();
}

class _TabScaffoldState extends State<TabScaffold> {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _updateTabController();
  }

  void _updateTabController({ bool shouldDisposeOldController = false }) {
    final TabController newController =
      // User provided a new controller, update `_controller` with it.
      widget.controller
      ?? TabController(initialIndex: widget.tabBar.currentIndex);

    if (newController == _controller) {
      return;
    }

    if (shouldDisposeOldController) {
      _controller?.dispose();
    } else if (_controller?._isDisposed == false) {
      _controller.removeListener(_onCurrentIndexChange);
    }

    newController.addListener(_onCurrentIndexChange);
    _controller = newController;
  }

  void _onCurrentIndexChange() {
    assert(
      _controller.index >= 0 && _controller.index < widget.tabBar.items.length,
      "The $runtimeType's current index ${_controller.index} is "
      'out of bounds for the tab bar with ${widget.tabBar.items.length} tabs'
    );

    // The value of `_controller.index` has already been updated at this point.
    // Calling `setState` to rebuild using `_controller.index`.
    setState(() {});
  }

  @override
  void didUpdateWidget(TabScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController(shouldDisposeOldController: oldWidget.controller == null);
    } else if (_controller.index >= widget.tabBar.items.length) {
      // If a new [tabBar] with less than (_controller.index + 1) items is provided,
      // clamp the current index.
      _controller.index = widget.tabBar.items.length - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stacked = <Widget>[];

    final MediaQueryData existingMediaQuery = MediaQuery.of(context);
    MediaQueryData newMediaQuery = MediaQuery.of(context);

    Widget content = _TabSwitchingView(
      currentTabIndex: _controller.index,
      tabNumber: widget.tabBar.items.length,
      tabBuilder: widget.tabBuilder,
    );
    EdgeInsets contentPadding = EdgeInsets.zero;

    if (widget.resizeToAvoidBottomInset) {
      // Remove the view inset and add it back as a padding in the inner content.
      newMediaQuery = newMediaQuery.removeViewInsets(removeBottom: true);
      contentPadding = EdgeInsets.only(bottom: existingMediaQuery.viewInsets.bottom);
    }

    if (widget.tabBar != null &&
        // Only pad the content with the height of the tab bar if the tab
        // isn't already entirely obstructed by a keyboard or other view insets.
        // Don't double pad.
        (!widget.resizeToAvoidBottomInset ||
            widget.tabBar.preferredSize.height > existingMediaQuery.viewInsets.bottom)) {
      // TODO(xster): Use real size after partial layout instead of preferred size.
      // https://github.com/flutter/flutter/issues/12912
      final double bottomPadding =
          widget.tabBar.preferredSize.height + existingMediaQuery.padding.bottom;

      // If tab bar opaque, directly stop the main content higher. If
      // translucent, let main content draw behind the tab bar but hint the
      // obstructed area.
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

    content = MediaQuery(
      data: newMediaQuery,
      child: Padding(
        padding: contentPadding,
        child: content,
      ),
    );

    // The main content being at the bottom is added to the stack first.
    stacked.add(content);

    stacked.add(
      MediaQuery(
        data: existingMediaQuery.copyWith(textScaleFactor: 1),
        child: Align(
          alignment: Alignment.bottomCenter,
          // Override the tab bar's currentIndex to the current tab and hook in
          // our own listener to update the [_controller.currentIndex] on top of a possibly user
          // provided callback.
          child: widget.tabBar.copyWith(
            currentIndex: _controller.index,
            onTap: (int newIndex) {
              _controller.index = newIndex;
              // Chain the user's original callback.
              if (widget.tabBar.onTap != null)
              widget.tabBar.onTap(newIndex);
            },
          ),
        ),
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Stack(
        children: stacked,
      ),
    );
  }

  @override
  void dispose() {
    // Only dispose `_controller` when the state instance owns it.
    if (widget.controller == null) {
      _controller?.dispose();
    } else if (_controller?._isDisposed == false) {
      _controller.removeListener(_onCurrentIndexChange);
    }

    super.dispose();
  }
}

/// A widget laying out multiple tabs with only one active tab being built
/// at a time and on stage. Off stage tabs' animations are stopped.
class _TabSwitchingView extends StatefulWidget {
  const _TabSwitchingView({
    @required this.currentTabIndex,
    @required this.tabNumber,
    @required this.tabBuilder,
  }) : assert(currentTabIndex != null),
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
    shouldBuildTab = List<bool>.filled(widget.tabNumber, false, growable: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusActiveTab();
  }

  @override
  void didUpdateWidget(_TabSwitchingView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only partially invalidate the tabs cache to avoid breaking the current
    // behavior. We assume that the only possible change is either:
    // - new tabs are appended to the tab list, or
    // - some trailing tabs are removed.
    // If the above assumption is not true, some tabs may lose their state.
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
        (int index) => FocusScopeNode(debugLabel: 'Tab Focus Scope $index'),
      );
    }
    FocusScope.of(context).setFirstFocus(tabFocusNodes[widget.currentTabIndex]);
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
    return Stack(
      fit: StackFit.expand,
      children: List<Widget>.generate(widget.tabNumber, (int index) {
        final bool active = index == widget.currentTabIndex;
        shouldBuildTab[index] = active || shouldBuildTab[index];

        return Offstage(
          offstage: !active,
          child: TickerMode(
            enabled: active,
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
