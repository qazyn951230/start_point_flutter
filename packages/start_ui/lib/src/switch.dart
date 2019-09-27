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

//import 'dart:ui' show lerpDouble;
//
//import 'package:flutter/foundation.dart';
//import 'package:flutter/gestures.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter/widgets.dart';
//import 'package:flutter/services.dart';
//
//import 'colors.dart';
//import 'thumb_painter.dart';
//
//class Switch extends StatefulWidget {
//  const Switch({
//    Key key,
//    @required this.value,
//    @required this.onChanged,
//    this.activeColor,
//    this.dragStartBehavior = DragStartBehavior.start,
//  })  : assert(value != null),
//        assert(dragStartBehavior != null),
//        super(key: key);
//
//  final bool value;
//
//  final ValueChanged<bool> onChanged;
//
//  final Color activeColor;
//
//  final DragStartBehavior dragStartBehavior;
//
//  @override
//  _SwitchState createState() => _SwitchState();
//
//  @override
//  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//    super.debugFillProperties(properties);
//    properties.add(FlagProperty('value',
//        value: value, ifTrue: 'on', ifFalse: 'off', showName: true));
//    properties.add(ObjectFlagProperty<ValueChanged<bool>>(
//        'onChanged', onChanged,
//        ifNull: 'disabled'));
//  }
//}
//
//class _SwitchState extends State<Switch> with TickerProviderStateMixin {
//  @override
//  Widget build(BuildContext context) {
//    return Opacity(
//      opacity: widget.onChanged == null ? _kSwitchDisabledOpacity : 1.0,
//      child: _SwitchRenderObjectWidget(
//        value: widget.value,
//        activeColor: widget.activeColor ?? Colors.activeGreen,
//        onChanged: widget.onChanged,
//        vsync: this,
//        dragStartBehavior: widget.dragStartBehavior,
//      ),
//    );
//  }
//}
//
//class _SwitchRenderObjectWidget extends LeafRenderObjectWidget {
//  const _SwitchRenderObjectWidget({
//    Key key,
//    this.value,
//    this.activeColor,
//    this.onChanged,
//    this.vsync,
//    this.dragStartBehavior = DragStartBehavior.start,
//  }) : super(key: key);
//
//  final bool value;
//  final Color activeColor;
//  final ValueChanged<bool> onChanged;
//  final TickerProvider vsync;
//  final DragStartBehavior dragStartBehavior;
//
//  @override
//  _RenderSwitch createRenderObject(BuildContext context) {
//    return _RenderSwitch(
//      value: value,
//      activeColor: activeColor,
//      onChanged: onChanged,
//      textDirection: Directionality.of(context),
//      vsync: vsync,
//      dragStartBehavior: dragStartBehavior,
//    );
//  }
//
//  @override
//  void updateRenderObject(BuildContext context, _RenderSwitch renderObject) {
//    renderObject
//      ..value = value
//      ..activeColor = activeColor
//      ..onChanged = onChanged
//      ..textDirection = Directionality.of(context)
//      ..vsync = vsync
//      ..dragStartBehavior = dragStartBehavior;
//  }
//}
//
//const double _kTrackWidth = 51.0;
//const double _kTrackHeight = 31.0;
//const double _kTrackRadius = _kTrackHeight / 2.0;
//const double _kTrackInnerStart = _kTrackHeight / 2.0;
//const double _kTrackInnerEnd = _kTrackWidth - _kTrackInnerStart;
//const double _kTrackInnerLength = _kTrackInnerEnd - _kTrackInnerStart;
//const double _kSwitchWidth = 59.0;
//const double _kSwitchHeight = 39.0;
//// Opacity of a disabled switch, as eye-balled from iOS Simulator on Mac.
//const double _kSwitchDisabledOpacity = 0.5;
//
//const Color _kTrackColor = Colors.lightBackgroundGray;
//const Duration _kReactionDuration = Duration(milliseconds: 300);
//const Duration _kToggleDuration = Duration(milliseconds: 200);
//
//class _RenderSwitch extends RenderConstrainedBox {
//  _RenderSwitch({
//    @required bool value,
//    @required Color activeColor,
//    ValueChanged<bool> onChanged,
//    @required TextDirection textDirection,
//    @required TickerProvider vsync,
//    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
//  })  : assert(value != null),
//        assert(activeColor != null),
//        assert(vsync != null),
//        _value = value,
//        _activeColor = activeColor,
//        _onChanged = onChanged,
//        _textDirection = textDirection,
//        _vsync = vsync,
//        super(
//            additionalConstraints: const BoxConstraints.tightFor(
//                width: _kSwitchWidth, height: _kSwitchHeight)) {
//    _tap = TapGestureRecognizer()
//      ..onTapDown = _handleTapDown
//      ..onTap = _handleTap
//      ..onTapUp = _handleTapUp
//      ..onTapCancel = _handleTapCancel;
//    _drag = HorizontalDragGestureRecognizer()
//      ..onStart = _handleDragStart
//      ..onUpdate = _handleDragUpdate
//      ..onEnd = _handleDragEnd
//      ..dragStartBehavior = dragStartBehavior;
//    _positionController = AnimationController(
//      duration: _kToggleDuration,
//      value: value ? 1.0 : 0.0,
//      vsync: vsync,
//    );
//    _position = CurvedAnimation(
//      parent: _positionController,
//      curve: Curves.linear,
//    )
//      ..addListener(markNeedsPaint)
//      ..addStatusListener(_handlePositionStateChanged);
//    _reactionController = AnimationController(
//      duration: _kReactionDuration,
//      vsync: vsync,
//    );
//    _reaction = CurvedAnimation(
//      parent: _reactionController,
//      curve: Curves.ease,
//    )..addListener(markNeedsPaint);
//  }
//
//  AnimationController _positionController;
//  CurvedAnimation _position;
//
//  AnimationController _reactionController;
//  Animation<double> _reaction;
//
//  bool get value => _value;
//  bool _value;
//  set value(bool value) {
//    assert(value != null);
//    if (value == _value) return;
//    _value = value;
//    markNeedsSemanticsUpdate();
//    _position
//      ..curve = Curves.ease
//      ..reverseCurve = Curves.ease.flipped;
//    if (value)
//      _positionController.forward();
//    else
//      _positionController.reverse();
//  }
//
//  TickerProvider get vsync => _vsync;
//  TickerProvider _vsync;
//  set vsync(TickerProvider value) {
//    assert(value != null);
//    if (value == _vsync) return;
//    _vsync = value;
//    _positionController.resync(vsync);
//    _reactionController.resync(vsync);
//  }
//
//  Color get activeColor => _activeColor;
//  Color _activeColor;
//  set activeColor(Color value) {
//    assert(value != null);
//    if (value == _activeColor) return;
//    _activeColor = value;
//    markNeedsPaint();
//  }
//
//  ValueChanged<bool> get onChanged => _onChanged;
//  ValueChanged<bool> _onChanged;
//  set onChanged(ValueChanged<bool> value) {
//    if (value == _onChanged) return;
//    final bool wasInteractive = isInteractive;
//    _onChanged = value;
//    if (wasInteractive != isInteractive) {
//      markNeedsPaint();
//      markNeedsSemanticsUpdate();
//    }
//  }
//
//  TextDirection get textDirection => _textDirection;
//  TextDirection _textDirection;
//  set textDirection(TextDirection value) {
//    assert(value != null);
//    if (_textDirection == value) return;
//    _textDirection = value;
//    markNeedsPaint();
//  }
//
//  DragStartBehavior get dragStartBehavior => _drag.dragStartBehavior;
//  set dragStartBehavior(DragStartBehavior value) {
//    assert(value != null);
//    if (_drag.dragStartBehavior == value) return;
//    _drag.dragStartBehavior = value;
//  }
//
//  bool get isInteractive => onChanged != null;
//
//  TapGestureRecognizer _tap;
//  HorizontalDragGestureRecognizer _drag;
//
//  @override
//  void attach(PipelineOwner owner) {
//    super.attach(owner);
//    if (value)
//      _positionController.forward();
//    else
//      _positionController.reverse();
//    if (isInteractive) {
//      switch (_reactionController.status) {
//        case AnimationStatus.forward:
//          _reactionController.forward();
//          break;
//        case AnimationStatus.reverse:
//          _reactionController.reverse();
//          break;
//        case AnimationStatus.dismissed:
//        case AnimationStatus.completed:
//          // nothing to do
//          break;
//      }
//    }
//  }
//
//  @override
//  void detach() {
//    _positionController.stop();
//    _reactionController.stop();
//    super.detach();
//  }
//
//  void _handlePositionStateChanged(AnimationStatus status) {
//    if (isInteractive) {
//      if (status == AnimationStatus.completed && !_value)
//        onChanged(true);
//      else if (status == AnimationStatus.dismissed && _value) onChanged(false);
//    }
//  }
//
//  void _handleTapDown(TapDownDetails details) {
//    if (isInteractive) _reactionController.forward();
//  }
//
//  void _handleTap() {
//    if (isInteractive) {
//      onChanged(!_value);
//      _emitVibration();
//    }
//  }
//
//  void _handleTapUp(TapUpDetails details) {
//    if (isInteractive) _reactionController.reverse();
//  }
//
//  void _handleTapCancel() {
//    if (isInteractive) _reactionController.reverse();
//  }
//
//  void _handleDragStart(DragStartDetails details) {
//    if (isInteractive) {
//      _reactionController.forward();
//      _emitVibration();
//    }
//  }
//
//  void _handleDragUpdate(DragUpdateDetails details) {
//    if (isInteractive) {
//      _position
//        ..curve = null
//        ..reverseCurve = null;
//      final double delta = details.primaryDelta / _kTrackInnerLength;
//      switch (textDirection) {
//        case TextDirection.rtl:
//          _positionController.value -= delta;
//          break;
//        case TextDirection.ltr:
//          _positionController.value += delta;
//          break;
//      }
//    }
//  }
//
//  void _handleDragEnd(DragEndDetails details) {
//    if (_position.value >= 0.5)
//      _positionController.forward();
//    else
//      _positionController.reverse();
//    _reactionController.reverse();
//  }
//
//  void _emitVibration() {
//    switch (defaultTargetPlatform) {
//      case TargetPlatform.iOS:
//        HapticFeedback.lightImpact();
//        break;
//      case TargetPlatform.fuchsia:
//      case TargetPlatform.android:
//        break;
//    }
//  }
//
//  @override
//  bool hitTestSelf(Offset position) => true;
//
//  @override
//  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
//    assert(debugHandleEvent(event, entry));
//    if (event is PointerDownEvent && isInteractive) {
//      _drag.addPointer(event);
//      _tap.addPointer(event);
//    }
//  }
//
//  @override
//  void describeSemanticsConfiguration(SemanticsConfiguration config) {
//    super.describeSemanticsConfiguration(config);
//
//    if (isInteractive) config.onTap = _handleTap;
//
//    config.isEnabled = isInteractive;
//    config.isToggled = _value;
//  }
//
//  final ThumbPainter _thumbPainter = ThumbPainter();
//
//  @override
//  void paint(PaintingContext context, Offset offset) {
//    final Canvas canvas = context.canvas;
//
//    final double currentValue = _position.value;
//    final double currentReactionValue = _reaction.value;
//
//    double visualPosition;
//    switch (textDirection) {
//      case TextDirection.rtl:
//        visualPosition = 1.0 - currentValue;
//        break;
//      case TextDirection.ltr:
//        visualPosition = currentValue;
//        break;
//    }
//
//    final Paint paint = Paint()
//      ..color = Color.lerp(_kTrackColor, activeColor, currentValue);
//
//    final Rect trackRect = Rect.fromLTWH(
//      offset.dx + (size.width - _kTrackWidth) / 2.0,
//      offset.dy + (size.height - _kTrackHeight) / 2.0,
//      _kTrackWidth,
//      _kTrackHeight,
//    );
//    final RRect trackRRect = RRect.fromRectAndRadius(
//        trackRect, const Radius.circular(_kTrackRadius));
//    canvas.drawRRect(trackRRect, paint);
//
//    final double currentThumbExtension =
//        ThumbPainter.extension * currentReactionValue;
//    final double thumbLeft = lerpDouble(
//      trackRect.left + _kTrackInnerStart - ThumbPainter.radius,
//      trackRect.left +
//          _kTrackInnerEnd -
//          ThumbPainter.radius -
//          currentThumbExtension,
//      visualPosition,
//    );
//    final double thumbRight = lerpDouble(
//      trackRect.left +
//          _kTrackInnerStart +
//          ThumbPainter.radius +
//          currentThumbExtension,
//      trackRect.left + _kTrackInnerEnd + ThumbPainter.radius,
//      visualPosition,
//    );
//    final double thumbCenterY = offset.dy + size.height / 2.0;
//    final Rect thumbBounds = Rect.fromLTRB(
//      thumbLeft,
//      thumbCenterY - ThumbPainter.radius,
//      thumbRight,
//      thumbCenterY + ThumbPainter.radius,
//    );
//
//    context
//        .pushClipRRect(needsCompositing, Offset.zero, thumbBounds, trackRRect,
//            (PaintingContext innerContext, Offset offset) {
//      _thumbPainter.paint(innerContext.canvas, thumbBounds);
//    });
//  }
//
//  @override
//  void debugFillProperties(DiagnosticPropertiesBuilder description) {
//    super.debugFillProperties(description);
//    description.add(FlagProperty('value',
//        value: value, ifTrue: 'checked', ifFalse: 'unchecked', showName: true));
//    description.add(FlagProperty('isInteractive',
//        value: isInteractive,
//        ifTrue: 'enabled',
//        ifFalse: 'disabled',
//        showName: true,
//        defaultValue: true));
//  }
//}
