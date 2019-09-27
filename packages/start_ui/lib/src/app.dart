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

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'route.dart';
import 'theme.dart';

class UIApp extends StatefulWidget {
  const UIApp({
    Key key,
    this.navigatorKey,
    this.home,
    this.theme,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = false,
  })  : assert(routes != null),
        assert(navigatorObservers != null),
        assert(title != null),
        assert(showPerformanceOverlay != null),
        assert(checkerboardRasterCacheImages != null),
        assert(checkerboardOffscreenLayers != null),
        assert(showSemanticsDebugger != null),
        assert(debugShowCheckedModeBanner != null),
        super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  final Widget home;

  final ThemeData theme;

  final Map<String, WidgetBuilder> routes;

  final String initialRoute;

  final RouteFactory onGenerateRoute;

  final RouteFactory onUnknownRoute;

  final List<NavigatorObserver> navigatorObservers;

  final TransitionBuilder builder;

  final String title;

  final GenerateAppTitle onGenerateTitle;

  final Color color;

  final Locale locale;

  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;

  final LocaleListResolutionCallback localeListResolutionCallback;

  final LocaleResolutionCallback localeResolutionCallback;

  final Iterable<Locale> supportedLocales;

  final bool showPerformanceOverlay;

  final bool checkerboardRasterCacheImages;

  final bool checkerboardOffscreenLayers;

  final bool showSemanticsDebugger;

  final bool debugShowCheckedModeBanner;

  @override
  _UIAppState createState() => _UIAppState();

  static HeroController createHeroController() => HeroController();
}

class _UIAppState extends State<UIApp> {
  HeroController _heroController;

  @override
  void initState() {
    super.initState();
    _heroController = UIApp.createHeroController();
    _updateNavigator();
  }

  @override
  void didUpdateWidget(UIApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.navigatorKey != oldWidget.navigatorKey) {
      _heroController = UIApp.createHeroController();
    }
    _updateNavigator();
  }

  List<NavigatorObserver> _navigatorObservers;

  void _updateNavigator() {
    if (widget.home != null ||
        widget.routes.isNotEmpty ||
        widget.onGenerateRoute != null ||
        widget.onUnknownRoute != null) {
      _navigatorObservers =
          List<NavigatorObserver>.from(widget.navigatorObservers)
            ..add(_heroController);
    } else {
      _navigatorObservers = const <NavigatorObserver>[];
    }
  }

  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegates sync* {
    if (widget.localizationsDelegates != null)
      yield* widget.localizationsDelegates;
    yield DefaultCupertinoLocalizations.delegate;
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ThemeData();
    return ScrollConfiguration(
      behavior: _AlwaysScrollBehavior(),
      child: Theme(
        data: theme,
        child: WidgetsApp(
          key: GlobalObjectKey(this),
          navigatorKey: widget.navigatorKey,
          navigatorObservers: _navigatorObservers,
          pageRouteBuilder: <T>(settings, builder) =>
              UIPageRoute<T>(settings: settings, builder: builder),
          home: widget.home,
          routes: widget.routes,
          initialRoute: widget.initialRoute,
          onGenerateRoute: widget.onGenerateRoute,
          onUnknownRoute: widget.onUnknownRoute,
          builder: widget.builder,
          title: widget.title,
          onGenerateTitle: widget.onGenerateTitle,
          textStyle: theme.textTheme.body,
          color: widget.color ?? theme.backgroundColor,
          locale: widget.locale,
          localizationsDelegates: _localizationsDelegates,
          localeResolutionCallback: widget.localeResolutionCallback,
          localeListResolutionCallback: widget.localeListResolutionCallback,
          supportedLocales: widget.supportedLocales,
          showPerformanceOverlay: widget.showPerformanceOverlay,
          checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
          showSemanticsDebugger: widget.showSemanticsDebugger,
          debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
          inspectorSelectButtonBuilder: (context, onPressed) {
//            return Button.filled(
//              child: const Icon(
//                Icons.search,
//                size: 28.0,
//                color: Colors.white,
//              ),
//              padding: EdgeInsets.zero,
//              onPressed: onPressed,
//            );
            return null;
          },
        ),
      ),
    );
  }
}

class _AlwaysScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) =>
      child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();
}
