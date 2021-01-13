import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/time_tracker_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TimeTrackerApp());
}
