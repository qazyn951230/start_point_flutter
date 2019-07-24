import 'package:flutter/widgets.dart';

import 'page_scaffold.dart';

const double _kDefaultNavigationBarHeight = 44.0;

class NavigationBar extends StatefulWidget
    implements ObstructingPreferredSizeWidget {
  const NavigationBar({
    Key key,
    this.height = _kDefaultNavigationBarHeight,
  }) : super(key: key);

  final double height;

  @override
  _NavigationBarState createState() => _NavigationBarState();

  @override
  bool get fullObstruction => null;

  @override
  Size get preferredSize => null;
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
