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

import 'dart:async';
import 'dart:math';
import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart' show Curves;

const double _kBackGestureWidth = 20.0;
const double _kMinFlingVelocity = 1.0;
const int _kMaxDroppedSwipePageForwardAnimationTime = 800;
const int _kMaxPageBackAnimationTime = 300;
const Color _kModalBarrierColor = Color(0x6604040F);
const Duration _kModalPopupTransitionDuration = Duration(milliseconds: 335);

final Animatable<Offset> _kRightMiddleTween = Tween<Offset>(
  begin: const Offset(1.0, 0.0),
  end: Offset.zero,
);

final Animatable<Offset> _kMiddleLeftTween = Tween<Offset>(
  begin: Offset.zero,
  end: const Offset(-1.0 / 3.0, 0.0),
);

final Animatable<Offset> _kBottomUpTween = Tween<Offset>(
  begin: const Offset(0.0, 1.0),
  end: Offset.zero,
);

final DecorationTween _kGradientShadowTween = DecorationTween(
  begin: _EdgeShadowDecoration.none,
  end: const _EdgeShadowDecoration(
    edgeGradient: LinearGradient(
      begin: AlignmentDirectional(0.90, 0.0),
      end: AlignmentDirectional.centerEnd,
      colors: <Color>[
        Color(0x00000000),
        Color(0x04000000),
        Color(0x12000000),
        Color(0x38000000),
      ],
      stops: <double>[0.0, 0.3, 0.6, 1.0],
    ),
  ),
);

class UIPageRoute<T> extends PageRoute<T> {
  UIPageRoute({
    @required this.builder,
    this.title,
    RouteSettings settings,
    this.maintainState = true,
    bool fullscreenDialog = false,
  })  : assert(builder != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        assert(opaque),
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder builder;

  final String title;

  ValueNotifier<String> _previousTitle;

  ValueListenable<String> get previousTitle {
    assert(
      _previousTitle != null,
      'Cannot read the previousTitle for a route that has not yet been installed',
    );
    return _previousTitle;
  }

  @override
  void didChangePrevious(Route<dynamic> previousRoute) {
    final String previousTitleString =
        previousRoute is UIPageRoute ? previousRoute.title : null;
    if (_previousTitle == null) {
      _previousTitle = ValueNotifier<String>(previousTitleString);
    } else {
      _previousTitle.value = previousTitleString;
    }
    super.didChangePrevious(previousRoute);
  }

  @override
  final bool maintainState;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) {
    return previousRoute is UIPageRoute;
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    return nextRoute is UIPageRoute && !nextRoute.fullscreenDialog;
  }

  static bool isPopGestureInProgress(PageRoute<dynamic> route) {
    return route.navigator.userGestureInProgress;
  }

  bool get popGestureInProgress => isPopGestureInProgress(this);
  bool get popGestureEnabled => _isPopGestureEnabled(this);

  static bool _isPopGestureEnabled<T>(PageRoute<T> route) {
    if (route.isFirst) return false;
    if (route.willHandlePopInternally) return false;
    if (route.hasScopedWillPopCallback) return false;
    if (route.fullscreenDialog) return false;
    if (route.animation.status != AnimationStatus.completed) return false;
    if (route.secondaryAnimation.status != AnimationStatus.dismissed)
      return false;
    if (isPopGestureInProgress(route)) return false;
    return true;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final result = Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: builder(context),
    );
    assert(() {
      if (result == null) {
        throw FlutterError(
            'The builder for route "${settings.name}" returned null.\n'
            'Route builders must never return null.');
      }
      return true;
    }());
    return result;
  }

  static _BackGestureController<T> _startPopGesture<T>(PageRoute<T> route) {
    assert(_isPopGestureEnabled(route));
    return _BackGestureController<T>(
      navigator: route.navigator,
      controller: route.controller,
    );
  }

  static Widget buildPageTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.fullscreenDialog) {
      return FullscreenDialogTransition(
        animation: animation,
        child: child,
      );
    } else {
      return PageTransition(
        primaryRouteAnimation: animation,
        secondaryRouteAnimation: secondaryAnimation,
        linearTransition: isPopGestureInProgress(route),
        child: _BackGestureDetector<T>(
          enabledCallback: () => _isPopGestureEnabled<T>(route),
          onStartPopGesture: () => _startPopGesture<T>(route),
          child: child,
        ),
      );
    }
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return buildPageTransitions<T>(
      this,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';
}

class PageTransition extends StatelessWidget {
  PageTransition({
    Key key,
    @required Animation<double> primaryRouteAnimation,
    @required Animation<double> secondaryRouteAnimation,
    @required this.child,
    @required bool linearTransition,
  })  : assert(linearTransition != null),
        _primaryPositionAnimation = (linearTransition
                ? primaryRouteAnimation
                : CurvedAnimation(
                    parent: primaryRouteAnimation,
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.easeInToLinear,
                  ))
            .drive(_kRightMiddleTween),
        _secondaryPositionAnimation = (linearTransition
                ? secondaryRouteAnimation
                : CurvedAnimation(
                    parent: secondaryRouteAnimation,
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.easeInToLinear,
                  ))
            .drive(_kMiddleLeftTween),
        _primaryShadowAnimation = (linearTransition
                ? primaryRouteAnimation
                : CurvedAnimation(
                    parent: primaryRouteAnimation,
                    curve: Curves.linearToEaseOut,
                  ))
            .drive(_kGradientShadowTween),
        super(key: key);

  final Animation<Offset> _primaryPositionAnimation;
  final Animation<Offset> _secondaryPositionAnimation;
  final Animation<Decoration> _primaryShadowAnimation;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    final TextDirection textDirection = Directionality.of(context);
    return SlideTransition(
      position: _secondaryPositionAnimation,
      textDirection: textDirection,
      transformHitTests: false,
      child: SlideTransition(
        position: _primaryPositionAnimation,
        textDirection: textDirection,
        child: DecoratedBoxTransition(
          decoration: _primaryShadowAnimation,
          child: child,
        ),
      ),
    );
  }
}

class FullscreenDialogTransition extends StatelessWidget {
  FullscreenDialogTransition({
    Key key,
    @required Animation<double> animation,
    @required this.child,
  })  : _positionAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.linearToEaseOut,
          reverseCurve: Curves.linearToEaseOut.flipped,
        ).drive(_kBottomUpTween),
        super(key: key);

  final Animation<Offset> _positionAnimation;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _positionAnimation,
      child: child,
    );
  }
}

class _BackGestureDetector<T> extends StatefulWidget {
  const _BackGestureDetector({
    Key key,
    @required this.enabledCallback,
    @required this.onStartPopGesture,
    @required this.child,
  })  : assert(enabledCallback != null),
        assert(onStartPopGesture != null),
        assert(child != null),
        super(key: key);

  final Widget child;

  final ValueGetter<bool> enabledCallback;

  final ValueGetter<_BackGestureController<T>> onStartPopGesture;

  @override
  _BackGestureDetectorState<T> createState() => _BackGestureDetectorState<T>();
}

class _BackGestureDetectorState<T> extends State<_BackGestureDetector<T>> {
  _BackGestureController<T> _backGestureController;

  HorizontalDragGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = HorizontalDragGestureRecognizer(debugOwner: this)
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..onEnd = _handleDragEnd
      ..onCancel = _handleDragCancel;
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    assert(mounted);
    assert(_backGestureController == null);
    _backGestureController = widget.onStartPopGesture();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    assert(mounted);
    assert(_backGestureController != null);
    _backGestureController.dragUpdate(
        _convertToLogical(details.primaryDelta / context.size.width));
  }

  void _handleDragEnd(DragEndDetails details) {
    assert(mounted);
    assert(_backGestureController != null);
    _backGestureController.dragEnd(_convertToLogical(
        details.velocity.pixelsPerSecond.dx / context.size.width));
    _backGestureController = null;
  }

  void _handleDragCancel() {
    assert(mounted);
    _backGestureController?.dragEnd(0.0);
    _backGestureController = null;
  }

  void _handlePointerDown(PointerDownEvent event) {
    if (widget.enabledCallback()) _recognizer.addPointer(event);
  }

  double _convertToLogical(double value) {
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        return -value;
      case TextDirection.ltr:
        return value;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    double dragAreaWidth = Directionality.of(context) == TextDirection.ltr
        ? MediaQuery.of(context).padding.left
        : MediaQuery.of(context).padding.right;
    dragAreaWidth = max(dragAreaWidth, _kBackGestureWidth);
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        widget.child,
        PositionedDirectional(
          start: 0.0,
          width: dragAreaWidth,
          top: 0.0,
          bottom: 0.0,
          child: Listener(
            onPointerDown: _handlePointerDown,
            behavior: HitTestBehavior.translucent,
          ),
        ),
      ],
    );
  }
}

class _BackGestureController<T> {
  _BackGestureController({
    @required this.navigator,
    @required this.controller,
  })  : assert(navigator != null),
        assert(controller != null) {
    navigator.didStartUserGesture();
  }

  final AnimationController controller;
  final NavigatorState navigator;

  void dragUpdate(double delta) {
    controller.value -= delta;
  }

  void dragEnd(double velocity) {
    const Curve animationCurve = Curves.fastLinearToSlowEaseIn;
    bool animateForward;
    if (velocity.abs() >= _kMinFlingVelocity)
      animateForward = velocity <= 0;
    else {
      animateForward = controller.value > 0.5;
    }
    if (animateForward) {
      final int droppedPageForwardAnimationTime = min(
        lerpDouble(
          _kMaxDroppedSwipePageForwardAnimationTime,
          0,
          controller.value,
        ).floor(),
        _kMaxPageBackAnimationTime,
      );
      controller.animateTo(
        1.0,
        duration: Duration(milliseconds: droppedPageForwardAnimationTime),
        curve: animationCurve,
      );
    } else {
      navigator.pop();
      if (controller.isAnimating) {
        final int droppedPageBackAnimationTime = lerpDouble(
          0,
          _kMaxDroppedSwipePageForwardAnimationTime,
          controller.value,
        ).floor();
        controller.animateBack(
          0.0,
          duration: Duration(milliseconds: droppedPageBackAnimationTime),
          curve: animationCurve,
        );
      }
    }
    if (controller.isAnimating) {
      AnimationStatusListener animationStatusCallback;
      animationStatusCallback = (AnimationStatus status) {
        navigator.didStopUserGesture();
        controller.removeStatusListener(animationStatusCallback);
      };
      controller.addStatusListener(animationStatusCallback);
    } else {
      navigator.didStopUserGesture();
    }
  }
}

class _EdgeShadowDecoration extends Decoration {
  const _EdgeShadowDecoration({this.edgeGradient});

  static const _EdgeShadowDecoration none = _EdgeShadowDecoration();

  final LinearGradient edgeGradient;

  static _EdgeShadowDecoration lerp(
    _EdgeShadowDecoration a,
    _EdgeShadowDecoration b,
    double t,
  ) {
    assert(t != null);
    if (a == null && b == null) return null;
    return _EdgeShadowDecoration(
      edgeGradient: LinearGradient.lerp(a?.edgeGradient, b?.edgeGradient, t),
    );
  }

  @override
  _EdgeShadowDecoration lerpFrom(Decoration a, double t) {
    if (a is! _EdgeShadowDecoration)
      return _EdgeShadowDecoration.lerp(null, this, t);
    return _EdgeShadowDecoration.lerp(a, this, t);
  }

  @override
  _EdgeShadowDecoration lerpTo(Decoration b, double t) {
    if (b is! _EdgeShadowDecoration)
      return _EdgeShadowDecoration.lerp(this, null, t);
    return _EdgeShadowDecoration.lerp(this, b, t);
  }

  @override
  _EdgeShadowPainter createBoxPainter([VoidCallback onChanged]) {
    return _EdgeShadowPainter(this, onChanged);
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final _EdgeShadowDecoration typedOther = other;
    return edgeGradient == typedOther.edgeGradient;
  }

  @override
  int get hashCode => edgeGradient.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<LinearGradient>('edgeGradient', edgeGradient),
    );
  }
}

class _EdgeShadowPainter extends BoxPainter {
  _EdgeShadowPainter(
    this._decoration,
    VoidCallback onChange,
  )   : assert(_decoration != null),
        super(onChange);

  final _EdgeShadowDecoration _decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final LinearGradient gradient = _decoration.edgeGradient;
    if (gradient == null) return;
    final TextDirection textDirection = configuration.textDirection;
    assert(textDirection != null);
    double deltaX;
    switch (textDirection) {
      case TextDirection.rtl:
        deltaX = configuration.size.width;
        break;
      case TextDirection.ltr:
        deltaX = -configuration.size.width;
        break;
    }
    final Rect rect = (offset & configuration.size).translate(deltaX, 0.0);
    final Paint paint = Paint()
      ..shader = gradient.createShader(rect, textDirection: textDirection);
    canvas.drawRect(rect, paint);
  }
}

class _ModalPopupRoute<T> extends PopupRoute<T> {
  _ModalPopupRoute({
    this.builder,
    this.barrierLabel,
    RouteSettings settings,
  }) : super(settings: settings);

  final WidgetBuilder builder;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => _kModalBarrierColor;

  @override
  bool get barrierDismissible => true;

  @override
  bool get semanticsDismissible => false;

  @override
  Duration get transitionDuration => _kModalPopupTransitionDuration;

  Animation<double> _animation;

  Tween<Offset> _offsetTween;

  @override
  Animation<double> createAnimation() {
    assert(_animation == null);
    _animation = CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.linearToEaseOut.flipped,
    );
    _offsetTween = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    );
    return _animation;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionalTranslation(
        translation: _offsetTween.evaluate(_animation),
        child: child,
      ),
    );
  }
}

Future<T> showModalPopup<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
}) {
  return Navigator.of(context, rootNavigator: true).push(
    _ModalPopupRoute<T>(
      builder: builder,
      barrierLabel: 'Dismiss',
    ),
  );
}

final Animatable<double> _dialogScaleTween = Tween<double>(begin: 1.3, end: 1.0)
    .chain(CurveTween(curve: Curves.linearToEaseOut));

Widget _buildDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  final CurvedAnimation fadeAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOut,
  );
  if (animation.status == AnimationStatus.reverse) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: child,
    );
  }
  return FadeTransition(
    opacity: fadeAnimation,
    child: ScaleTransition(
      child: child,
      scale: animation.drive(_dialogScaleTween),
    ),
  );
}

Future<T> showDialog<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
}) {
  assert(builder != null);
  return showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: _kModalBarrierColor,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return builder(context);
    },
    transitionBuilder: _buildDialogTransitions,
  );
}
