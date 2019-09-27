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

import 'dart:math' show min;
import 'dart:ui' as ui show Shadow, FontFeature;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'theme.dart';

// https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/
// Fonts sizes are in points. Use SF Pro Text for sizes below 20pt.
// Use SF Pro Display for sizes 20pt or greater.
// L=Light, R=Regular, SB=Semibold | L=Leading,
// B=Suggested Baseline | Short subtracts 2 pts of leading, tall adds 2 pts of leading.
class TextTheme extends Diagnosticable {
  const TextTheme.raw({
    @required this.largeTitle,
    @required this.title1,
    @required this.title2,
    @required this.title3,
    @required this.headline,
    @required this.body,
    @required this.callout,
    @required this.subhead,
    @required this.footnote,
    @required this.caption1,
    @required this.caption2,
  })  : assert(largeTitle != null),
        assert(title1 != null),
        assert(title2 != null),
        assert(title3 != null),
        assert(headline != null),
        assert(body != null),
        assert(callout != null),
        assert(subhead != null),
        assert(footnote != null),
        assert(caption1 != null),
        assert(caption2 != null);

  TextTheme({
    Color color,
    FontWeight fontWeight = FontWeight.normal,
    String fontFamily,
    String textFontFamily = '.SF UI Text',
    String displayFontFamily = '.SF UI Display',
  })  : assert(color != null),
        assert(fontWeight != null),
        largeTitle = TextStyle(
          inherit: false,
          fontSize: 34.0,
          letterSpacing: 0.37,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily ?? displayFontFamily,
        ),
        title1 = TextStyle(
          inherit: false,
          fontSize: 28.0,
          letterSpacing: 0.36,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily ?? displayFontFamily,
        ),
        title2 = TextStyle(
          inherit: false,
          fontSize: 22.0,
          letterSpacing: 0.35,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily ?? displayFontFamily,
        ),
        title3 = TextStyle(
          inherit: false,
          fontSize: 20.0,
          letterSpacing: 0.39,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily ?? displayFontFamily,
        ),
        headline = TextStyle(
          inherit: false,
          fontSize: 17.0,
          letterSpacing: -0.41,
          color: color,
          fontWeight: FontWeight.values[min(
              FontWeight.values.indexOf(fontWeight) + 2,
              FontWeight.values.length - 1)],
          fontFamily: fontFamily ?? textFontFamily,
        ),
        body = TextStyle(
          inherit: false,
          fontSize: 17.0,
          letterSpacing: -0.41,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily ?? textFontFamily,
        ),
        callout = TextStyle(
          inherit: false,
          fontSize: 16.0,
          letterSpacing: -0.32,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily ?? textFontFamily,
        ),
        subhead = TextStyle(
          inherit: false,
          fontSize: 15.0,
          letterSpacing: -0.24,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily ?? textFontFamily,
        ),
        footnote = TextStyle(
          inherit: false,
          fontSize: 13.0,
          letterSpacing: -0.08,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily ?? textFontFamily,
        ),
        caption1 = TextStyle(
          inherit: false,
          fontSize: 12.0,
          letterSpacing: 0.0,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily ?? textFontFamily,
        ),
        caption2 = TextStyle(
          inherit: false,
          fontSize: 11.0,
          letterSpacing: 0.07,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily ?? textFontFamily,
        );

  final TextStyle largeTitle;

  final TextStyle title1;

  final TextStyle title2;

  final TextStyle title3;

  final TextStyle headline;

  final TextStyle body;

  final TextStyle callout;

  final TextStyle subhead;

  final TextStyle footnote;

  final TextStyle caption1;

  final TextStyle caption2;

  TextStyle textStyle({
    bool inherit,
    Color color,
    Color backgroundColor,
    String fontFamily,
    List<String> fontFamilyFallback,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextBaseline textBaseline,
    double height,
    Locale locale,
    Paint foreground,
    Paint background,
    List<ui.Shadow> shadows,
    List<ui.FontFeature> fontFeatures,
    TextDecoration decoration,
    Color decorationColor,
    TextDecorationStyle decorationStyle,
    double decorationThickness,
    String debugLabel,
  }) {
    return fontSize != null && fontSize > 20.0
        ? title1.copyWith(
            inherit: inherit,
            color: color,
            backgroundColor: backgroundColor,
            fontFamily: fontFamily,
            fontFamilyFallback: fontFamilyFallback,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            textBaseline: textBaseline,
            height: height,
            locale: locale,
            foreground: foreground,
            background: background,
            shadows: shadows,
            fontFeatures: fontFeatures,
            decoration: decoration,
            decorationColor: decorationColor,
            decorationStyle: decorationStyle,
            decorationThickness: decorationThickness,
            debugLabel: debugLabel,
          )
        : body.copyWith(
            inherit: inherit,
            color: color,
            backgroundColor: backgroundColor,
            fontFamily: fontFamily,
            fontFamilyFallback: fontFamilyFallback,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            textBaseline: textBaseline,
            height: height,
            locale: locale,
            foreground: foreground,
            background: background,
            shadows: shadows,
            fontFeatures: fontFeatures,
            decoration: decoration,
            decorationColor: decorationColor,
            decorationStyle: decorationStyle,
            decorationThickness: decorationThickness,
            debugLabel: debugLabel,
          );
  }

  TextTheme copyWith({
    TextStyle largeTitle,
    TextStyle title1,
    TextStyle title2,
    TextStyle title3,
    TextStyle headline,
    TextStyle body,
    TextStyle callout,
    TextStyle subhead,
    TextStyle footnote,
    TextStyle caption1,
    TextStyle caption2,
  }) {
    return TextTheme.raw(
      largeTitle: largeTitle ?? this.largeTitle,
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      title3: title3 ?? this.title3,
      headline: headline ?? this.headline,
      body: body ?? this.body,
      callout: callout ?? this.callout,
      subhead: subhead ?? this.subhead,
      footnote: footnote ?? this.footnote,
      caption1: caption1 ?? this.caption1,
      caption2: caption2 ?? this.caption2,
    );
  }

  TextTheme merge(TextTheme other) {
    if (other == null) return this;
    return copyWith(
      largeTitle: largeTitle.merge(other.largeTitle) ?? this.largeTitle,
      title1: title1.merge(other.title1) ?? this.title1,
      title2: title2.merge(other.title2) ?? this.title2,
      title3: title3.merge(other.title3) ?? this.title3,
      headline: headline.merge(other.headline) ?? this.headline,
      body: body.merge(other.body) ?? this.body,
      callout: callout.merge(other.callout) ?? this.callout,
      subhead: subhead.merge(other.subhead) ?? this.subhead,
      footnote: footnote.merge(other.footnote) ?? this.footnote,
      caption1: caption1.merge(other.caption1) ?? this.caption1,
      caption2: caption2.merge(other.caption2) ?? this.caption2,
    );
  }

  TextTheme apply({
    String fontFamily,
    double fontSizeFactor = 1.0,
    double fontSizeDelta = 0.0,
    Color displayColor,
    Color bodyColor,
    TextDecoration decoration,
    Color decorationColor,
    TextDecorationStyle decorationStyle,
  }) {
    return TextTheme.raw(
      largeTitle: largeTitle?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      title1: title1?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      title2: title2?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      title3: title3?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      headline: headline?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      body: body?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      callout: callout?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      subhead: subhead?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      footnote: footnote?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      caption1: caption1?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      caption2: caption2?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
    );
  }

  static TextTheme lerp(TextTheme a, TextTheme b, double t) {
    assert(t != null);
    return TextTheme.raw(
      largeTitle: TextStyle.lerp(a?.largeTitle, b?.largeTitle, t),
      title1: TextStyle.lerp(a?.title1, b?.title1, t),
      title2: TextStyle.lerp(a?.title2, b?.title2, t),
      title3: TextStyle.lerp(a?.title3, b?.title3, t),
      headline: TextStyle.lerp(a?.headline, b?.headline, t),
      body: TextStyle.lerp(a?.body, b?.body, t),
      callout: TextStyle.lerp(a?.callout, b?.callout, t),
      subhead: TextStyle.lerp(a?.subhead, b?.subhead, t),
      footnote: TextStyle.lerp(a?.footnote, b?.footnote, t),
      caption1: TextStyle.lerp(a?.caption1, b?.caption1, t),
      caption2: TextStyle.lerp(a?.caption2, b?.caption2, t),
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final TextTheme typedOther = other;
    return largeTitle == typedOther.largeTitle &&
        title1 == typedOther.title1 &&
        title2 == typedOther.title2 &&
        title3 == typedOther.title3 &&
        headline == typedOther.headline &&
        body == typedOther.body &&
        callout == typedOther.callout &&
        subhead == typedOther.subhead &&
        footnote == typedOther.footnote &&
        caption1 == typedOther.caption1 &&
        caption2 == typedOther.caption2;
  }

  @override
  int get hashCode {
    return hashValues(
      largeTitle,
      title1,
      title2,
      title3,
      headline,
      body,
      callout,
      subhead,
      footnote,
      caption1,
      caption2,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: TextThemeData.debugFillProperties
    super.debugFillProperties(properties);
  }

  static TextTheme of(BuildContext context) {
    return Theme.of(context).textTheme;
  }
}
