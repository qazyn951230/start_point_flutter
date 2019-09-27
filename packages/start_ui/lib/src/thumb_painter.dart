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

//import 'package:flutter/painting.dart';
//
//import 'colors.dart';
//
//class ThumbPainter {
//  ThumbPainter({
//    this.color = Colors.white,
//    this.shadowColor = const Color(0x2C000000),
//  }) : _shadowPaint = BoxShadow(
//          color: shadowColor,
//          blurRadius: 1.0,
//        ).toPaint();
//
//  final Color color;
//
//  final Color shadowColor;
//
//  final Paint _shadowPaint;
//
//  static const double radius = 14.0;
//
//  static const double extension = 7.0;
//
//  void paint(Canvas canvas, Rect rect) {
//    final RRect rrect = RRect.fromRectAndRadius(
//      rect,
//      Radius.circular(rect.shortestSide / 2.0),
//    );
//
//    canvas.drawRRect(rrect, _shadowPaint);
//    canvas.drawRRect(rrect.shift(const Offset(0.0, 3.0)), _shadowPaint);
//    canvas.drawRRect(rrect, Paint()..color = color);
//  }
//}
