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
//import 'dart:ui' show lerpDouble;
//
//import 'package:flutter/gestures.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter/widgets.dart';
//
//import 'theme.dart';
//import 'thumb_painter.dart';
//
//// Examples can assume:
//// int _SliderValue = 1;
//// void setState(VoidCallback fn) { }
//
//class Slider extends StatefulWidget {
//  const Slider({
//    Key key,
//    @required this.value,
//    @required this.onChanged,
//    this.onChangeStart,
//    this.onChangeEnd,
//    this.min = 0.0,
//    this.max = 1.0,
//    this.divisions,
//    this.activeColor,
//  })  : assert(value != null),
//        assert(min != null),
//        assert(max != null),
//        assert(value >= min && value <= max),
//        assert(divisions == null || divisions > 0),
//        super(key: key);
//
//  final double value;
//
//  final ValueChanged<double> onChanged;
//
//  final ValueChanged<double> onChangeStart;
//
//  final ValueChanged<double> onChangeEnd;
//
//  final double min;
//
//  final double max;
//
//  final int divisions;
//
//  final Color activeColor;
//
//  @override
//  _SliderState createState() => _SliderState();
//
//  @override
//  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//    super.debugFillProperties(properties);
//    properties.add(DoubleProperty('value', value));
//    properties.add(DoubleProperty('min', min));
//    properties.add(DoubleProperty('max', max));
//  }
//}
//
//class _SliderState extends State<Slider> with TickerProviderStateMixin {
//  void _handleChanged(double value) {
//    assert(widget.onChanged != null);
//    final double lerpValue = lerpDouble(widget.min, widget.max, value);
//    if (lerpValue != widget.value) {
//      widget.onChanged(lerpValue);
//    }
//  }
//
//  void _handleDragStart(double value) {
//    assert(widget.onChangeStart != null);
//    widget.onChangeStart(lerpDouble(widget.min, widget.max, value));
//  }
//
//  void _handleDragEnd(double value) {
//    assert(widget.onChangeEnd != null);
//    widget.onChangeEnd(lerpDouble(widget.min, widget.max, value));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return _SliderRenderObjectWidget(
//      value: (widget.value - widget.min) / (widget.max - widget.min),
//      divisions: widget.divisions,
//      activeColor: widget.activeColor ?? Theme.of(context).primaryColor,
//      onChanged: widget.onChanged != null ? _handleChanged : null,
//      onChangeStart: widget.onChangeStart != null ? _handleDragStart : null,
//      onChangeEnd: widget.onChangeEnd != null ? _handleDragEnd : null,
//      vsync: this,
//    );
//  }
//}
//
//class _SliderRenderObjectWidget extends LeafRenderObjectWidget {
//  const _SliderRenderObjectWidget({
//    Key key,
//    this.value,
//    this.divisions,
//    this.activeColor,
//    this.onChanged,
//    this.onChangeStart,
//    this.onChangeEnd,
//    this.vsync,
//  }) : super(key: key);
//
//  final double value;
//  final int divisions;
//  final Color activeColor;
//  final ValueChanged<double> onChanged;
//  final ValueChanged<double> onChangeStart;
//  final ValueChanged<double> onChangeEnd;
//  final TickerProvider vsync;
//
//  @override
//  _RenderSlider createRenderObject(BuildContext context) {
//    return _RenderSlider(
//      value: value,
//      divisions: divisions,
//      activeColor: activeColor,
//      onChanged: onChanged,
//      onChangeStart: onChangeStart,
//      onChangeEnd: onChangeEnd,
//      vsync: vsync,
//      textDirection: Directionality.of(context),
//    );
//  }
//
//  @override
//  void updateRenderObject(BuildContext context, _RenderSlider renderObject) {
//    renderObject
//      ..value = value
//      ..divisions = divisions
//      ..activeColor = activeColor
//      ..onChanged = onChanged
//      ..onChangeStart = onChangeStart
//      ..onChangeEnd = onChangeEnd
//      ..textDirection = Directionality.of(context);
//    // Ticker provider cannot change since there's a 1:1 relationship between
//    // the _SliderRenderObjectWidget object and the _SliderState object.
//  }
//}
//
//const double _kPadding = 8.0;
//const Color _kTrackColor = Color(0xFFB5B5B5);
//const double _kSliderHeight = 2.0 * (ThumbPainter.radius + _kPadding);
//const double _kSliderWidth = 176.0; // Matches Material Design slider.
//const Duration _kDiscreteTransitionDuration = Duration(milliseconds: 500);
//
//const double _kAdjustmentUnit =
//    0.1; // Matches iOS implementation of material slider.
//
//class _RenderSlider extends RenderConstrainedBox {
//  _RenderSlider({
//    @required double value,
//    int divisions,
//    Color activeColor,
//    ValueChanged<double> onChanged,
//    this.onChangeStart,
//    this.onChangeEnd,
//    TickerProvider vsync,
//    @required TextDirection textDirection,
//  })  : assert(value != null && value >= 0.0 && value <= 1.0),
//        assert(textDirection != null),
//        _value = value,
//        _divisions = divisions,
//        _activeColor = activeColor,
//        _onChanged = onChanged,
//        _textDirection = textDirection,
//        super(
//            additionalConstraints: const BoxConstraints.tightFor(
//                width: _kSliderWidth, height: _kSliderHeight)) {
//    _drag = HorizontalDragGestureRecognizer()
//      ..onStart = _handleDragStart
//      ..onUpdate = _handleDragUpdate
//      ..onEnd = _handleDragEnd;
//    _position = AnimationController(
//      value: value,
//      duration: _kDiscreteTransitionDuration,
//      vsync: vsync,
//    )..addListener(markNeedsPaint);
//  }
//
//  double get value => _value;
//  double _value;
//  set value(double newValue) {
//    assert(newValue != null && newValue >= 0.0 && newValue <= 1.0);
//    if (newValue == _value) return;
//    _value = newValue;
//    if (divisions != null)
//      _position.animateTo(newValue, curve: Curves.fastOutSlowIn);
//    else
//      _position.value = newValue;
//    markNeedsSemanticsUpdate();
//  }
//
//  int get divisions => _divisions;
//  int _divisions;
//  set divisions(int value) {
//    if (value == _divisions) return;
//    _divisions = value;
//    markNeedsPaint();
//  }
//
//  Color get activeColor => _activeColor;
//  Color _activeColor;
//  set activeColor(Color value) {
//    if (value == _activeColor) return;
//    _activeColor = value;
//    markNeedsPaint();
//  }
//
//  ValueChanged<double> get onChanged => _onChanged;
//  ValueChanged<double> _onChanged;
//  set onChanged(ValueChanged<double> value) {
//    if (value == _onChanged) return;
//    final bool wasInteractive = isInteractive;
//    _onChanged = value;
//    if (wasInteractive != isInteractive) markNeedsSemanticsUpdate();
//  }
//
//  ValueChanged<double> onChangeStart;
//  ValueChanged<double> onChangeEnd;
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
//  AnimationController _position;
//
//  HorizontalDragGestureRecognizer _drag;
//  double _currentDragValue = 0.0;
//
//  double get _discretizedCurrentDragValue {
//    double dragValue = _currentDragValue.clamp(0.0, 1.0);
//    if (divisions != null)
//      dragValue = (dragValue * divisions).round() / divisions;
//    return dragValue;
//  }
//
//  double get _trackLeft => _kPadding;
//  double get _trackRight => size.width - _kPadding;
//  double get _thumbCenter {
//    double visualPosition;
//    switch (textDirection) {
//      case TextDirection.rtl:
//        visualPosition = 1.0 - _value;
//        break;
//      case TextDirection.ltr:
//        visualPosition = _value;
//        break;
//    }
//    return lerpDouble(_trackLeft + ThumbPainter.radius,
//        _trackRight - ThumbPainter.radius, visualPosition);
//  }
//
//  bool get isInteractive => onChanged != null;
//
//  void _handleDragStart(DragStartDetails details) =>
//      _startInteraction(details.globalPosition);
//
//  void _handleDragUpdate(DragUpdateDetails details) {
//    if (isInteractive) {
//      final double extent = math.max(
//          _kPadding, size.width - 2.0 * (_kPadding + ThumbPainter.radius));
//      final double valueDelta = details.primaryDelta / extent;
//      switch (textDirection) {
//        case TextDirection.rtl:
//          _currentDragValue -= valueDelta;
//          break;
//        case TextDirection.ltr:
//          _currentDragValue += valueDelta;
//          break;
//      }
//      onChanged(_discretizedCurrentDragValue);
//    }
//  }
//
//  void _handleDragEnd(DragEndDetails details) => _endInteraction();
//
//  void _startInteraction(Offset globalPosition) {
//    if (isInteractive) {
//      if (onChangeStart != null) {
//        onChangeStart(_discretizedCurrentDragValue);
//      }
//      _currentDragValue = _value;
//      onChanged(_discretizedCurrentDragValue);
//    }
//  }
//
//  void _endInteraction() {
//    if (onChangeEnd != null) {
//      onChangeEnd(_discretizedCurrentDragValue);
//    }
//    _currentDragValue = 0.0;
//  }
//
//  @override
//  bool hitTestSelf(Offset position) {
//    return (position.dx - _thumbCenter).abs() < ThumbPainter.radius + _kPadding;
//  }
//
//  @override
//  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
//    assert(debugHandleEvent(event, entry));
//    if (event is PointerDownEvent && isInteractive) _drag.addPointer(event);
//  }
//
//  final ThumbPainter _thumbPainter = ThumbPainter();
//
//  @override
//  void paint(PaintingContext context, Offset offset) {
//    double visualPosition;
//    Color leftColor;
//    Color rightColor;
//    switch (textDirection) {
//      case TextDirection.rtl:
//        visualPosition = 1.0 - _position.value;
//        leftColor = _activeColor;
//        rightColor = _kTrackColor;
//        break;
//      case TextDirection.ltr:
//        visualPosition = _position.value;
//        leftColor = _kTrackColor;
//        rightColor = _activeColor;
//        break;
//    }
//
//    final double trackCenter = offset.dy + size.height / 2.0;
//    final double trackLeft = offset.dx + _trackLeft;
//    final double trackTop = trackCenter - 1.0;
//    final double trackBottom = trackCenter + 1.0;
//    final double trackRight = offset.dx + _trackRight;
//    final double trackActive = offset.dx + _thumbCenter;
//
//    final Canvas canvas = context.canvas;
//
//    if (visualPosition > 0.0) {
//      final Paint paint = Paint()..color = rightColor;
//      canvas.drawRRect(
//          RRect.fromLTRBXY(
//              trackLeft, trackTop, trackActive, trackBottom, 1.0, 1.0),
//          paint);
//    }
//
//    if (visualPosition < 1.0) {
//      final Paint paint = Paint()..color = leftColor;
//      canvas.drawRRect(
//          RRect.fromLTRBXY(
//              trackActive, trackTop, trackRight, trackBottom, 1.0, 1.0),
//          paint);
//    }
//
//    final Offset thumbCenter = Offset(trackActive, trackCenter);
//    _thumbPainter.paint(canvas,
//        Rect.fromCircle(center: thumbCenter, radius: ThumbPainter.radius));
//  }
//
//  @override
//  void describeSemanticsConfiguration(SemanticsConfiguration config) {
//    super.describeSemanticsConfiguration(config);
//
//    config.isSemanticBoundary = isInteractive;
//    if (isInteractive) {
//      config.textDirection = textDirection;
//      config.onIncrease = _increaseAction;
//      config.onDecrease = _decreaseAction;
//      config.value = '${(value * 100).round()}%';
//      config.increasedValue =
//          '${((value + _semanticActionUnit).clamp(0.0, 1.0) * 100).round()}%';
//      config.decreasedValue =
//          '${((value - _semanticActionUnit).clamp(0.0, 1.0) * 100).round()}%';
//    }
//  }
//
//  double get _semanticActionUnit =>
//      divisions != null ? 1.0 / divisions : _kAdjustmentUnit;
//
//  void _increaseAction() {
//    if (isInteractive) onChanged((value + _semanticActionUnit).clamp(0.0, 1.0));
//  }
//
//  void _decreaseAction() {
//    if (isInteractive) onChanged((value - _semanticActionUnit).clamp(0.0, 1.0));
//  }
//}
