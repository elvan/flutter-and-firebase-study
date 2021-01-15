import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/auth_base.dart';
import 'auth/auth_check.dart';
import 'auth/auth_service.dart';

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
        home: AuthCheck(),
      ),
    );
  }
}
