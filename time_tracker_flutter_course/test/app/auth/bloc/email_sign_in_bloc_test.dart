import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracker_flutter_course/app/auth/bloc/email_sign_in_bloc.dart';
import 'package:time_tracker_flutter_course/app/auth/model/email_sign_in_model.dart';

import '../../../mocks.dart';

void main() {
  MockAuth mockAuth;
  EmailSignInBloc bloc;

  setUp(() {
    mockAuth = MockAuth();
    bloc = EmailSignInBloc(auth: mockAuth);
  });

  tearDown(() {
    bloc.dispose();
  });

  testWidgets(
      'WHEN email is updated '
      'AND password is updated '
      'AND submit is called '
      'THEN modelStream emits the correct events', (tester) async {
    when(mockAuth.signInWithEmailAndPassword(any, any))
        .thenThrow(PlatformException(code: 'ERROR'));

    expect(
      bloc.modelStream,
      emitsInOrder([
        EmailSignInModel(),
        EmailSignInModel(email: 'user@example.com'),
        EmailSignInModel(
          email: 'user@example.com',
          password: 'pswd1234',
        ),
        EmailSignInModel(
          email: 'user@example.com',
          password: 'pswd1234',
          submitted: true,
          isLoading: true,
        ),
        EmailSignInModel(
          email: 'user@example.com',
          password: 'pswd1234',
          submitted: true,
          isLoading: false,
        )
      ]),
    );

    bloc.updateEmail('user@example.com');
    bloc.updatePassword('pswd1234');

    try {
      await bloc.submit();
    } catch (e) {}
  });
}
