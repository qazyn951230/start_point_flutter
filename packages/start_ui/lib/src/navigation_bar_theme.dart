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

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'text_theme.dart';
import 'theme.dart';

class NavigationBarTheme {
  const NavigationBarTheme({
    this.backgroundColor,
    this.color,
    this.titleColor,
    this.largeTitleColor,
    this.style,
    this.titleStyle,
    this.largeTitleStyle,
    this.translucent,
    this.backIcon,
    this.automaticallyBackLabel = true,
    this.backButtonBuilder,
  }) : assert(automaticallyBackLabel != null);

  const NavigationBarTheme.resolved({
    this.backgroundColor,
    this.color,
    this.titleColor,
    this.largeTitleColor,
    this.style,
    this.titleStyle,
    this.largeTitleStyle,
    this.translucent,
    this.backIcon,
    this.automaticallyBackLabel,
    this.backButtonBuilder,
  })  : assert(backgroundColor != null),
        assert(titleColor != null),
        assert(largeTitleColor != null),
        assert(color != null),
        assert(titleStyle != null),
        assert(largeTitleStyle != null),
        assert(style != null),
        assert(backIcon != null),
        assert(automaticallyBackLabel != null);

  factory NavigationBarTheme.resolve(
    NavigationBarTheme other, {
    bool light,
    TextTheme textTheme,
  }) {
    final titleColor =
        other?.titleColor ?? (light ? UIColor.black : UIColor.white);
    final color = other?.color ?? UIColor.blue(light);
    return NavigationBarTheme.resolved(
      translucent: other?.translucent,
      backgroundColor: other?.backgroundColor ?? UIColor.barBackground(light),
      titleColor: titleColor,
      largeTitleColor: other?.largeTitleColor ?? titleColor,
      color: color,
      titleStyle:
          other?.titleStyle ?? textTheme.headline.copyWith(color: titleColor),
      largeTitleStyle: other?.largeTitleStyle ??
          textTheme.largeTitle.copyWith(color: titleColor),
      style: other?.style ?? textTheme.body.copyWith(color: color),
      backIcon: other?.backIcon ?? CupertinoIcons.back,
      automaticallyBackLabel: other?.automaticallyBackLabel ?? true,
      backButtonBuilder: other?.backButtonBuilder,
    );
  }

  final Color backgroundColor;
  final Color titleColor;
  final Color largeTitleColor;
  final Color color;
  final TextStyle titleStyle;
  final TextStyle largeTitleStyle;
  final TextStyle style;
  final bool translucent;
  final IconData backIcon;
  final bool automaticallyBackLabel;
  final WidgetBuilder backButtonBuilder;

  static NavigationBarTheme of(BuildContext context) {
    return Theme.of(context).navigationBarTheme;
  }
}
