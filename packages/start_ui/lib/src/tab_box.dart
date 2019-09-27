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

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'tab_decoration.dart';

class TabDecoratedBox extends SingleChildRenderObjectWidget {
  const TabDecoratedBox({
    Key key,
    @required this.decoration,
    @required this.delegate,
    this.position = DecorationPosition.background,
    Widget child,
  })  : assert(decoration != null),
        assert(position != null),
        super(key: key, child: child);

  final TabDecoration decoration;
  final DecorationPosition position;
  final TabPainterDelegate delegate;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderTabDecoratedBox(
      decoration: decoration,
      delegate: delegate,
      position: position,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderTabDecoratedBox renderObject) {
    renderObject
      ..decoration = decoration
      ..delegate = delegate
      ..position = position;
  }

//  @override
//  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//    super.debugFillProperties(properties);
//  }
}

class RenderTabDecoratedBox extends RenderProxyBox {
  RenderTabDecoratedBox({
    @required TabDecoration decoration,
    @required TabPainterDelegate delegate,
    DecorationPosition position = DecorationPosition.background,
    RenderBox child,
  })  : assert(decoration != null),
        assert(position != null),
        _decoration = decoration,
        _delegate = delegate,
        _position = position,
        super(child);

  TabPainter _painter;

  TabDecoration get decoration => _decoration;
  TabDecoration _decoration;
  set decoration(TabDecoration value) {
    assert(value != null);
    if (value == _decoration) return;
    _painter?.dispose();
    _painter = null;
    _decoration = value;
    markNeedsPaint();
  }

  TabPainterDelegate get delegate => _delegate;
  TabPainterDelegate _delegate;
  set delegate(TabPainterDelegate value) {
    assert(value != null);
    if (value == _delegate) return;
    _painter?.dispose();
    _painter = null;
    _delegate = value;
    markNeedsPaint();
  }

  DecorationPosition get position => _position;
  DecorationPosition _position;
  set position(DecorationPosition value) {
    assert(value != null);
    if (value == _position) return;
    _position = value;
    markNeedsPaint();
  }

  @override
  void detach() {
    _painter?.dispose();
    _painter = null;
    super.detach();
    markNeedsPaint();
  }

//  @override
//  bool hitTestSelf(Offset position) {}

  @override
  void paint(PaintingContext context, Offset offset) {
    assert(size.width != null);
    assert(size.height != null);
    _painter ??= _decoration.createTabPainter(delegate, markNeedsPaint);
    if (position == DecorationPosition.background) {
      int debugSaveCount;
      assert(() {
        debugSaveCount = context.canvas.getSaveCount();
        return true;
      }());
      _painter.paint(context.canvas, offset, size);
      assert(() {
        if (debugSaveCount != context.canvas.getSaveCount()) {
          throw FlutterError(
              '${_decoration.runtimeType} painter had mismatching save and restore calls.\n'
              'Before painting the decoration, the canvas save count was $debugSaveCount. '
              'After painting it, the canvas save count was ${context.canvas.getSaveCount()}. '
              'Every call to save() or saveLayer() must be matched by a call to restore().\n'
              'The decoration was:\n'
              '  $decoration\n'
              'The painter was:\n'
              '  $_painter');
        }
        return true;
      }());
    }
    super.paint(context, offset);
    if (position == DecorationPosition.foreground) {
      _painter.paint(context.canvas, offset, size);
    }
  }

//  @override
//  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//    super.debugFillProperties(properties);
//  }
}
