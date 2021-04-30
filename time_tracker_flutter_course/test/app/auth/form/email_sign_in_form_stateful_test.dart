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

  group('sign in', () {
    testWidgets(
        'WHEN user doesnt enter the email and password '
        'AND user taps on the sign-in button '
        'THEN signInWithEmailAndPassword is not called', (tester) async {
      await pumpEmailSignInForm(tester);

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
    });

    testWidgets(
        'WHEN user enters the email and password '
        'AND user taps on the sign-in button '
        'THEN signInWithEmailAndPassword is called', (tester) async {
      await pumpEmailSignInForm(tester);

      const email = 'user@example.com';
      const password = 'pswd1234';

      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      final passwordField = find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      // rebuild when the widget calls setState()
      await tester.pump();

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verify(mockAuth.signInWithEmailAndPassword(email, password));
    });
  });

  group('register', () {
    testWidgets(
        'WHEN user doesnt enter the email and password '
        'AND user taps on the sign-in button '
        'THEN createUserWithEmailAndPassword is not called', (tester) async {
      await pumpEmailSignInForm(tester);

      final registerButton = find.text('Need an account? Register');
      await tester.tap(registerButton);

      await tester.pump();

      final createAccountButton = find.text('Create an account');
      expect(createAccountButton, findsOneWidget);
    });
  });
}
