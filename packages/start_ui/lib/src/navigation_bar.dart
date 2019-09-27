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

//import 'dart:math' as math;
//import 'dart:ui' show ImageFilter;
//
//import 'package:flutter/widgets.dart';
//import 'package:start_ui/src/navigation_bar_theme.dart';
//
//import 'obstructing.dart';
//import 'theme.dart';
//import 'utility.dart';
//
//const double _kDefaultHeight = 44.0;
//const Border _kDefaultBorder = Border(
//  bottom: BorderSide(width: 0.0, style: BorderStyle.solid),
//);
//const _HeroTag _kDefaultHeroTag = _HeroTag(null);
//
//// TODO: Adopt SystemUiOverlay
//class UINavigationBar extends StatefulWidget implements ObstructingWidget {
//  const UINavigationBar({
//    Key key,
//    this.leading,
//    this.middle,
//    this.trailing,
//    this.backgroundColor,
//    this.border = _kDefaultBorder,
//    this.translucent,
//    this.backIcon,
//    this.transitionable = true,
//    this.height = _kDefaultHeight,
//    this.heroTag = _kDefaultHeroTag,
//  })  : assert(transitionable != null),
//        super(key: key);
//
//  final Widget leading;
//  final Widget middle;
//  final Widget trailing;
//
//  final Color backgroundColor;
//  final Border border;
//  final bool translucent;
//  final IconData backIcon;
//  final double height;
//
//  final bool transitionable;
//  final Object heroTag;
//
//  @override
//  Size get preferredSize => Size.fromHeight(44.0);
//
//  bool opaque(BuildContext context) {
//    if (translucent != null) {
//      return !translucent;
//    }
//    final barTheme = UINavigationBarTheme.of(context);
//    if (barTheme.translucent != null) {
//      return !barTheme.translucent;
//    }
//    final backgroundColor = this.backgroundColor ?? barTheme.backgroundColor;
//    return backgroundColor.alpha == 0xFF;
//  }
//
//  @override
//  _UINavigationBarState createState() => _UINavigationBarState();
//}
//
//class _UINavigationBarState extends State<UINavigationBar> {
//  bool get _transitionable {
//    if (widget.transitionable) {
//      final route = ModalRoute.of(context);
//      return route is PageRoute && !route.fullscreenDialog;
//    }
//    return false;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final content = _buildContent(context);
//    if (!_transitionable) {
//      return content;
//    }
//    return Builder(
//      builder: (context) {
//        return Hero(
//          tag: widget.heroTag == _kDefaultHeroTag
//              ? _HeroTag(Navigator.of(context))
//              : widget.heroTag,
//          createRectTween: _linearTranslateWithLargestRectSizeTween,
//          placeholderBuilder: _navBarHeroLaunchPadBuilder,
//          flightShuttleBuilder: _navBarHeroFlightShuttleBuilder,
//          transitionOnUserGestures: true,
//          child: null,
//        );
//      },
//    );
//  }
//
//  Widget _buildContent(BuildContext context) {
//    final theme = UINavigationBarTheme.of(context);
//    return DecoratedBox(
//      decoration: BoxDecoration(
//        border: widget.border == _kDefaultBorder
//            ? resolveBorder(widget.border, UITheme.of(context))
//            : widget.border,
//        color: widget.backgroundColor ?? theme.backgroundColor,
//      ),
//      child: SizedBox(
//        height: 64.0,
//        child: SafeArea(
//          bottom: false,
//          child: NavigationToolbar(
//            leading: _buildLeading(theme),
//            middle: widget.middle,
//            trailing: widget.trailing,
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget _buildLeading(UINavigationBarTheme theme) {
//    if (widget.leading != null) {
//      return widget.leading;
//    } else if (widget.backIcon != null) {
//      return Icon(widget.backIcon);
//    } else if (theme.backButtonBuilder != null) {
//      return Builder(builder: theme.backButtonBuilder);
//    } else {
//      return Icon(theme.backIcon);
//    }
//  }
//}
//
//class _HeroTag {
//  const _HeroTag(this.navigator);
//
//  final NavigatorState navigator;
//
//  @override
//  String toString() =>
//      'Default Hero tag for Cupertino navigation bars with navigator $navigator';
//
//  @override
//  bool operator ==(Object other) {
//    if (identical(this, other)) {
//      return true;
//    }
//    if (other.runtimeType != runtimeType) {
//      return false;
//    }
//    final _HeroTag otherTag = other;
//    return navigator == otherTag.navigator;
//  }
//
//  @override
//  int get hashCode {
//    return identityHashCode(navigator);
//  }
//}
//
//CreateRectTween _linearTranslateWithLargestRectSizeTween =
//    (Rect begin, Rect end) {
//  final Size largestSize = Size(
//    math.max(begin.size.width, end.size.width),
//    math.max(begin.size.height, end.size.height),
//  );
//  return RectTween(
//    begin: begin.topLeft & largestSize,
//    end: end.topLeft & largestSize,
//  );
//};
//
//final HeroPlaceholderBuilder _navBarHeroLaunchPadBuilder = (
//  BuildContext context,
//  Size heroSize,
//  Widget child,
//) {
//  assert(child is _TransitionableNavigationBar);
//  return Visibility(
//    maintainSize: true,
//    maintainAnimation: true,
//    maintainState: true,
//    visible: false,
//    child: child,
//  );
//};
//
//final HeroFlightShuttleBuilder _navBarHeroFlightShuttleBuilder = (
//  BuildContext flightContext,
//  Animation<double> animation,
//  HeroFlightDirection flightDirection,
//  BuildContext fromHeroContext,
//  BuildContext toHeroContext,
//) {
//  assert(animation != null);
//  assert(flightDirection != null);
//  assert(fromHeroContext != null);
//  assert(toHeroContext != null);
//  assert(fromHeroContext.widget is Hero);
//  assert(toHeroContext.widget is Hero);
//
//  final Hero fromHeroWidget = fromHeroContext.widget;
//  final Hero toHeroWidget = toHeroContext.widget;
//
//  assert(fromHeroWidget.child is _TransitionableNavigationBar);
//  assert(toHeroWidget.child is _TransitionableNavigationBar);
//
//  final _TransitionableNavigationBar fromNavBar = fromHeroWidget.child;
//  final _TransitionableNavigationBar toNavBar = toHeroWidget.child;
//
//  assert(fromNavBar.componentsKeys != null);
//  assert(toNavBar.componentsKeys != null);
//
//  assert(
//    fromNavBar.componentsKeys.navBarBoxKey.currentContext.owner != null,
//    'The from nav bar to Hero must have been mounted in the previous frame',
//  );
//  assert(
//    toNavBar.componentsKeys.navBarBoxKey.currentContext.owner != null,
//    'The to nav bar to Hero must have been mounted in the previous frame',
//  );
//
//  switch (flightDirection) {
//    case HeroFlightDirection.push:
//      return _NavigationBarTransition(
//        animation: animation,
//        bottomNavBar: fromNavBar,
//        topNavBar: toNavBar,
//      );
//      break;
//    case HeroFlightDirection.pop:
//      return _NavigationBarTransition(
//        animation: animation,
//        bottomNavBar: toNavBar,
//        topNavBar: fromNavBar,
//      );
//  }
//  return null;
//};
//
//class _TransitionableNavigationBar extends StatelessWidget {
//  _TransitionableNavigationBar({
//    @required this.componentsKeys,
//    @required this.backgroundColor,
//    @required this.backButtonTextStyle,
//    @required this.titleTextStyle,
//    @required this.largeTitleTextStyle,
//    @required this.border,
//    @required this.hasUserMiddle,
//    @required this.largeExpanded,
//    @required this.child,
//  })  : assert(componentsKeys != null),
//        assert(largeExpanded != null),
//        assert(!largeExpanded || largeTitleTextStyle != null),
//        super(key: componentsKeys.navBarBoxKey);
//
//  final _NavigationBarStaticComponentsKeys componentsKeys;
//  final Color backgroundColor;
//  final TextStyle backButtonTextStyle;
//  final TextStyle titleTextStyle;
//  final TextStyle largeTitleTextStyle;
//  final Border border;
//  final bool hasUserMiddle;
//  final bool largeExpanded;
//  final Widget child;
//
//  RenderBox get renderBox {
//    final RenderBox box =
//        componentsKeys.navBarBoxKey.currentContext.findRenderObject();
//    assert(
//      box.attached,
//      '_TransitionableNavigationBar.renderBox should be called when building '
//      'hero flight shuttles when the from and the to nav bar boxes are already '
//      'laid out and painted.',
//    );
//    return box;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    assert(() {
//      bool inHero;
//      context.visitAncestorElements((Element ancestor) {
//        if (ancestor is ComponentElement) {
//          assert(
//            ancestor.widget.runtimeType != _NavigationBarTransition,
//            '_TransitionableNavigationBar should never re-appear inside '
//            '_NavigationBarTransition. Keyed _TransitionableNavigationBar should '
//            'only serve as anchor points in routes rather than appearing inside '
//            'Hero flights themselves.',
//          );
//          if (ancestor.widget.runtimeType == Hero) {
//            inHero = true;
//          }
//        }
//        inHero ??= false;
//        return true;
//      });
//      assert(
//        inHero == true,
//        '_TransitionableNavigationBar should only be added as the immediate '
//        'child of Hero widgets.',
//      );
//      return true;
//    }());
//    return child;
//  }
//}
//
//class _NavigationBarTransition extends StatelessWidget {
//  _NavigationBarTransition({
//    @required this.animation,
//    @required this.topNavBar,
//    @required this.bottomNavBar,
//  })  : heightTween = Tween<double>(
//          begin: bottomNavBar.renderBox.size.height,
//          end: topNavBar.renderBox.size.height,
//        ),
//        backgroundTween = ColorTween(
//          begin: bottomNavBar.backgroundColor,
//          end: topNavBar.backgroundColor,
//        ),
//        borderTween = BorderTween(
//          begin: bottomNavBar.border,
//          end: topNavBar.border,
//        );
//
//  final Animation<double> animation;
//  final _TransitionableNavigationBar topNavBar;
//  final _TransitionableNavigationBar bottomNavBar;
//
//  final Tween<double> heightTween;
//  final ColorTween backgroundTween;
//  final BorderTween borderTween;
//
//  @override
//  Widget build(BuildContext context) {
//    final components = _NavigationBarItems(
//      animation: animation,
//      bottomNavBar: bottomNavBar,
//      topNavBar: topNavBar,
//      directionality: Directionality.of(context),
//    );
//
//    final List<Widget> children = <Widget>[
//      AnimatedBuilder(
//        animation: animation,
//        builder: (BuildContext context, Widget child) {
//          return _wrapWithBackground(
//            updateSystemUiOverlay: false,
//            backgroundColor: backgroundTween.evaluate(animation),
//            border: borderTween.evaluate(animation),
//            child: SizedBox(
//              height: heightTween.evaluate(animation),
//              width: double.infinity,
//            ),
//          );
//        },
//      ),
//      if (components.bottomBackButton != null) components.bottomBackButton,
//      if (components.bottomBackLabel != null) components.bottomBackLabel,
//      if (components.bottomLeading != null) components.bottomLeading,
//      if (components.bottomMiddle != null) components.bottomMiddle,
//      if (components.bottomLargeTitle != null) components.bottomLargeTitle,
//      if (components.bottomTrailing != null) components.bottomTrailing,
//      if (components.topLeading != null) components.topLeading,
//      if (components.topBackButton != null) components.topBackButton,
//      if (components.topBackLabel != null) components.topBackLabel,
//      if (components.topMiddle != null) components.topMiddle,
//      if (components.topLargeTitle != null) components.topLargeTitle,
//      if (components.topTrailing != null) components.topTrailing,
//    ];
//
//    return SizedBox(
//      height: math.max(heightTween.begin, heightTween.end) +
//          MediaQuery.of(context).padding.top,
//      width: double.infinity,
//      child: Stack(
//        children: children,
//      ),
//    );
//  }
//}
//
//class _NavigationBarItems {
//  _NavigationBarItems({
//    @required this.animation,
//    @required _TransitionableNavigationBar bottomNavBar,
//    @required _TransitionableNavigationBar topNavBar,
//    @required TextDirection directionality,
//  })  : bottomComponents = bottomNavBar.componentsKeys,
//        topComponents = topNavBar.componentsKeys,
//        bottomNavBarBox = bottomNavBar.renderBox,
//        topNavBarBox = topNavBar.renderBox,
//        bottomBackButtonTextStyle = bottomNavBar.backButtonTextStyle,
//        topBackButtonTextStyle = topNavBar.backButtonTextStyle,
//        bottomTitleTextStyle = bottomNavBar.titleTextStyle,
//        topTitleTextStyle = topNavBar.titleTextStyle,
//        bottomLargeTitleTextStyle = bottomNavBar.largeTitleTextStyle,
//        topLargeTitleTextStyle = topNavBar.largeTitleTextStyle,
//        bottomHasUserMiddle = bottomNavBar.hasUserMiddle,
//        topHasUserMiddle = topNavBar.hasUserMiddle,
//        bottomLargeExpanded = bottomNavBar.largeExpanded,
//        topLargeExpanded = topNavBar.largeExpanded,
//        transitionBox = bottomNavBar.renderBox.paintBounds
//            .expandToInclude(topNavBar.renderBox.paintBounds),
//        forwardDirection = directionality == TextDirection.ltr ? 1.0 : -1.0;
//
//  final Animation<double> animation;
//  final _NavigationBarItemKeys bottomComponents;
//  final _NavigationBarItemKeys topComponents;
//
//  final RenderBox bottomNavBarBox;
//  final RenderBox topNavBarBox;
//
//  final TextStyle bottomBackButtonTextStyle;
//  final TextStyle topBackButtonTextStyle;
//  final TextStyle bottomTitleTextStyle;
//  final TextStyle topTitleTextStyle;
//  final TextStyle bottomLargeTitleTextStyle;
//  final TextStyle topLargeTitleTextStyle;
//
//  final bool bottomHasUserMiddle;
//  final bool topHasUserMiddle;
//  final bool bottomLargeExpanded;
//  final bool topLargeExpanded;
//  final Rect transitionBox;
//  final double forwardDirection;
//}
//
//class _NavigationBarItemKeys {
//  _NavigationBarItemKeys()
//      : navBarBoxKey = GlobalKey(debugLabel: 'Navigation bar render box'),
//        leadingKey = GlobalKey(debugLabel: 'Leading'),
//        backChevronKey = GlobalKey(debugLabel: 'Back chevron'),
//        backLabelKey = GlobalKey(debugLabel: 'Back label'),
//        middleKey = GlobalKey(debugLabel: 'Middle'),
//        trailingKey = GlobalKey(debugLabel: 'Trailing'),
//        largeTitleKey = GlobalKey(debugLabel: 'Large title');
//
//  final GlobalKey navBarBoxKey;
//  final GlobalKey leadingKey;
//  final GlobalKey backChevronKey;
//  final GlobalKey backLabelKey;
//  final GlobalKey middleKey;
//  final GlobalKey trailingKey;
//  final GlobalKey largeTitleKey;
//}
