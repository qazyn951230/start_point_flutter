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

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class DefaultIconTextStyle extends StatelessWidget {
  const DefaultIconTextStyle({
    Key key,
    @required this.style,
    this.textAlign,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.textWidthBasis = TextWidthBasis.parent,
    @required this.iconTheme,
    @required this.child,
  })  : assert(style != null),
        assert(softWrap != null),
        assert(overflow != null),
        assert(maxLines == null || maxLines > 0),
        assert(textWidthBasis != null),
        super(key: key);

  final TextStyle style;
  final TextAlign textAlign;
  final bool softWrap;
  final TextOverflow overflow;
  final int maxLines;
  final TextWidthBasis textWidthBasis;

  final IconThemeData iconTheme;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (child == null) {
      return Container();
    }
    final result = DefaultTextStyle(
      style: style,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      child: child,
    );
    if (iconTheme != null) {
      return IconTheme.merge(
        data: iconTheme,
        child: result,
      );
    }
    return result;
  }
}
