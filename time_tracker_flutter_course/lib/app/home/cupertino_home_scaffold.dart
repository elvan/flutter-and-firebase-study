import 'package:flutter/cupertino.dart';

import 'tab_item.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  const CupertinoHomeScaffold({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
