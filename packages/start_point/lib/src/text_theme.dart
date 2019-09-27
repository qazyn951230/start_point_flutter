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
import 'package:flutter/services.dart' show Brightness;
import 'package:flutter/widgets.dart';

import 'colors.dart';

/// Fonts sizes are in points. Use SF Pro Text for sizes below 20pt.
// Use SF Pro Display for sizes 20pt or greater.
// L=Light, R=Regular, SB=Semibold | L=Leading,
// B=Suggested Baseline | Short subtracts 2 pts of leading, tall adds 2 pts of leading.

// R34, 41L
const _kDefaultLightLargeLargeTitle = TextStyle(
  inherit: false,
  fontFamily: '.SF UI Display',
  fontSize: 34.0,
  fontWeight: FontWeight.normal,
  letterSpacing: 0.39,
  color: Colors.black,
);

// R28, 34L, 32B
const _kDefaultLightLargeTitle1 = TextStyle(
  inherit: false,
  fontFamily: '.SF UI Display',
  fontSize: 28.0,
  fontWeight: FontWeight.normal,
  letterSpacing: 0.36,
  color: Colors.black,
);

// R22, 28L, 28B
const _kDefaultLightLargeTitle2 = TextStyle(
  inherit: false,
  fontFamily: '.SF UI Display',
  fontSize: 22.0,
  fontWeight: FontWeight.normal,
  letterSpacing: 0.35,
  color: Colors.black,
);

// R20, 25L, 28B
const _kDefaultLightLargeTitle3 = TextStyle(
  inherit: false,
  fontFamily: '.SF UI Display',
  fontSize: 34.0,
  fontWeight: FontWeight.normal,
  letterSpacing: 0.38,
  color: Colors.black,
);

// SB17, 22L, 20B
const _kDefaultLightLargeHeadline = TextStyle(
  inherit: false,
  fontFamily: '.SF UI Text',
  fontSize: 17.0,
  fontWeight: FontWeight.w600,
  letterSpacing: -0.41,
  color: Colors.black,
);

// R17, 22L, 20B
const _kDefaultLightLargeBody = TextStyle(
  inherit: false,
  fontFamily: '.SF UI Text',
  fontSize: 17.0,
  fontWeight: FontWeight.normal,
  letterSpacing: -0.41,
  color: Colors.black,
);

// R16, 21L, 20B
const _kDefaultLightLargeCallout = TextStyle(
  inherit: false,
  fontFamily: '.SF UI Text',
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
  letterSpacing: 0.32,
  color: Colors.black,
);

// R15, 20L, 20B
const _kDefaultLightLargeSubhead = TextStyle(
  inherit: false,
  fontFamily: '.SF UI Text',
  fontSize: 15.0,
  fontWeight: FontWeight.normal,
  letterSpacing: 0.41,
  color: Colors.black,
);

// R13, 18L, 20B
const _kDefaultLightLargeFootnote = TextStyle(
  inherit: false,
  fontFamily: '.SF UI Text',
  fontSize: 13.0,
  fontWeight: FontWeight.normal,
  letterSpacing: 0.41,
  color: Colors.black,
);

// R12, 16L, 20B
const _kDefaultLightLargeCaption1 = TextStyle(
  inherit: false,
  fontFamily: '.SF UI Text',
  fontSize: 12.0,
  fontWeight: FontWeight.normal,
  letterSpacing: 0.41,
  color: Colors.black,
);

// R11, 13L, 20B
const _kDefaultLightLargeCaption2 = TextStyle(
  inherit: false,
  fontFamily: '.SF UI Text',
  fontSize: 11.0,
  fontWeight: FontWeight.normal,
  letterSpacing: 0.41,
  color: Colors.black,
);

@immutable
class TextTheme extends Diagnosticable {
  const TextTheme({
    this.largeTitle = _kDefaultLightLargeLargeTitle,
    this.title1 = _kDefaultLightLargeTitle1,
    this.title2 = _kDefaultLightLargeTitle2,
    this.title3 = _kDefaultLightLargeTitle3,
    this.headline = _kDefaultLightLargeHeadline,
    this.body = _kDefaultLightLargeBody,
    this.callout = _kDefaultLightLargeCallout,
    this.subhead = _kDefaultLightLargeSubhead,
    this.footnote = _kDefaultLightLargeFootnote,
    this.caption1 = _kDefaultLightLargeCaption1,
    this.caption2 = _kDefaultLightLargeCaption2,
  });

  /// 34
  final TextStyle largeTitle;

  /// 28
  final TextStyle title1;

  /// 22
  final TextStyle title2;

  /// 20
  final TextStyle title3;

  /// 17
  final TextStyle headline;

  /// 17
  final TextStyle body;

  /// 16
  final TextStyle callout;

  /// 15
  final TextStyle subhead;

  /// 13
  final TextStyle footnote;

  /// 12
  final TextStyle caption1;

  /// 11
  final TextStyle caption2;

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
    return TextTheme(
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
    return TextTheme(
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
    return TextTheme(
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
}
