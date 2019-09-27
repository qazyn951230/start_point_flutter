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

import 'theme.dart';

/// Implements a single iOS application page's layout.
///
/// The scaffold lays out the navigation bar on top and the content between or
/// behind the navigation bar.
///
/// See also:
///
///  * [TabScaffold], a similar widget for tabbed applications.
///  * [StartPageRoute], a modal page route that typically hosts a
///    [PageScaffold] with support for iOS-style page transitions.
class PageScaffold extends StatefulWidget {
  /// Creates a layout for pages with a navigation bar at the top.
  const PageScaffold({
    Key key,
    this.navigationBar,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    @required this.child,
  }) : assert(child != null),
       assert(resizeToAvoidBottomInset != null),
       super(key: key);

  /// The [navigationBar], typically a [NavigationBar], is drawn at the
  /// top of the screen.
  ///
  /// If translucent, the main content may slide behind it.
  /// Otherwise, the main content's top margin will be offset by its height.
  ///
  /// The scaffold assumes the navigation bar will account for the [MediaQuery]
  /// top padding, also consume it if the navigation bar is opaque.
  ///
  /// By default `navigationBar` has its text scale factor set to 1.0 and does
  /// not respond to text scale factor changes from the operating system, to match
  /// the native iOS behavior. To override such behavior, wrap each of the `navigationBar`'s
  /// components inside a [MediaQuery] with the desired [MediaQueryData.textScaleFactor]
  /// value. The text scale factor value from the operating system can be retrieved
  /// in many ways, such as querying [MediaQuery.textScaleFactorOf] against
  /// [App]'s [BuildContext].
  // TODO(xster): document its page transition animation when ready
  final ObstructingPreferredSizeWidget navigationBar;

  /// Widget to show in the main content area.
  ///
  /// Content can slide under the [navigationBar] when they're translucent.
  /// In that case, the child's [BuildContext]'s [MediaQuery] will have a
  /// top padding indicating the area of obstructing overlap from the
  /// [navigationBar].
  final Widget child;

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
  _PageScaffoldState createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold> {
  final ScrollController _primaryScrollController = ScrollController();

  void _handleStatusBarTap() {
    // Only act on the scroll controller if it has any attached scroll positions.
    if (_primaryScrollController.hasClients) {
      _primaryScrollController.animateTo(
        0.0,
        // Eyeballed from iOS.
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stacked = <Widget>[];

    Widget paddedContent = widget.child;

    final MediaQueryData existingMediaQuery = MediaQuery.of(context);
    if (widget.navigationBar != null) {
      // TODO(xster): Use real size after partial layout instead of preferred size.
      // https://github.com/flutter/flutter/issues/12912
      final double topPadding =
          widget.navigationBar.preferredSize.height + existingMediaQuery.padding.top;

      // Propagate bottom padding and include viewInsets if appropriate
      final double bottomPadding = widget.resizeToAvoidBottomInset
          ? existingMediaQuery.viewInsets.bottom
          : 0.0;

      final EdgeInsets newViewInsets = widget.resizeToAvoidBottomInset
          // The insets are consumed by the scaffolds and no longer exposed to
          // the descendant subtree.
          ? existingMediaQuery.viewInsets.copyWith(bottom: 0.0)
          : existingMediaQuery.viewInsets;

      final bool fullObstruction =
        widget.navigationBar.fullObstruction ?? Theme.of(context).barBackgroundColor.alpha == 0xFF;

      // If navigation bar is opaquely obstructing, directly shift the main content
      // down. If translucent, let main content draw behind navigation bar but hint the
      // obstructed area.
      if (fullObstruction) {
        paddedContent = MediaQuery(
          data: existingMediaQuery
          // If the navigation bar is opaque, the top media query padding is fully consumed by the navigation bar.
          .removePadding(removeTop: true)
          .copyWith(
            viewInsets: newViewInsets,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
            child: paddedContent,
          ),
        );
      } else {
        paddedContent = MediaQuery(
          data: existingMediaQuery.copyWith(
            padding: existingMediaQuery.padding.copyWith(
              top: topPadding,
            ),
            viewInsets: newViewInsets,
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: paddedContent,
          ),
        );
      }
    } else {
      // If there is no navigation bar, still may need to add padding in order
      // to support resizeToAvoidBottomInset.
      final double bottomPadding = widget.resizeToAvoidBottomInset
          ? existingMediaQuery.viewInsets.bottom
          : 0.0;
      paddedContent = Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: paddedContent,
      );
    }

    // The main content being at the bottom is added to the stack first.
    stacked.add(PrimaryScrollController(
      controller: _primaryScrollController,
      child: paddedContent,
    ));

    if (widget.navigationBar != null) {
      stacked.add(Positioned(
        top: 0.0,
        left: 0.0,
        right: 0.0,
        child: MediaQuery(
          data: existingMediaQuery.copyWith(textScaleFactor: 1),
          child: widget.navigationBar,
        ),
      ));
    }

    // Add a touch handler the size of the status bar on top of all contents
    // to handle scroll to top by status bar taps.
    stacked.add(Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      height: existingMediaQuery.padding.top,
      child: GestureDetector(
          excludeFromSemantics: true,
          onTap: _handleStatusBarTap,
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
}

/// Widget that has a preferred size and reports whether it fully obstructs
/// widgets behind it.
///
/// Used by [PageScaffold] to either shift away fully obstructed content
/// or provide a padding guide to partially obstructed content.
abstract class ObstructingPreferredSizeWidget extends PreferredSizeWidget {
  /// If true, this widget fully obstructs widgets behind it by the specified
  /// size.
  ///
  /// If false, this widget partially obstructs.
  bool get fullObstruction;
}
