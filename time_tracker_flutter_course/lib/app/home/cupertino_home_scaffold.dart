import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.jobs),
          _buildItem(TabItem.entries),
          _buildItem(TabItem.account),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.indigo : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(itemData.icon),
      title: Text(
        itemData.title,
        style: TextStyle(color: color),
      ),
    );
  }
}
