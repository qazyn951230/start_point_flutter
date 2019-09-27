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

//import 'dart:collection';
//import 'dart:math' as math;
//
//import 'package:flutter/foundation.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter/widgets.dart';
//
//import 'theme.dart';
//
//// Minimum padding from edges of the segmented control to edges of
//// encompassing widget.
//const EdgeInsetsGeometry _kHorizontalItemPadding =
//    EdgeInsets.symmetric(horizontal: 16.0);
//
//// Minimum height of the segmented control.
//const double _kMinSegmentedControlHeight = 28.0;
//
//// The duration of the fade animation used to transition when a new widget
//// is selected.
//const Duration _kFadeDuration = Duration(milliseconds: 165);
//
//class SegmentedControl<T> extends StatefulWidget {
//  SegmentedControl({
//    Key key,
//    @required this.children,
//    @required this.onValueChanged,
//    this.groupValue,
//    this.unselectedColor,
//    this.selectedColor,
//    this.borderColor,
//    this.pressedColor,
//    this.padding,
//  })  : assert(children != null),
//        assert(children.length >= 2),
//        assert(onValueChanged != null),
//        assert(
//          groupValue == null ||
//              children.keys.any((T child) => child == groupValue),
//          'The groupValue must be either null or one of the keys in the children map.',
//        ),
//        super(key: key);
//
//  final Map<T, Widget> children;
//
//  final T groupValue;
//
//  final ValueChanged<T> onValueChanged;
//
//  final Color unselectedColor;
//
//  final Color selectedColor;
//
//  final Color borderColor;
//
//  final Color pressedColor;
//
//  final EdgeInsetsGeometry padding;
//
//  @override
//  _SegmentedControlState<T> createState() => _SegmentedControlState<T>();
//}
//
//class _SegmentedControlState<T> extends State<SegmentedControl<T>>
//    with TickerProviderStateMixin<SegmentedControl<T>> {
//  T _pressedKey;
//
//  final List<AnimationController> _selectionControllers =
//      <AnimationController>[];
//  final List<ColorTween> _childTweens = <ColorTween>[];
//
//  ColorTween _forwardBackgroundColorTween;
//  ColorTween _reverseBackgroundColorTween;
//  ColorTween _textColorTween;
//
//  Color _selectedColor;
//  Color _unselectedColor;
//  Color _borderColor;
//  Color _pressedColor;
//
//  AnimationController createAnimationController() {
//    return AnimationController(
//      duration: _kFadeDuration,
//      vsync: this,
//    )..addListener(() {
//        setState(() {
//          // State of background/text colors has changed
//        });
//      });
//  }
//
//  bool _updateColors() {
//    assert(mounted, 'This should only be called after didUpdateDependencies');
//    bool changed = false;
//    final Color selectedColor =
//        widget.selectedColor ?? Theme.of(context).primaryColor;
//    if (_selectedColor != selectedColor) {
//      changed = true;
//      _selectedColor = selectedColor;
//    }
//    final Color unselectedColor =
//        widget.unselectedColor ?? Theme.of(context).primaryContrastingColor;
//    if (_unselectedColor != unselectedColor) {
//      changed = true;
//      _unselectedColor = unselectedColor;
//    }
//    final Color borderColor =
//        widget.borderColor ?? Theme.of(context).primaryColor;
//    if (_borderColor != borderColor) {
//      changed = true;
//      _borderColor = borderColor;
//    }
//    final Color pressedColor =
//        widget.pressedColor ?? Theme.of(context).primaryColor.withOpacity(0.2);
//    if (_pressedColor != pressedColor) {
//      changed = true;
//      _pressedColor = pressedColor;
//    }
//
//    _forwardBackgroundColorTween = ColorTween(
//      begin: _pressedColor,
//      end: _selectedColor,
//    );
//    _reverseBackgroundColorTween = ColorTween(
//      begin: _unselectedColor,
//      end: _selectedColor,
//    );
//    _textColorTween = ColorTween(
//      begin: _selectedColor,
//      end: _unselectedColor,
//    );
//    return changed;
//  }
//
//  void _updateAnimationControllers() {
//    assert(mounted, 'This should only be called after didUpdateDependencies');
//    for (AnimationController controller in _selectionControllers) {
//      controller.dispose();
//    }
//    _selectionControllers.clear();
//    _childTweens.clear();
//
//    for (T key in widget.children.keys) {
//      final AnimationController animationController =
//          createAnimationController();
//      if (widget.groupValue == key) {
//        _childTweens.add(_reverseBackgroundColorTween);
//        animationController.value = 1.0;
//      } else {
//        _childTweens.add(_forwardBackgroundColorTween);
//      }
//      _selectionControllers.add(animationController);
//    }
//  }
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//
//    if (_updateColors()) {
//      _updateAnimationControllers();
//    }
//  }
//
//  @override
//  void didUpdateWidget(SegmentedControl<T> oldWidget) {
//    super.didUpdateWidget(oldWidget);
//
//    if (_updateColors() ||
//        oldWidget.children.length != widget.children.length) {
//      _updateAnimationControllers();
//    }
//
//    if (oldWidget.groupValue != widget.groupValue) {
//      int index = 0;
//      for (T key in widget.children.keys) {
//        if (widget.groupValue == key) {
//          _childTweens[index] = _forwardBackgroundColorTween;
//          _selectionControllers[index].forward();
//        } else {
//          _childTweens[index] = _reverseBackgroundColorTween;
//          _selectionControllers[index].reverse();
//        }
//        index += 1;
//      }
//    }
//  }
//
//  @override
//  void dispose() {
//    for (AnimationController animationController in _selectionControllers) {
//      animationController.dispose();
//    }
//    super.dispose();
//  }
//
//  void _onTapDown(T currentKey) {
//    if (_pressedKey == null && currentKey != widget.groupValue) {
//      setState(() {
//        _pressedKey = currentKey;
//      });
//    }
//  }
//
//  void _onTapCancel() {
//    setState(() {
//      _pressedKey = null;
//    });
//  }
//
//  void _onTap(T currentKey) {
//    if (currentKey != widget.groupValue && currentKey == _pressedKey) {
//      widget.onValueChanged(currentKey);
//      _pressedKey = null;
//    }
//  }
//
//  Color getTextColor(int index, T currentKey) {
//    if (_selectionControllers[index].isAnimating)
//      return _textColorTween.evaluate(_selectionControllers[index]);
//    if (widget.groupValue == currentKey) return _unselectedColor;
//    return _selectedColor;
//  }
//
//  Color getBackgroundColor(int index, T currentKey) {
//    if (_selectionControllers[index].isAnimating)
//      return _childTweens[index].evaluate(_selectionControllers[index]);
//    if (widget.groupValue == currentKey) return _selectedColor;
//    if (_pressedKey == currentKey) return _pressedColor;
//    return _unselectedColor;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final List<Widget> _gestureChildren = <Widget>[];
//    final List<Color> _backgroundColors = <Color>[];
//    int index = 0;
//    int selectedIndex;
//    int pressedIndex;
//    for (T currentKey in widget.children.keys) {
//      selectedIndex = (widget.groupValue == currentKey) ? index : selectedIndex;
//      pressedIndex = (_pressedKey == currentKey) ? index : pressedIndex;
//
//      final TextStyle textStyle = DefaultTextStyle.of(context).style.copyWith(
//            color: getTextColor(index, currentKey),
//          );
//      final IconThemeData iconTheme = IconThemeData(
//        color: getTextColor(index, currentKey),
//      );
//
//      Widget child = Center(
//        child: widget.children[currentKey],
//      );
//
//      child = GestureDetector(
//        onTapDown: (TapDownDetails event) {
//          _onTapDown(currentKey);
//        },
//        onTapCancel: _onTapCancel,
//        onTap: () {
//          _onTap(currentKey);
//        },
//        child: IconTheme(
//          data: iconTheme,
//          child: DefaultTextStyle(
//            style: textStyle,
//            child: Semantics(
//              button: true,
//              inMutuallyExclusiveGroup: true,
//              selected: widget.groupValue == currentKey,
//              child: child,
//            ),
//          ),
//        ),
//      );
//
//      _backgroundColors.add(getBackgroundColor(index, currentKey));
//      _gestureChildren.add(child);
//      index += 1;
//    }
//
//    final Widget box = _SegmentedControlRenderWidget<T>(
//      children: _gestureChildren,
//      selectedIndex: selectedIndex,
//      pressedIndex: pressedIndex,
//      backgroundColors: _backgroundColors,
//      borderColor: _borderColor,
//    );
//
//    return Padding(
//      padding: widget.padding ?? _kHorizontalItemPadding,
//      child: UnconstrainedBox(
//        constrainedAxis: Axis.horizontal,
//        child: box,
//      ),
//    );
//  }
//}
//
//class _SegmentedControlRenderWidget<T> extends MultiChildRenderObjectWidget {
//  _SegmentedControlRenderWidget({
//    Key key,
//    List<Widget> children = const <Widget>[],
//    @required this.selectedIndex,
//    @required this.pressedIndex,
//    @required this.backgroundColors,
//    @required this.borderColor,
//  }) : super(
//          key: key,
//          children: children,
//        );
//
//  final int selectedIndex;
//  final int pressedIndex;
//  final List<Color> backgroundColors;
//  final Color borderColor;
//
//  @override
//  RenderObject createRenderObject(BuildContext context) {
//    return _RenderSegmentedControl<T>(
//      textDirection: Directionality.of(context),
//      selectedIndex: selectedIndex,
//      pressedIndex: pressedIndex,
//      backgroundColors: backgroundColors,
//      borderColor: borderColor,
//    );
//  }
//
//  @override
//  void updateRenderObject(
//      BuildContext context, _RenderSegmentedControl<T> renderObject) {
//    renderObject
//      ..textDirection = Directionality.of(context)
//      ..selectedIndex = selectedIndex
//      ..pressedIndex = pressedIndex
//      ..backgroundColors = backgroundColors
//      ..borderColor = borderColor;
//  }
//}
//
//class _SegmentedControlContainerBoxParentData
//    extends ContainerBoxParentData<RenderBox> {
//  RRect surroundingRect;
//}
//
//typedef _NextChild = RenderBox Function(RenderBox child);
//
//class _RenderSegmentedControl<T> extends RenderBox
//    with
//        ContainerRenderObjectMixin<RenderBox,
//            ContainerBoxParentData<RenderBox>>,
//        RenderBoxContainerDefaultsMixin<RenderBox,
//            ContainerBoxParentData<RenderBox>> {
//  _RenderSegmentedControl({
//    List<RenderBox> children,
//    @required int selectedIndex,
//    @required int pressedIndex,
//    @required TextDirection textDirection,
//    @required List<Color> backgroundColors,
//    @required Color borderColor,
//  })  : assert(textDirection != null),
//        _textDirection = textDirection,
//        _selectedIndex = selectedIndex,
//        _pressedIndex = pressedIndex,
//        _backgroundColors = backgroundColors,
//        _borderColor = borderColor {
//    addAll(children);
//  }
//
//  int get selectedIndex => _selectedIndex;
//  int _selectedIndex;
//  set selectedIndex(int value) {
//    if (_selectedIndex == value) {
//      return;
//    }
//    _selectedIndex = value;
//    markNeedsPaint();
//  }
//
//  int get pressedIndex => _pressedIndex;
//  int _pressedIndex;
//  set pressedIndex(int value) {
//    if (_pressedIndex == value) {
//      return;
//    }
//    _pressedIndex = value;
//    markNeedsPaint();
//  }
//
//  TextDirection get textDirection => _textDirection;
//  TextDirection _textDirection;
//  set textDirection(TextDirection value) {
//    if (_textDirection == value) {
//      return;
//    }
//    _textDirection = value;
//    markNeedsLayout();
//  }
//
//  List<Color> get backgroundColors => _backgroundColors;
//  List<Color> _backgroundColors;
//  set backgroundColors(List<Color> value) {
//    if (_backgroundColors == value) {
//      return;
//    }
//    _backgroundColors = value;
//    markNeedsPaint();
//  }
//
//  Color get borderColor => _borderColor;
//  Color _borderColor;
//  set borderColor(Color value) {
//    if (_borderColor == value) {
//      return;
//    }
//    _borderColor = value;
//    markNeedsPaint();
//  }
//
//  @override
//  double computeMinIntrinsicWidth(double height) {
//    RenderBox child = firstChild;
//    double minWidth = 0.0;
//    while (child != null) {
//      final _SegmentedControlContainerBoxParentData childParentData =
//          child.parentData;
//      final double childWidth = child.getMinIntrinsicWidth(height);
//      minWidth = math.max(minWidth, childWidth);
//      child = childParentData.nextSibling;
//    }
//    return minWidth * childCount;
//  }
//
//  @override
//  double computeMaxIntrinsicWidth(double height) {
//    RenderBox child = firstChild;
//    double maxWidth = 0.0;
//    while (child != null) {
//      final _SegmentedControlContainerBoxParentData childParentData =
//          child.parentData;
//      final double childWidth = child.getMaxIntrinsicWidth(height);
//      maxWidth = math.max(maxWidth, childWidth);
//      child = childParentData.nextSibling;
//    }
//    return maxWidth * childCount;
//  }
//
//  @override
//  double computeMinIntrinsicHeight(double width) {
//    RenderBox child = firstChild;
//    double minHeight = 0.0;
//    while (child != null) {
//      final _SegmentedControlContainerBoxParentData childParentData =
//          child.parentData;
//      final double childHeight = child.getMinIntrinsicHeight(width);
//      minHeight = math.max(minHeight, childHeight);
//      child = childParentData.nextSibling;
//    }
//    return minHeight;
//  }
//
//  @override
//  double computeMaxIntrinsicHeight(double width) {
//    RenderBox child = firstChild;
//    double maxHeight = 0.0;
//    while (child != null) {
//      final _SegmentedControlContainerBoxParentData childParentData =
//          child.parentData;
//      final double childHeight = child.getMaxIntrinsicHeight(width);
//      maxHeight = math.max(maxHeight, childHeight);
//      child = childParentData.nextSibling;
//    }
//    return maxHeight;
//  }
//
//  @override
//  double computeDistanceToActualBaseline(TextBaseline baseline) {
//    return defaultComputeDistanceToHighestActualBaseline(baseline);
//  }
//
//  @override
//  void setupParentData(RenderBox child) {
//    if (child.parentData is! _SegmentedControlContainerBoxParentData) {
//      child.parentData = _SegmentedControlContainerBoxParentData();
//    }
//  }
//
//  void _layoutRects(
//      _NextChild nextChild, RenderBox leftChild, RenderBox rightChild) {
//    RenderBox child = leftChild;
//    double start = 0.0;
//    while (child != null) {
//      final _SegmentedControlContainerBoxParentData childParentData =
//          child.parentData;
//      final Offset childOffset = Offset(start, 0.0);
//      childParentData.offset = childOffset;
//      final Rect childRect =
//          Rect.fromLTWH(start, 0.0, child.size.width, child.size.height);
//      RRect rChildRect;
//      if (child == leftChild) {
//        rChildRect = RRect.fromRectAndCorners(childRect,
//            topLeft: const Radius.circular(3.0),
//            bottomLeft: const Radius.circular(3.0));
//      } else if (child == rightChild) {
//        rChildRect = RRect.fromRectAndCorners(childRect,
//            topRight: const Radius.circular(3.0),
//            bottomRight: const Radius.circular(3.0));
//      } else {
//        rChildRect = RRect.fromRectAndCorners(childRect);
//      }
//      childParentData.surroundingRect = rChildRect;
//      start += child.size.width;
//      child = nextChild(child);
//    }
//  }
//
//  @override
//  void performLayout() {
//    double maxHeight = _kMinSegmentedControlHeight;
//
//    double childWidth = constraints.minWidth / childCount;
//    for (RenderBox child in getChildrenAsList()) {
//      childWidth =
//          math.max(childWidth, child.getMaxIntrinsicWidth(double.infinity));
//    }
//    childWidth = math.min(childWidth, constraints.maxWidth / childCount);
//
//    RenderBox child = firstChild;
//    while (child != null) {
//      final double boxHeight = child.getMaxIntrinsicHeight(childWidth);
//      maxHeight = math.max(maxHeight, boxHeight);
//      child = childAfter(child);
//    }
//
//    constraints.constrainHeight(maxHeight);
//
//    final BoxConstraints childConstraints = BoxConstraints.tightFor(
//      width: childWidth,
//      height: maxHeight,
//    );
//
//    child = firstChild;
//    while (child != null) {
//      child.layout(childConstraints, parentUsesSize: true);
//      child = childAfter(child);
//    }
//
//    switch (textDirection) {
//      case TextDirection.rtl:
//        _layoutRects(
//          childBefore,
//          lastChild,
//          firstChild,
//        );
//        break;
//      case TextDirection.ltr:
//        _layoutRects(
//          childAfter,
//          firstChild,
//          lastChild,
//        );
//        break;
//    }
//
//    size = constraints.constrain(Size(childWidth * childCount, maxHeight));
//  }
//
//  @override
//  void paint(PaintingContext context, Offset offset) {
//    RenderBox child = firstChild;
//    int index = 0;
//    while (child != null) {
//      _paintChild(context, offset, child, index);
//      child = childAfter(child);
//      index += 1;
//    }
//  }
//
//  void _paintChild(
//      PaintingContext context, Offset offset, RenderBox child, int childIndex) {
//    assert(child != null);
//
//    final _SegmentedControlContainerBoxParentData childParentData =
//        child.parentData;
//
//    context.canvas.drawRRect(
//      childParentData.surroundingRect.shift(offset),
//      Paint()
//        ..color = backgroundColors[childIndex]
//        ..style = PaintingStyle.fill,
//    );
//    context.canvas.drawRRect(
//      childParentData.surroundingRect.shift(offset),
//      Paint()
//        ..color = borderColor
//        ..strokeWidth = 1.0
//        ..style = PaintingStyle.stroke,
//    );
//
//    context.paintChild(child, childParentData.offset + offset);
//  }
//
//  @override
//  bool hitTestChildren(BoxHitTestResult result, {@required Offset position}) {
//    assert(position != null);
//    RenderBox child = lastChild;
//    while (child != null) {
//      final _SegmentedControlContainerBoxParentData childParentData =
//          child.parentData;
//      if (childParentData.surroundingRect.contains(position)) {
//        final Offset center = (Offset.zero & child.size).center;
//        return result.addWithRawTransform(
//          transform: MatrixUtils.forceToPoint(center),
//          position: center,
//          hitTest: (BoxHitTestResult result, Offset position) {
//            assert(position == center);
//            return child.hitTest(result, position: center);
//          },
//        );
//      }
//      child = childParentData.previousSibling;
//    }
//    return false;
//  }
//}
