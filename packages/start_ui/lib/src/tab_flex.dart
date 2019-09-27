import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef TabFlexLayoutCallback = void Function(
  TextDirection textDirection,
  double width,
  List<double> xOffsets,
);

class TabFlex extends Flex {
  TabFlex({
    Key key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    VerticalDirection verticalDirection = VerticalDirection.down,
    List<Widget> children = const <Widget>[],
    this.onPerformLayout,
  }) : super(
          direction: Axis.horizontal,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          verticalDirection: verticalDirection,
          children: children,
        );

  final TabFlexLayoutCallback onPerformLayout;

  @override
  RenderFlex createRenderObject(BuildContext context) {
    return RenderTabFlex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context),
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      onPerformLayout: onPerformLayout,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderTabFlex renderObject,
  ) {
    super.updateRenderObject(context, renderObject);
    renderObject._onPerformLayout = onPerformLayout;
  }
}

class RenderTabFlex extends RenderFlex {
  RenderTabFlex({
    List<RenderBox> children,
    Axis direction = Axis.horizontal,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline textBaseline,
    TabFlexLayoutCallback onPerformLayout,
  })  : _onPerformLayout = onPerformLayout,
        super(
          children: children,
          direction: direction,
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
        );

  TabFlexLayoutCallback _onPerformLayout;

  @override
  void performLayout() {
    super.performLayout();
    if (_onPerformLayout != null) {
      final xOffsets = <double>[];
      var child = firstChild;
      while (child != null) {
        final FlexParentData childParentData = child.parentData;
        xOffsets.add(childParentData.offset.dx);
        assert(child.parentData == childParentData);
        child = childParentData.nextSibling;
      }
      assert(textDirection != null);
      switch (textDirection) {
        case TextDirection.rtl:
          xOffsets.insert(0, size.width);
          break;
        case TextDirection.ltr:
          xOffsets.add(size.width);
          break;
      }
      _onPerformLayout(textDirection, size.width, xOffsets);
    }
  }
}
