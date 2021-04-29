import 'package:flutter/material.dart';

import '../jobs/view/jobs_page.dart';
import 'account/account_page.dart';
import 'cupertino_home_scaffold.dart';
import 'tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.jobs;

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (context) => JobsPage(),
      TabItem.entries: (context) => Container(),
      TabItem.account: (context) => AccountPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScaffold(
      currentTab: _currentTab,
      onSelectTab: _select,
      widgetBuilders: widgetBuilders,
    );
  }

  void _select(TabItem tabItem) {
    setState(() {
      _currentTab = tabItem;
    });
  }
}
