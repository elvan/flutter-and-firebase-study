import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem {
  jobs,
  entries,
  account,
}

class TabItemData {
  final IconData icon;
  final String title;

  const TabItemData({@required this.icon, @required this.title});

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.jobs: TabItemData(title: 'Jobs', icon: Icons.work),
    TabItem.entries: TabItemData(title: 'Entries', icon: Icons.view_headline),
    TabItem.account: TabItemData(title: 'Account', icon: Icons.person),
  };
}
