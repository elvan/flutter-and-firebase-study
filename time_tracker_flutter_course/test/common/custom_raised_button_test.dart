import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/common/custom_raised_button.dart';

void main() {
  testWidgets('custom raised button ...', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CustomRaisedButton(),
    ));
  });
}
