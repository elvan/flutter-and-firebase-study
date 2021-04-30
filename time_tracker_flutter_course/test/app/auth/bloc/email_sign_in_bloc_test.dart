import 'package:flutter_test/flutter_test.dart';
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
    expect(bloc.modelStream, emits(EmailSignInModel()));
  });
}
