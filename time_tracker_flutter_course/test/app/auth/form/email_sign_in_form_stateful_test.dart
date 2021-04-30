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

  Future<void> pumpEmailSignInForm(
    WidgetTester tester, {
    VoidCallback onSignIn,
  }) async {
    await tester.pumpWidget(Provider<AuthBase>(
      create: (_) => mockAuth,
      child: MaterialApp(
        home: Scaffold(
          body: EmailSignInFormStateful(
            onSignIn: onSignIn,
          ),
        ),
      ),
    ));
  }

  group('sign in', () {
    testWidgets(
        'WHEN user doesnt enter the email and password '
        'AND user taps on the sign-in button '
        'THEN signInWithEmailAndPassword is not called '
        'AND user is not signed-in', (tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignIn: () => signedIn = true);

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
      expect(signedIn, false);
    });

    testWidgets(
        'WHEN user enters a valid email and password '
        'AND user taps on the sign-in button '
        'THEN signInWithEmailAndPassword is called '
        'AND user is signed in', (tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignIn: () => signedIn = true);

      const email = 'user@example.com';
      const password = 'pswd1234';

      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      final passwordField = find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      await tester.pump();

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
      expect(signedIn, true);
    });
  });

  group('register', () {
    testWidgets(
        'WHEN user taps on the secondary button '
        'THEN form toggles to reqgistration mode', (tester) async {
      await pumpEmailSignInForm(tester);

      final registerButton = find.text('Need an account? Register');
      await tester.tap(registerButton);

      await tester.pump();

      final createAccountButton = find.text('Create an account');
      expect(createAccountButton, findsOneWidget);
    });

    testWidgets(
        'WHEN user taps on the secondary button '
        'AND user enters the email and password '
        'AND user taps on the register button '
        'THEN createUserWithEmailAndPassword is called', (tester) async {
      await pumpEmailSignInForm(tester);

      const email = 'user@example.com';
      const password = 'pswd1234';

      final registerButton = find.text('Need an account? Register');
      await tester.tap(registerButton);

      await tester.pump();

      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      final passwordField = find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      await tester.pump();

      final createAccountButton = find.text('Create an account');
      expect(createAccountButton, findsOneWidget);
      await tester.tap(createAccountButton);

      verify(mockAuth.createUserWithEmailAndPassword(email, password))
          .called(1);
    });
  });
}
