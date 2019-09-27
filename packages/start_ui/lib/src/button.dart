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
import 'package:flutter/widgets.dart';

import 'colors.dart';
import 'rounded_border.dart';
import 'theme.dart';

class Button extends StatefulWidget {
  Button({
    Key key,
    @required this.child,
    this.onPressed,
    Color color,
    Color disabledColor,
    TextStyle style,
    TextStyle disabledStyle,
    EdgeInsetsGeometry padding,
    Decoration decoration,
    BoxConstraints constraints,
    double minWidth = 44.0,
    double minHeight = 44.0,
  })  : assert(child != null),
        childDelegate = SystemButtonChildDelegate(
          color: color,
          disabledColor: disabledColor,
          style: style,
          disabledStyle: disabledStyle,
          padding: padding,
          decoration: decoration,
          constraints: constraints ??
              BoxConstraints(
                minWidth: minWidth ?? 0.0,
                minHeight: minHeight ?? 0.0,
              ),
        );

  Button.bordered({
    Key key,
    @required this.child,
    this.onPressed,
    Color color,
    Color disabledColor,
    TextStyle style,
    TextStyle disabledStyle,
    EdgeInsetsGeometry padding,
    Decoration decoration,
    BoxConstraints constraints,
  })  : assert(child != null),
        childDelegate = SystemButtonChildDelegate(
          color: color,
          disabledColor: disabledColor,
          style: style,
          disabledStyle: disabledStyle,
          padding: padding,
          decoration: decoration,
          constraints: constraints,
        );

  Button.filled({
    Key key,
    @required this.child,
    this.onPressed,
    Color color,
    Color disabledColor,
    Color backgroundColor,
    Color disabledBackgroundColor,
    TextStyle style,
    TextStyle disabledStyle,
    EdgeInsetsGeometry padding,
    BoxDecoration decoration,
    BoxConstraints constraints,
    double minHeight = 44.0,
    BorderRadius borderRadius = const BorderRadius.horizontal(
      left: Radius.circular(4.0),
      right: Radius.circular(4.0),
    ),
  })  : assert(child != null),
        assert(decoration == null || borderRadius == null),
        childDelegate = FillButtonChildDelegate(
          color: color ?? disabledColor,
          disabledColor: disabledColor ?? color,
          backgroundColor: backgroundColor ?? disabledBackgroundColor,
          disabledBackgroundColor: disabledBackgroundColor ?? backgroundColor,
          style: style,
          disabledStyle: disabledStyle,
          padding: padding,
          decoration: decoration,
          borderRadius: borderRadius,
          constraints: constraints ??
              BoxConstraints(
                minHeight: minHeight ?? 0.0,
              ),
        );

  Button.square({
    Key key,
    @required this.child,
    this.onPressed,
    Color color,
    Color disabledColor,
    Color backgroundColor,
    Color disabledBackgroundColor,
    TextStyle style,
    TextStyle disabledStyle,
    EdgeInsetsGeometry padding,
    BoxDecoration decoration,
    BoxConstraints constraints,
    double minHeight = 44.0,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(0.0)),
  })  : assert(child != null),
        assert(decoration == null || borderRadius == null),
        childDelegate = FillButtonChildDelegate(
          color: color ?? disabledColor,
          disabledColor: disabledColor ?? color,
          backgroundColor: backgroundColor ?? disabledBackgroundColor,
          disabledBackgroundColor: disabledBackgroundColor ?? backgroundColor,
          style: style,
          disabledStyle: disabledStyle,
          padding: padding,
          decoration: decoration,
          borderRadius: borderRadius,
          constraints: constraints ??
              BoxConstraints(
                minHeight: minHeight ?? 0.0,
              ),
        );

  Button.rounded({
    Key key,
    @required this.child,
    this.onPressed,
    Color color,
    Color disabledColor,
    Color backgroundColor,
    Color disabledBackgroundColor,
    TextStyle style,
    TextStyle disabledStyle,
    EdgeInsetsGeometry padding,
    ShapeDecoration decoration,
    RoundedBorder border,
    BoxConstraints constraints,
    double minHeight = 44.0,
  })  : assert(child != null),
        assert(decoration == null || border == null),
        childDelegate = RoundedButtonChildDelegate(
          color: color ?? disabledColor,
          disabledColor: disabledColor ?? color,
          backgroundColor: backgroundColor ?? disabledBackgroundColor,
          disabledBackgroundColor: disabledBackgroundColor ?? backgroundColor,
          style: style,
          disabledStyle: disabledStyle,
          padding: padding,
          decoration: decoration ??
              ShapeDecoration(shape: border ?? const RoundedBorder()),
          constraints: constraints ??
              BoxConstraints(
                minHeight: minHeight ?? 0.0,
              ),
        );

  Button.image({
    Key key,
    @required Widget child,
    this.onPressed,
    EdgeInsetsGeometry padding,
  })  : child = child,
        childDelegate = CustomButtonChildDelegate(
          padding: padding,
        );

  Button.icon({
    Key key,
    @required Widget child,
    this.onPressed,
    EdgeInsetsGeometry padding,
    Color color,
    Color disabledColor,
    double iconSize = 24.0,
  })  : assert(iconSize != null),
        child = child,
        childDelegate = CustomButtonChildDelegate(
          color: color,
          disabledColor: disabledColor,
          padding: padding,
          iconTheme: IconThemeData(size: iconSize),
          size: Size(iconSize, iconSize),
        );

  Button.custom({
    Key key,
    @required this.child,
    this.onPressed,
    TransitionBuilder backgroundBuilder,
  })  : assert(child != null),
        childDelegate = backgroundBuilder == null
            ? null
            : _FunctionChildDelegate(backgroundBuilder);

  bool get enabled => onPressed != null;

  final Widget child;
  final VoidCallback onPressed;
  final ButtonChildDelegate childDelegate;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    Widget result = widget.child;
    if (widget.childDelegate != null) {
      result = widget.childDelegate.build(
        context,
        widget.child,
        widget.enabled,
      );
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onPressed,
      child: Semantics(
        button: true,
        enabled: widget.enabled,
        child: result,
      ),
    );
  }
}

abstract class ButtonChildDelegate {
  const ButtonChildDelegate();

  Widget build(BuildContext context, Widget child, bool enabled);

  @protected
  Widget buildContent(
    BuildContext context,
    Widget child, {
    Color color,
    TextStyle style,
    EdgeInsetsGeometry padding,
    Decoration decoration,
    BoxConstraints constraints,
    IconThemeData iconTheme,
    Size size,
  }) {
    var result = child;
    if (iconTheme != null) {
      result = IconTheme(
        data: iconTheme,
        child: result,
      );
    }
    if (style != null) {
      result = DefaultTextStyle(
        style: style,
        child: result,
      );
    }
    result = Center(
      widthFactor: 1.0,
      heightFactor: 1.0,
      child: result,
    );
    if (size != null) {
      result = SizedBox(
        width: size.width,
        height: size.height,
        child: result,
      );
    }

    if (padding != null) {
      result = Padding(
        padding: padding,
        child: result,
      );
    }
    if (decoration != null) {
      result = DecoratedBox(
        decoration: decoration,
        child: result,
      );
    }
    if (constraints != null) {
      result = ConstrainedBox(
        constraints: constraints,
        child: result,
      );
    }
    return result;
  }
}

class _FunctionChildDelegate extends ButtonChildDelegate {
  _FunctionChildDelegate(this.builder) : assert(builder != null);

  final TransitionBuilder builder;

  @override
  Widget build(BuildContext context, Widget child, bool enabled) {
    return builder(context, child);
  }
}

class SystemButtonChildDelegate extends ButtonChildDelegate {
  const SystemButtonChildDelegate({
    this.color,
    this.style,
    this.disabledColor,
    this.disabledStyle,
    this.padding,
    this.decoration,
    this.constraints,
    this.iconTheme,
    this.size,
  });

  final IconThemeData iconTheme;
  final Color color;
  final Color disabledColor;
  final TextStyle style;
  final TextStyle disabledStyle;
  final Size size;
  final EdgeInsetsGeometry padding;
  final Decoration decoration;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, Widget child, bool enabled) {
    final theme = Theme.of(context);
    final color = enabled ? this.color : disabledColor;
    return buildContent(
      context,
      child,
      constraints: constraints ?? const BoxConstraints(),
      decoration: decoration,
      padding: padding,
      size: size,
      style: (style != null || disabledStyle != null)
          ? enabled ? style : disabledStyle
          : theme.textTheme.body.copyWith(
              color: color ?? UIColor.white,
            ),
      iconTheme: color != null
          ? (iconTheme?.copyWith(color: color) ?? IconThemeData(color: color))
          : iconTheme,
    );
  }
}

class FillButtonChildDelegate extends ButtonChildDelegate {
  const FillButtonChildDelegate({
    this.color,
    this.style,
    this.disabledColor,
    this.disabledStyle,
    this.padding,
    this.decoration,
    this.constraints,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.iconTheme,
    this.size,
    this.borderRadius,
  });

  final IconThemeData iconTheme;
  final Color color;
  final Color disabledColor;
  final TextStyle style;
  final TextStyle disabledStyle;
  final Size size;
  final EdgeInsetsGeometry padding;
  final BoxDecoration decoration;
  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final BoxConstraints constraints;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context, Widget child, bool enabled) {
    final theme = Theme.of(context);
    final color = enabled ? this.color : disabledColor;
    final backgroundColor =
        (enabled ? this.backgroundColor : disabledBackgroundColor) ??
            UIColor.blue(theme.isLight);
    final style = (this.style != null && disabledStyle != null)
        ? (enabled ? this.style : disabledStyle)
        : theme.textTheme.textStyle(color: color ?? UIColor.white);
    return buildContent(
      context,
      child,
      constraints: constraints ?? const BoxConstraints(),
      decoration: decoration ??
          BoxDecoration(color: backgroundColor, borderRadius: borderRadius),
      padding: padding,
      size: size,
      style: style,
      iconTheme: color != null
          ? (iconTheme?.copyWith(color: color) ?? IconThemeData(color: color))
          : iconTheme,
    );
  }
}

class RoundedButtonChildDelegate extends ButtonChildDelegate {
  const RoundedButtonChildDelegate({
    this.color,
    this.style,
    this.disabledColor,
    this.disabledStyle,
    this.padding,
    this.decoration,
    this.constraints,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.iconTheme,
    this.size,
  });

  final IconThemeData iconTheme;
  final Color color;
  final Color disabledColor;
  final TextStyle style;
  final TextStyle disabledStyle;
  final Size size;
  final EdgeInsetsGeometry padding;
  final ShapeDecoration decoration;
  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, Widget child, bool enabled) {
    final theme = Theme.of(context);
    final color = enabled ? this.color : disabledColor;
    final backgroundColor =
        (enabled ? this.backgroundColor : disabledBackgroundColor) ??
            UIColor.blue(theme.isLight);
    return buildContent(
      context,
      child,
      constraints: constraints ?? const BoxConstraints(),
      decoration: decoration != null
          ? ShapeDecoration(
              shape: decoration.shape,
              color: backgroundColor,
            )
          : ShapeDecoration(shape: RoundedBorder(), color: backgroundColor),
      padding: padding,
      size: size,
      style: (style != null && disabledStyle != null)
          ? (enabled ? style : disabledStyle)
          : theme.textTheme.textStyle(
              color: color ?? UIColor.white,
            ),
      iconTheme: color != null
          ? (iconTheme?.copyWith(color: color) ?? IconThemeData(color: color))
          : iconTheme,
    );
  }
}

class CustomButtonChildDelegate extends ButtonChildDelegate {
  const CustomButtonChildDelegate({
    this.color,
    this.disabledColor,
    this.style,
    this.disabledStyle,
    this.padding,
    this.decoration,
    this.constraints,
    this.size,
    this.iconTheme,
  });

  final Color color;
  final Color disabledColor;
  final TextStyle style;
  final TextStyle disabledStyle;
  final EdgeInsetsGeometry padding;
  final Decoration decoration;
  final BoxConstraints constraints;
  final Size size;
  final IconThemeData iconTheme;

  @override
  Widget build(BuildContext context, Widget child, bool enabled) {
    final theme = Theme.of(context);
    var iconData = iconTheme ?? IconThemeData();
    if (color != null && disabledColor != null) {
      iconData = iconData.copyWith(
        color: enabled ? color : disabledColor,
      );
    }
    var textStyle = theme.textTheme.body;
    if (style != null && disabledStyle != null) {
      textStyle = enabled ? style : disabledStyle;
    }
    if (textStyle.color == null && color != null && disabledColor != null) {
      textStyle = textStyle.copyWith(
        color: enabled ? color : disabledColor,
      );
    }
    return ConstrainedBox(
      constraints: constraints ?? const BoxConstraints(),
      child: DecoratedBox(
        decoration: decoration ?? const BoxDecoration(),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(0.0),
          child: SizedBox(
            width: size?.width,
            height: size?.height,
            child: Center(
              child: DefaultTextStyle(
                style: textStyle,
                child: IconTheme(
                  data: iconData,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
