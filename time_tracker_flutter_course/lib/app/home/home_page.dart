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

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.jobs: GlobalKey<NavigatorState>(),
    TabItem.entries: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (context) => JobsPage(),
      TabItem.entries: (context) => Container(),
      TabItem.account: (context) => AccountPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        navigatorKeys: navigatorKeys,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
      ),
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
    );
  }

  void _select(TabItem tabItem) {
    setState(() {
      _currentTab = tabItem;
    });
  }
}
