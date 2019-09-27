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

import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'colors.dart';
import 'text_theme.dart';
import 'theme.dart';

class TabBarTheme {
  const TabBarTheme({
    this.backgroundColor,
    this.color,
    this.unselectedColor,
    this.style,
    this.unselectedStyle,
    this.translucent,
  });

  const TabBarTheme.resolved({
    this.backgroundColor,
    this.color,
    this.unselectedColor,
    this.style,
    this.unselectedStyle,
    this.translucent,
  })  : assert(backgroundColor != null),
        assert(color != null),
        assert(unselectedColor != null),
        assert(style != null),
        assert(unselectedStyle != null);

  factory TabBarTheme.resolve(
    TabBarTheme other, {
    bool light,
    TextTheme textTheme,
  }) {
    final selectedColor = other?.color ?? UIColor.blue(light);
    final unselectedColor = other?.unselectedColor ?? UIColor.gray(light);
    return TabBarTheme.resolved(
      translucent: other?.translucent,
      backgroundColor: other?.backgroundColor ?? UIColor.barBackground(light),
      color: selectedColor,
      unselectedColor: unselectedColor,
      style: other?.style ??
          textTheme.textStyle(
            color: selectedColor,
            fontSize: 10.0,
            letterSpacing: -0.24,
            fontWeight: FontWeight.w600,
          ),
      unselectedStyle: other?.unselectedStyle ??
          textTheme.textStyle(
            color: unselectedColor,
            fontSize: 10.0,
            letterSpacing: -0.24,
            fontWeight: FontWeight.w600,
          ),
    );
  }

  final Color backgroundColor;
  final Color color;
  final Color unselectedColor;
  final TextStyle style;
  final TextStyle unselectedStyle;
  final bool translucent;

  static TabBarTheme of(BuildContext context) {
    return Theme.of(context).tabBarTheme;
  }
}
