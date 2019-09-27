import 'dart:math' show min;

import 'package:flutter/painting.dart';

class RoundedBorder extends ShapeBorder {
  const RoundedBorder({
    this.side = BorderSide.none,
    this.topLeft = true,
    this.topRight = true,
    this.bottomLeft = true,
    this.bottomRight = true,
  }) : assert(side != null);

  const RoundedBorder.all({
    this.side = BorderSide.none,
    bool rounded,
  })  : assert(side != null),
        topLeft = rounded,
        topRight = rounded,
        bottomLeft = rounded,
        bottomRight = rounded;

  const RoundedBorder.only({
    this.side = BorderSide.none,
    bool topLeft,
    bool topRight,
    bool bottomLeft,
    bool bottomRight,
  })  : assert(side != null),
        topLeft = topLeft ?? false,
        topRight = topRight ?? false,
        bottomLeft = bottomLeft ?? false,
        bottomRight = bottomRight ?? false;

  final BorderSide side;
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    final radius = Radius.circular(min(rect.width, rect.height) / 2);
    return Path()
      ..addRRect(RRect.fromRectAndCorners(
        rect,
        topLeft: topLeft ? radius : Radius.zero,
        topRight: topRight ? radius : Radius.zero,
        bottomLeft: bottomLeft ? radius : Radius.zero,
        bottomRight: bottomRight ? radius : Radius.zero,
      ).deflate(side.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    final radius = Radius.circular(min(rect.width, rect.height) / 2);
    return Path()
      ..addRRect(RRect.fromRectAndCorners(
        rect,
        topLeft: topLeft ? radius : Radius.zero,
        topRight: topRight ? radius : Radius.zero,
        bottomLeft: bottomLeft ? radius : Radius.zero,
        bottomRight: bottomRight ? radius : Radius.zero,
      ));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final double width = side.width;
        final radius = Radius.circular(min(rect.width, rect.height) / 2);
        final outer = RRect.fromRectAndCorners(
          rect,
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        );
        if (width == 0.0) {
          canvas.drawRRect(outer, side.toPaint());
        } else {
          final RRect inner = outer.deflate(width);
          final Paint paint = Paint()..color = side.color;
          canvas.drawDRRect(outer, inner, paint);
        }
    }
  }

  @override
  ShapeBorder scale(double t) => RoundedBorder(side: side.scale(t));
}
