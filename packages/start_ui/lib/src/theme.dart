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

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:start_ui/src/navigation_bar_theme.dart';

import 'colors.dart';
import 'tab_bar_theme.dart';
import 'text_theme.dart';

class Theme extends StatelessWidget {
  const Theme({
    Key key,
    @required this.data,
    @required this.child,
  })  : assert(child != null),
        assert(data != null),
        super(key: key);

  final ThemeData data;

  static ThemeData of(BuildContext context) {
    final _InheritedTheme inheritedTheme =
        context.inheritFromWidgetOfExactType(_InheritedTheme);
    return inheritedTheme?.theme?.data ?? ThemeData();
  }

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: IconTheme(
        data: IconThemeData(color: data.primaryColor),
        child: child,
      ),
    );
  }
}

class _InheritedTheme extends InheritedWidget {
  const _InheritedTheme({
    Key key,
    @required this.theme,
    @required Widget child,
  })  : assert(theme != null),
        super(key: key, child: child);

  final Theme theme;

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;
}

class ThemeData extends Diagnosticable {
  const ThemeData.raw({
    @required this.primaryColor,
    @required this.primaryTextColor,
    @required this.borderColor,
    @required this.backgroundColor,
    @required this.brightness,
    @required this.textTheme,
    @required this.tabBarTheme,
    @required this.navigationBarTheme,
  })  : assert(primaryColor != null),
        assert(primaryTextColor != null),
        assert(borderColor != null),
        assert(backgroundColor != null),
        assert(brightness != null),
        assert(textTheme != null),
        assert(tabBarTheme != null),
        assert(navigationBarTheme != null);

  factory ThemeData({
    Brightness brightness,
    Color primaryColor,
    Color primaryTextColor,
    Color borderColor,
    Color backgroundColor,
    TextTheme textTheme,
    TabBarTheme tabBarTheme,
    NavigationBarTheme navigationBarTheme,
  }) {
    brightness ??= Brightness.light;
    final light = brightness != Brightness.dark;
    backgroundColor ??= light ? UIColor.white : UIColor.black;
    textTheme ??= TextTheme(
      color: primaryTextColor ?? (light ? UIColor.black : UIColor.white),
    );
    return ThemeData.raw(
      primaryColor: primaryColor ?? UIColor.blue(light),
      primaryTextColor:
          primaryTextColor ?? (light ? UIColor.black : UIColor.white),
      borderColor: borderColor ?? UIColor.borderColor(light),
      backgroundColor: backgroundColor,
      brightness: brightness,
      textTheme: textTheme,
      tabBarTheme: TabBarTheme.resolve(
        tabBarTheme,
        light: light,
        textTheme: textTheme,
      ),
      navigationBarTheme: NavigationBarTheme.resolve(
        navigationBarTheme,
        light: light,
        textTheme: textTheme,
      ),
    );
  }

  final Color primaryColor;
  final Color primaryTextColor;
  final Color backgroundColor;
  final Color borderColor;
  final Brightness brightness;
  final TextTheme textTheme;
  final TabBarTheme tabBarTheme;
  final NavigationBarTheme navigationBarTheme;

  bool get isLight => brightness != Brightness.dark;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: ThemeData.debugFillProperties
    super.debugFillProperties(properties);
  }
}
