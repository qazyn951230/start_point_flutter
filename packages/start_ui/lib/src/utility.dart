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

import 'package:flutter/painting.dart';

import 'theme.dart';

// TODO: Move borderColor to bar theme
Border resolveBorder(Border border, ThemeData theme) {
  if (border == null) {
    return null;
  }
  return Border(
    top: resolveBorderSide(border.top, theme),
    bottom: resolveBorderSide(border.bottom, theme),
    left: resolveBorderSide(border.left, theme),
    right: resolveBorderSide(border.right, theme),
  );
}

BorderSide resolveBorderSide(BorderSide borderSide, ThemeData theme) {
  if (borderSide?.style == BorderStyle.solid) {
    return borderSide.copyWith(
      color: theme.borderColor,
    );
  }
  return borderSide;
}

Color resolveColorAlpha(Color color, bool opaque) {
  if (opaque && color?.alpha != 0xFF) {
    return color.withAlpha(255);
  }
  return color;
}
