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

import 'dart:ui' show Color;

// https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/
class UIColor {
  UIColor._();

  static const Color invalidColor = Color(0xFFFFFFFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  static const Color lightBlue = Color(0xFF007AFF);
  static const Color lightGray = Color(0xFF8E8E93);
  static const Color lightGray2 = Color(0xFFAEAEB2);
  static const Color lightGray3 = Color(0xFFC7C7CC);
  static const Color lightGray4 = Color(0xFFD1D1D6);
  static const Color lightGray5 = Color(0xFFE5E5EA);
  static const Color lightGray6 = Color(0xFFF2F2F7);
  static const Color lightGreen = Color(0xFF34C759);
  static const Color lightIndigo = Color(0xFF5856D6);
  static const Color lightOrange = Color(0xFFFF9500);
  static const Color lightPink = Color(0xFFFF2C55);
  static const Color lightPurple = Color(0xFFA84ED5);
  static const Color lightRed = Color(0xFFFF3B30);
  static const Color lightTeal = Color(0xFF59C8FA);
  static const Color lightYellow = Color(0xFFFFCC00);
  static const Color lightBarBackground = Color(0xF0F9F9F9);
  static const Color lightBorderColor = Color(0x4C000000);

  static const Color darkBlue = Color(0xFF0A84FF);
  static const Color darkGray = Color(0xFF8E8E93);
  static const Color darkGray2 = Color(0xFF838388);
  static const Color darkGray3 = Color(0xFF59595C);
  static const Color darkGray4 = Color(0xFF353537);
  static const Color darkGray5 = Color(0xFF28282A);
  static const Color darkGray6 = Color(0xFFF2F2F7);
  static const Color darkGreen = Color(0xFF1B1B1D);
  static const Color darkIndigo = Color(0xFF5E5CE6);
  static const Color darkOrange = Color(0xFFFF9F08);
  static const Color darkPink = Color(0xFFFF375F);
  static const Color darkPurple = Color(0xFFB756E8);
  static const Color darkRed = Color(0xFFFF453A);
  static const Color darkTeal = Color(0xFF64D2FF);
  static const Color darkYellow = Color(0xFFFFD50B);
  static const Color darkBarBackground = Color(0xF0161616);
  static const Color darkBorderColor = Color(0x28FFFFFF);

  static Color blue(bool light) => light ? lightBlue : darkBlue;
  static Color gray(bool light) => lightGray;
  static Color gray2(bool light) => light ? lightGray2 : darkGray2;
  static Color gray3(bool light) => light ? lightGray3 : darkGray3;
  static Color gray4(bool light) => light ? lightGray4 : darkGray4;
  static Color gray5(bool light) => light ? lightGray5 : darkGray5;
  static Color gray6(bool light) => light ? lightGray6 : darkGray6;
  static Color green(bool light) => light ? lightGreen : darkGreen;
  static Color indigo(bool light) => light ? lightIndigo : darkIndigo;
  static Color orange(bool light) => light ? lightOrange : darkOrange;
  static Color pink(bool light) => light ? lightPink : darkPink;
  static Color purple(bool light) => light ? lightPurple : darkPurple;
  static Color red(bool light) => light ? lightRed : darkRed;
  static Color teal(bool light) => light ? lightTeal : darkTeal;
  static Color yellow(bool light) => light ? lightYellow : darkYellow;
  static Color barBackground(bool light) =>
      light ? lightBarBackground : darkBarBackground;
  static Color borderColor(bool light) =>
      light ? lightBorderColor : darkBorderColor;

  static bool isInvalid(Color color) => identical(invalidColor, color);
}
