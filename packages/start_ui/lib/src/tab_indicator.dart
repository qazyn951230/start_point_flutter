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

import 'colors.dart';
import 'tab_decoration.dart';
import 'theme.dart';

const _kDefaultUnderlineBorderSide =
    BorderSide(width: 2.0, color: UIColor.invalidColor);

enum UnderlineStyle {
  tab,
  label,
  length,
  percent,
}

class UnderlineDecoration extends TabDecoration {
  const UnderlineDecoration._({
    this.side,
    this.length,
    this.percent,
    this.style,
  })  : assert(side != null),
        assert(style != null);

  const UnderlineDecoration({
    this.side = _kDefaultUnderlineBorderSide,
  })  : assert(side != null),
        style = UnderlineStyle.tab,
        length = null,
        percent = null;

  const UnderlineDecoration.label({
    this.side = _kDefaultUnderlineBorderSide,
  })  : assert(side != null),
        style = UnderlineStyle.label,
        length = null,
        percent = null;

  const UnderlineDecoration.length({
    this.side = _kDefaultUnderlineBorderSide,
    this.length,
  })  : assert(side != null),
        assert(length != null),
        style = UnderlineStyle.length,
        percent = null;

  const UnderlineDecoration.percent({
    this.side = _kDefaultUnderlineBorderSide,
    this.percent,
  })  : assert(side != null),
        assert(percent != null),
        style = UnderlineStyle.percent,
        length = null;

  final BorderSide side;
  final double length;
  final double percent;
  final UnderlineStyle style;

  @override
  UnderlineDecoration resolve(BuildContext context) {
    if (identical(side.color, UIColor.invalidColor)) {
      return UnderlineDecoration._(
        side: side.copyWith(
          color: UIColor.blue(Theme.of(context).isLight),
        ),
        style: style,
        length: length,
        percent: percent,
      );
    }
    return this;
  }

  @override
  _UnderlinePainter createTabPainter(TabPainterDelegate delegate,
      [VoidCallback onChanged]) {
    return _UnderlinePainter(this, delegate, onChanged);
  }
}

class _UnderlinePainter extends TabPainter {
  _UnderlinePainter(this.decoration, TabPainterDelegate delegate,
      [VoidCallback onChanged])
      : super(delegate, onChanged);

  final UnderlineDecoration decoration;

  @override
  void paint(Canvas canvas, Offset offset, Size size) {
    assert(Offset != null);
    assert(size != null);
    final Rect origin = offset & size;
    final Rect rect = Rect.fromLTWH(
      origin.left,
      origin.bottom - decoration.side.width,
      origin.width,
      decoration.side.width,
    ).deflate(decoration.side.width);
    final Paint paint = decoration.side.toPaint()..strokeCap = StrokeCap.square;
    canvas.drawLine(rect.bottomLeft, rect.bottomRight, paint);
  }
}
