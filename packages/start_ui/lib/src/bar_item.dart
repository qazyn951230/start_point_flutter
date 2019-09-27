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

import 'package:flutter/widgets.dart';

class BarButtonItem {
  const BarButtonItem.custom(this.child)
      : builder = null,
        icon = null,
        image = null,
        title = null;

  const BarButtonItem.builder(this.builder)
      : child = null,
        icon = null,
        image = null,
        title = null;

  const BarButtonItem.icon(this.icon)
      : builder = null,
        child = null,
        image = null,
        title = null;

  const BarButtonItem.image(this.image)
      : builder = null,
        child = null,
        icon = null,
        title = null;

  const BarButtonItem.text(this.title)
      : builder = null,
        child = null,
        icon = null,
        image = null;

  final Widget child;
  final WidgetBuilder builder;
  final Widget icon;
  final Widget image;
  final Widget title;
}
