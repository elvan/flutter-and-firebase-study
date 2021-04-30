import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/auth/form/email_sign_in_form_stateful.dart';
import 'package:time_tracker_flutter_course/app/auth/service/auth_base.dart';

class MockAuth extends Mock implements AuthBase {}

void main() {
  MockAuth mockAuth;

  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpEmailSignInForm(WidgetTester tester) async {
    await tester.pumpWidget(Provider<AuthBase>(
      create: (_) => mockAuth,
      child: MaterialApp(
        home: Scaffold(
          body: EmailSignInFormStateful(),
        ),
      ),
    ));
  }

  testWidgets(
      'WHEN user doesnt enter the email and password'
      'AND user taps on the sign-in button'
      'THEN signInWithEmailAndPassword is not called', (tester) async {
    await pumpEmailSignInForm(tester);

    final signInButton = find.text('Sign in');
    await tester.tap(signInButton);

    verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
  });
}
