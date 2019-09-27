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

import 'dart:ui' show ImageFilter;

import 'package:flutter/widgets.dart';
import 'package:start_ui/src/tab_bar_theme.dart';

import 'obstructing.dart';
import 'theme.dart';
import 'utility.dart';

const double _kDefaultHeight = 50.0;
const Border _kDefaultBorder = Border(
  top: BorderSide(width: 0.0, style: BorderStyle.solid),
);

// TODO: Adopt SystemUiOverlay
class TabBar extends StatelessWidget implements ObstructingWidget {
  const TabBar({
    Key key,
    @required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.backgroundColor,
    this.backgroundBuilder,
    this.color,
    this.unselectedColor,
    this.style,
    this.unselectedStyle,
    this.iconSize = 30.0,
    this.border = _kDefaultBorder,
    this.height = _kDefaultHeight,
    this.translucent,
  })  : assert(items != null),
        assert(
          items.length >= 2,
          "Tabs need at least 2 items to conform to Apple's HIG",
        ),
        assert(backgroundColor == null || backgroundBuilder == null),
        assert(border == null || backgroundBuilder == null),
        assert(currentIndex != null),
        assert(0 <= currentIndex && currentIndex < items.length),
        assert(iconSize != null),
        assert(height != null),
        super(key: key);

  final List<BottomNavigationBarItem> items;

  final ValueChanged<int> onTap;
  final TransitionBuilder backgroundBuilder;

  final int currentIndex;

  final Color backgroundColor;
  final Color color;
  final Color unselectedColor;
  final TextStyle style;
  final TextStyle unselectedStyle;

  final double iconSize;

  final Border border;
  final double height;
  final bool translucent;

  @override
  Size get preferredSize => Size.fromHeight(height);

  bool opaque(BuildContext context) {
    if (translucent != null) {
      return !translucent;
    }
    final barTheme = TabBarTheme.of(context);
    if (barTheme.translucent != null) {
      return !barTheme.translucent;
    }
    final backgroundColor = this.backgroundColor ?? barTheme.backgroundColor;
    return backgroundColor.alpha == 0xFF;
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    final theme = TabBarTheme.of(context);

    Widget result = SizedBox(
      height: height + bottom,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: _buildTabItems(
            color ?? theme.color,
            unselectedColor ?? theme.unselectedColor,
            style ?? theme.style,
            unselectedStyle ?? theme.unselectedStyle,
          ),
        ),
      ),
    );
    if (backgroundBuilder != null) {
      return backgroundBuilder(context, result);
    }

    final opaque = this.opaque(context);
    result = DecoratedBox(
      decoration: BoxDecoration(
        border: border == _kDefaultBorder
            ? resolveBorder(border, Theme.of(context))
            : border,
        color: resolveColorAlpha(
          backgroundColor ?? theme.backgroundColor,
          opaque,
        ),
      ),
      child: result,
    );

    return opaque
        ? result
        : ClipRect(
            child: BackdropFilter(
              // TODO: 与真实效果相去甚远
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: result,
            ),
          );
  }

  List<Widget> _buildTabItems(
    Color selectedColor,
    Color unselectedColor,
    TextStyle selectedStyle,
    TextStyle unselectedStyle,
  ) {
    return List<Widget>.generate(items.length, (index) {
      final selected = index == currentIndex;
      return Expanded(
        child: Semantics(
          selected: selected,
          // TODO: This needs localization support.
          // https://github.com/flutter/flutter/issues/13452
          hint: 'tab, ${index + 1} of ${items.length}',
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap != null ? () => onTap(index) : null,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _buildTabItem(
                  items[index],
                  selected,
                  selected ? selectedColor : unselectedColor,
                  selected ? selectedStyle : unselectedStyle,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  List<Widget> _buildTabItem(
    BottomNavigationBarItem item,
    bool selected,
    Color color,
    TextStyle style,
  ) {
    return <Widget>[
      Expanded(
        child: Center(
            child: IconTheme.merge(
          data: IconThemeData(
            color: color,
            size: iconSize,
          ),
          child: selected ? item.activeIcon : item.icon,
        )),
      ),
      if (item.title != null)
        DefaultTextStyle(
          style: style,
          child: item.title,
        )
    ];
  }

  // FIXME: copyWith
  TabBar copyWith({
    Key key,
    List<BottomNavigationBarItem> items,
    Color backgroundColor,
    Color activeColor,
    Color inactiveColor,
    Size iconSize,
    Border border,
    int currentIndex,
    ValueChanged<int> onTap,
  }) {
    return TabBar(
      key: key ?? this.key,
      items: items ?? this.items,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      color: activeColor ?? this.color,
      unselectedColor: inactiveColor ?? this.unselectedColor,
      iconSize: iconSize ?? this.iconSize,
      border: border ?? this.border,
      currentIndex: currentIndex ?? this.currentIndex,
      onTap: onTap ?? this.onTap,
    );
  }
}
