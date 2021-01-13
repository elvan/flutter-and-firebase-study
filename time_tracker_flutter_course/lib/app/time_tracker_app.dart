import 'package:flutter/material.dart';

import 'auth/auth_check.dart';
import 'auth/auth_service.dart';

class TimeTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: AuthCheck(
        auth: AuthService(),
      ),
    );
  }
}
