import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/entries/page/entries_page.dart';

import '../../account/page/account_page.dart';
import '../../jobs/page/jobs_page.dart';
import '../model/tab_item.dart';
import '../widget/cupertino_home_scaffold.dart';

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
      TabItem.entries: (context) => EntriesPage.create(context),
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
    if (tabItem == _currentTab) {
      // pop to first route
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }
}
