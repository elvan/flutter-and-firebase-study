import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/widget/landing_page.dart';
import 'auth/service/auth_base.dart';
import 'auth/service/auth_service.dart';

class TimeTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => AuthService(),
      child: MaterialApp(
        title: 'Time Tracker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LandingPage(),
      ),
    );
  }
}
