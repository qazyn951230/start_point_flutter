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

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';
import 'text_theme.dart';

export 'package:flutter/services.dart' show Brightness;

// Values derived from https://developer.apple.com/design/resources/.
const Color _kDefaultBarLightBackgroundColor = Color(0xCCF8F8F8);
const Color _kDefaultBarDarkBackgroundColor = Color(0xB7212121);

/// Applies a visual styling theme to descendant  widgets.
///
/// Affects the color and text styles of  widgets whose styling
/// are not overridden when constructing the respective widgets instances.
///
/// Descendant widgets can retrieve the current [ThemeData] by calling
/// [Theme.of]. An [InheritedWidget] dependency is created when
/// an ancestor [ThemeData] is retrieved via [Theme.of].
///
/// The [Theme] widget implies an [IconTheme] widget, whose
/// [IconTheme.data] has the same color as [ThemeData.primaryColor]
///
/// See also:
///
///  * [ThemeData], specifies the theme's visual styling.
///  * [App], which will automatically add a [Theme].
///  * [Theme], a Material theme which will automatically add a [Theme]
///    with a [ThemeData] derived from the Material [ThemeData].
class Theme extends StatelessWidget {
  /// Creates a [Theme] to change descendant  widgets' styling.
  ///
  /// The [data] and [child] parameters must not be null.
  const Theme({
    Key key,
    @required this.data,
    @required this.child,
  }) : assert(child != null),
       assert(data != null),
       super(key: key);

  /// The [ThemeData] styling for this theme.
  final ThemeData data;

  /// Retrieve the [ThemeData] from an ancestor [Theme] widget.
  ///
  /// Returns a default [ThemeData] if no [Theme] widgets
  /// exist in the ancestry tree.
  static ThemeData of(BuildContext context) {
    final _InheritedTheme inheritedTheme = context.inheritFromWidgetOfExactType(_InheritedTheme);
    return inheritedTheme?.theme?.data ?? const ThemeData();
  }

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return  _InheritedTheme(
      theme: this,
      child: IconTheme(
        data: IconThemeData(color: data.primaryColor),
        child: child,
      )
    );
  }
}

class _InheritedTheme extends InheritedWidget {
  const _InheritedTheme({
    Key key,
    @required this.theme,
    @required Widget child,
  }) : assert(theme != null),
       super(key: key, child: child);

  final Theme theme;

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;
}

/// Styling specifications for a [Theme].
///
/// All constructor parameters can be null, in which case a
/// [Colors.activeBlue] based default iOS theme styling is used.
///
/// Parameters can also be partially specified, in which case some parameters
/// will cascade down to other dependent parameters to create a cohesive
/// visual effect. For instance, if a [primaryColor] is specified, it would
/// cascade down to affect some fonts in [textTheme] if [textTheme] is not
/// specified.
///
/// See also:
///
///  * [Theme], in which this [ThemeData] is inserted.
///  * [ThemeData], a Material equivalent that also configures
///    styling via a [ThemeData] subclass [MaterialBasedThemeData].
@immutable
class ThemeData extends Diagnosticable {
  /// Create a [Theme] styling specification.
  ///
  /// Unspecified parameters default to a reasonable iOS default style.
  const ThemeData({
    Brightness brightness,
    Color primaryColor,
    Color primaryContrastingColor,
    TextThemeData textTheme,
    Color barBackgroundColor,
    Color scaffoldBackgroundColor,
  }) : this.raw(
        brightness,
        primaryColor,
        primaryContrastingColor,
        textTheme,
        barBackgroundColor,
        scaffoldBackgroundColor,
      );

  /// Same as the default constructor but with positional arguments to avoid
  /// forgetting any and to specify all arguments.
  ///
  /// Used by subclasses to get the superclass's defaulting behaviors.
  @protected
  const ThemeData.raw(
    this._brightness,
    this._primaryColor,
    this._primaryContrastingColor,
    this._textTheme,
    this._barBackgroundColor,
    this._scaffoldBackgroundColor,
  );

  bool get _isLight => brightness == Brightness.light;

  /// The general brightness theme of the [ThemeData].
  ///
  /// Affects all other theme properties when unspecified. Defaults to
  /// [Brightness.light].
  ///
  /// If coming from a Material [Theme] and unspecified, [brightness] will be
  /// derived from the Material [ThemeData]'s `brightness`.
  Brightness get brightness => _brightness ?? Brightness.light;
  final Brightness _brightness;

  /// A color used on interactive elements of the theme.
  ///
  /// This color is generally used on text and icons in buttons and tappable
  /// elements. Defaults to [Colors.activeBlue] or
  /// [Colors.activeOrange] when [brightness] is light or dark.
  ///
  /// If coming from a Material [Theme] and unspecified, [primaryColor] will be
  /// derived from the Material [ThemeData]'s `colorScheme.primary`. However, in
  /// iOS styling, the [primaryColor] is more sparsely used than in Material
  /// Design where the [primaryColor] can appear on non-interactive surfaces like
  /// the [AppBar] background, [TextField] borders etc.
  Color get primaryColor {
    return _primaryColor ??
        (_isLight ? Colors.activeBlue : Colors.activeOrange);
  }
  final Color _primaryColor;

  /// A color used for content that must contrast against a [primaryColor] background.
  ///
  /// For example, this color is used for a [Button]'s text and icons
  /// when the button's background is [primaryColor].
  ///
  /// If coming from a Material [Theme] and unspecified, [primaryContrastingColor]
  /// will be derived from the Material [ThemeData]'s `colorScheme.onPrimary`.
  Color get primaryContrastingColor {
    return _primaryContrastingColor ??
        (_isLight ? Colors.white : Colors.black);
  }
  final Color _primaryContrastingColor;

  /// Text styles used by  widgets.
  ///
  /// Derived from [brightness] and [primaryColor] if unspecified, including
  /// [brightness] and [primaryColor] of a Material [ThemeData] if coming
  /// from a Material [Theme].
  TextThemeData get textTheme {
    return _textTheme ?? TextThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
    );
  }
  final TextThemeData _textTheme;

  /// Background color of the top nav bar and bottom tab bar.
  ///
  /// Defaults to a light gray or a dark gray translucent color depending
  /// on the [brightness].
  Color get barBackgroundColor {
    return _barBackgroundColor ??
        (_isLight ? _kDefaultBarLightBackgroundColor : _kDefaultBarDarkBackgroundColor);
  }
  final Color _barBackgroundColor;

  /// Background color of the scaffold.
  ///
  /// Defaults to white or black depending on the [brightness].
  Color get scaffoldBackgroundColor {
    return _scaffoldBackgroundColor ??
        (_isLight ? Colors.white : Colors.black);
  }
  final Color _scaffoldBackgroundColor;

  /// Return an instance of the [ThemeData] whose property getters
  /// only return the construction time specifications with no derived values.
  ///
  /// Used in Material themes to let unspecified properties fallback to Material
  /// theme properties instead of iOS defaults.
  ThemeData noDefault() {
    return _NoDefaultThemeData(
      _brightness,
      _primaryColor,
      _primaryContrastingColor,
      _textTheme,
      _barBackgroundColor,
      _scaffoldBackgroundColor,
    );
  }

  /// Create a copy of [ThemeData] with specified attributes overridden.
  ///
  /// Only the current instance's specified attributes are copied instead of
  /// derived values. For instance, if the current [primaryColor] is implied
  /// to be [Colors.activeOrange] due to the current [brightness],
  /// copying with a different [brightness] will also change the copy's
  /// implied [primaryColor].
  ThemeData copyWith({
    Brightness brightness,
    Color primaryColor,
    Color primaryContrastingColor,
    TextThemeData textTheme,
    Color barBackgroundColor,
    Color scaffoldBackgroundColor,
  }) {
    return ThemeData(
      brightness: brightness ?? _brightness,
      primaryColor: primaryColor ?? _primaryColor,
      primaryContrastingColor: primaryContrastingColor ?? _primaryContrastingColor,
      textTheme: textTheme ?? _textTheme,
      barBackgroundColor: barBackgroundColor ?? _barBackgroundColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor ?? _scaffoldBackgroundColor,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    const ThemeData defaultData = ThemeData();
    properties.add(EnumProperty<Brightness>('brightness', brightness, defaultValue: defaultData.brightness));
    properties.add(ColorProperty('primaryColor', primaryColor, defaultValue: defaultData.primaryColor));
    properties.add(ColorProperty('primaryContrastingColor', primaryContrastingColor, defaultValue: defaultData.primaryContrastingColor));
    properties.add(DiagnosticsProperty<TextThemeData>('textTheme', textTheme, defaultValue: defaultData.textTheme));
    properties.add(ColorProperty('barBackgroundColor', barBackgroundColor, defaultValue: defaultData.barBackgroundColor));
    properties.add(ColorProperty('scaffoldBackgroundColor', scaffoldBackgroundColor, defaultValue: defaultData.scaffoldBackgroundColor));
  }
}

class _NoDefaultThemeData extends ThemeData {
  const _NoDefaultThemeData(
    this.brightness,
    this.primaryColor,
    this.primaryContrastingColor,
    this.textTheme,
    this.barBackgroundColor,
    this.scaffoldBackgroundColor,
  ) : super.raw(
        brightness,
        primaryColor,
        primaryContrastingColor,
        textTheme,
        barBackgroundColor,
        scaffoldBackgroundColor,
      );

  @override
  final Brightness brightness;
  @override
  final Color primaryColor;
  @override
  final Color primaryContrastingColor;
  @override
  final TextThemeData textTheme;
  @override
  final Color barBackgroundColor;
  @override
  final Color scaffoldBackgroundColor;
}
