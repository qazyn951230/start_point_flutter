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

//import 'package:flutter/foundation.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter/widgets.dart';
//
//import 'theme.dart';
//
//const Color _kHighlighterBorder = Color(0xFF7F7F7F);
//const Color _kDefaultBackground = Color(0xFFD2D4DB);
//// Eyeballed values comparing with a native picker to produce the right
//// curvatures and densities.
//const double _kDefaultDiameterRatio = 1.07;
//const double _kDefaultPerspective = 0.003;
//const double _kSqueeze = 1.45;
//
//const double _kForegroundScreenOpacityFraction = 0.7;
//
//class Picker extends StatefulWidget {
//  Picker({
//    Key key,
//    this.diameterRatio = _kDefaultDiameterRatio,
//    this.backgroundColor = _kDefaultBackground,
//    this.offAxisFraction = 0.0,
//    this.useMagnifier = false,
//    this.magnification = 1.0,
//    this.scrollController,
//    this.squeeze = _kSqueeze,
//    @required this.itemExtent,
//    @required this.onSelectedItemChanged,
//    @required List<Widget> children,
//    bool looping = false,
//  })  : assert(children != null),
//        assert(diameterRatio != null),
//        assert(diameterRatio > 0.0,
//            RenderListWheelViewport.diameterRatioZeroMessage),
//        assert(magnification > 0),
//        assert(itemExtent != null),
//        assert(itemExtent > 0),
//        assert(squeeze != null),
//        assert(squeeze > 0),
//        childDelegate = looping
//            ? ListWheelChildLoopingListDelegate(children: children)
//            : ListWheelChildListDelegate(children: children),
//        super(key: key);
//
//  Picker.builder({
//    Key key,
//    this.diameterRatio = _kDefaultDiameterRatio,
//    this.backgroundColor = _kDefaultBackground,
//    this.offAxisFraction = 0.0,
//    this.useMagnifier = false,
//    this.magnification = 1.0,
//    this.scrollController,
//    this.squeeze = _kSqueeze,
//    @required this.itemExtent,
//    @required this.onSelectedItemChanged,
//    @required IndexedWidgetBuilder itemBuilder,
//    int childCount,
//  })  : assert(itemBuilder != null),
//        assert(diameterRatio != null),
//        assert(diameterRatio > 0.0,
//            RenderListWheelViewport.diameterRatioZeroMessage),
//        assert(magnification > 0),
//        assert(itemExtent != null),
//        assert(itemExtent > 0),
//        assert(squeeze != null),
//        assert(squeeze > 0),
//        childDelegate = ListWheelChildBuilderDelegate(
//            builder: itemBuilder, childCount: childCount),
//        super(key: key);
//
//  final double diameterRatio;
//
//  final Color backgroundColor;
//
//  final double offAxisFraction;
//
//  final bool useMagnifier;
//
//  final double magnification;
//
//  final FixedExtentScrollController scrollController;
//
//  final double itemExtent;
//
//  final double squeeze;
//
//  final ValueChanged<int> onSelectedItemChanged;
//
//  final ListWheelChildDelegate childDelegate;
//
//  @override
//  State<StatefulWidget> createState() => _PickerState();
//}
//
//class _PickerState extends State<Picker> {
//  int _lastHapticIndex;
//  FixedExtentScrollController _controller;
//
//  @override
//  void initState() {
//    super.initState();
//    if (widget.scrollController == null) {
//      _controller = FixedExtentScrollController();
//    }
//  }
//
//  @override
//  void didUpdateWidget(Picker oldWidget) {
//    if (widget.scrollController != null && oldWidget.scrollController == null) {
//      _controller = null;
//    } else if (widget.scrollController == null &&
//        oldWidget.scrollController != null) {
//      assert(_controller == null);
//      _controller = FixedExtentScrollController();
//    }
//    super.didUpdateWidget(oldWidget);
//  }
//
//  @override
//  void dispose() {
//    _controller?.dispose();
//    super.dispose();
//  }
//
//  void _handleSelectedItemChanged(int index) {
//    // Only the haptic engine hardware on iOS devices would produce the
//    // intended effects.
//    if (defaultTargetPlatform == TargetPlatform.iOS &&
//        index != _lastHapticIndex) {
//      _lastHapticIndex = index;
//      HapticFeedback.selectionClick();
//    }
//
//    if (widget.onSelectedItemChanged != null) {
//      widget.onSelectedItemChanged(index);
//    }
//  }
//
//  Widget _buildGradientScreen() {
//    // Because BlendMode.dstOut doesn't work correctly with BoxDecoration we
//    // have to just do a color blend. And a due to the way we are layering
//    // the magnifier and the gradient on the background, using a transparent
//    // background color makes the picker look odd.
//    if (widget.backgroundColor != null && widget.backgroundColor.alpha < 255)
//      return Container();
//
//    final Color widgetBackgroundColor =
//        widget.backgroundColor ?? const Color(0xFFFFFFFF);
//    return Positioned.fill(
//      child: IgnorePointer(
//        child: Container(
//          decoration: BoxDecoration(
//            gradient: LinearGradient(
//              colors: <Color>[
//                widgetBackgroundColor,
//                widgetBackgroundColor.withAlpha(0xF2),
//                widgetBackgroundColor.withAlpha(0xDD),
//                widgetBackgroundColor.withAlpha(0),
//                widgetBackgroundColor.withAlpha(0),
//                widgetBackgroundColor.withAlpha(0xDD),
//                widgetBackgroundColor.withAlpha(0xF2),
//                widgetBackgroundColor,
//              ],
//              stops: const <double>[
//                0.0,
//                0.05,
//                0.09,
//                0.22,
//                0.78,
//                0.91,
//                0.95,
//                1.0,
//              ],
//              begin: Alignment.topCenter,
//              end: Alignment.bottomCenter,
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget _buildMagnifierScreen() {
//    final Color foreground = widget.backgroundColor?.withAlpha(
//        (widget.backgroundColor.alpha * _kForegroundScreenOpacityFraction)
//            .toInt());
//
//    return IgnorePointer(
//      child: Column(
//        children: <Widget>[
//          Expanded(
//            child: Container(
//              color: foreground,
//            ),
//          ),
//          Container(
//            decoration: const BoxDecoration(
//              border: Border(
//                top: BorderSide(width: 0.0, color: _kHighlighterBorder),
//                bottom: BorderSide(width: 0.0, color: _kHighlighterBorder),
//              ),
//            ),
//            constraints: BoxConstraints.expand(
//              height: widget.itemExtent * widget.magnification,
//            ),
//          ),
//          Expanded(
//            child: Container(
//              color: foreground,
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget _buildUnderMagnifierScreen() {
//    final Color foreground = widget.backgroundColor?.withAlpha(
//        (widget.backgroundColor.alpha * _kForegroundScreenOpacityFraction)
//            .toInt());
//
//    return Column(
//      children: <Widget>[
//        Expanded(child: Container()),
//        Container(
//          color: foreground,
//          constraints: BoxConstraints.expand(
//            height: widget.itemExtent * widget.magnification,
//          ),
//        ),
//        Expanded(child: Container()),
//      ],
//    );
//  }
//
//  Widget _addBackgroundToChild(Widget child) {
//    return DecoratedBox(
//      decoration: BoxDecoration(
//        color: widget.backgroundColor,
//      ),
//      child: child,
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    Widget result = DefaultTextStyle(
//      style: Theme.of(context).textTheme.pickerTextStyle,
//      child: Stack(
//        children: <Widget>[
//          Positioned.fill(
//            child: _PickerSemantics(
//              scrollController: widget.scrollController ?? _controller,
//              child: ListWheelScrollView.useDelegate(
//                controller: widget.scrollController ?? _controller,
//                physics: const FixedExtentScrollPhysics(),
//                diameterRatio: widget.diameterRatio,
//                perspective: _kDefaultPerspective,
//                offAxisFraction: widget.offAxisFraction,
//                useMagnifier: widget.useMagnifier,
//                magnification: widget.magnification,
//                itemExtent: widget.itemExtent,
//                squeeze: widget.squeeze,
//                onSelectedItemChanged: _handleSelectedItemChanged,
//                childDelegate: widget.childDelegate,
//              ),
//            ),
//          ),
//          _buildGradientScreen(),
//          _buildMagnifierScreen(),
//        ],
//      ),
//    );
//    // Adds the appropriate opacity under the magnifier if the background
//    // color is transparent.
//    if (widget.backgroundColor != null && widget.backgroundColor.alpha < 255) {
//      result = Stack(
//        children: <Widget>[
//          _buildUnderMagnifierScreen(),
//          _addBackgroundToChild(result),
//        ],
//      );
//    } else {
//      result = _addBackgroundToChild(result);
//    }
//    return result;
//  }
//}
//
//// Turns the scroll semantics of the ListView into a single adjustable semantics
//// node. This is done by removing all of the child semantics of the scroll
//// wheel and using the scroll indexes to look up the current, previous, and
//// next semantic label. This label is then turned into the value of a new
//// adjustable semantic node, with adjustment callbacks wired to move the
//// scroll controller.
//class _PickerSemantics extends SingleChildRenderObjectWidget {
//  const _PickerSemantics({
//    Key key,
//    Widget child,
//    @required this.scrollController,
//  }) : super(key: key, child: child);
//
//  final FixedExtentScrollController scrollController;
//
//  @override
//  RenderObject createRenderObject(BuildContext context) =>
//      _RenderPickerSemantics(scrollController, Directionality.of(context));
//
//  @override
//  void updateRenderObject(
//      BuildContext context, covariant _RenderPickerSemantics renderObject) {
//    renderObject
//      ..textDirection = Directionality.of(context)
//      ..controller = scrollController;
//  }
//}
//
//class _RenderPickerSemantics extends RenderProxyBox {
//  _RenderPickerSemantics(
//      FixedExtentScrollController controller, this._textDirection) {
//    this.controller = controller;
//  }
//
//  FixedExtentScrollController get controller => _controller;
//  FixedExtentScrollController _controller;
//  set controller(FixedExtentScrollController value) {
//    if (value == _controller) return;
//    if (_controller != null)
//      _controller.removeListener(_handleScrollUpdate);
//    else
//      _currentIndex = value.initialItem ?? 0;
//    value.addListener(_handleScrollUpdate);
//    _controller = value;
//  }
//
//  TextDirection get textDirection => _textDirection;
//  TextDirection _textDirection;
//  set textDirection(TextDirection value) {
//    if (textDirection == value) return;
//    _textDirection = value;
//    markNeedsSemanticsUpdate();
//  }
//
//  int _currentIndex = 0;
//
//  void _handleIncrease() {
//    controller.jumpToItem(_currentIndex + 1);
//  }
//
//  void _handleDecrease() {
//    if (_currentIndex == 0) return;
//    controller.jumpToItem(_currentIndex - 1);
//  }
//
//  void _handleScrollUpdate() {
//    if (controller.selectedItem == _currentIndex) return;
//    _currentIndex = controller.selectedItem;
//    markNeedsSemanticsUpdate();
//  }
//
//  @override
//  void describeSemanticsConfiguration(SemanticsConfiguration config) {
//    super.describeSemanticsConfiguration(config);
//    config.isSemanticBoundary = true;
//    config.textDirection = textDirection;
//  }
//
//  @override
//  void assembleSemanticsNode(SemanticsNode node, SemanticsConfiguration config,
//      Iterable<SemanticsNode> children) {
//    if (children.isEmpty)
//      return super.assembleSemanticsNode(node, config, children);
//    final SemanticsNode scrollable = children.first;
//    final Map<int, SemanticsNode> indexedChildren = <int, SemanticsNode>{};
//    scrollable.visitChildren((SemanticsNode child) {
//      assert(child.indexInParent != null);
//      indexedChildren[child.indexInParent] = child;
//      return true;
//    });
//    if (indexedChildren[_currentIndex] == null) {
//      return node.updateWith(config: config);
//    }
//    config.value = indexedChildren[_currentIndex].label;
//    final SemanticsNode previousChild = indexedChildren[_currentIndex - 1];
//    final SemanticsNode nextChild = indexedChildren[_currentIndex + 1];
//    if (nextChild != null) {
//      config.increasedValue = nextChild.label;
//      config.onIncrease = _handleIncrease;
//    }
//    if (previousChild != null) {
//      config.decreasedValue = previousChild.label;
//      config.onDecrease = _handleDecrease;
//    }
//    node.updateWith(config: config);
//  }
//}
