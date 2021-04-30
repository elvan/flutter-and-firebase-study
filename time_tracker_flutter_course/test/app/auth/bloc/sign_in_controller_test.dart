import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracker_flutter_course/app/auth/bloc/sign_in_controller.dart';

import '../../../mocks.dart';

class MockValueNotifier<T> extends ValueNotifier<T> {
  MockValueNotifier(T value) : super(value);

  List<T> values = [];

  @override
  set value(T newValue) {
    values.add(newValue);
    super.value = newValue;
  }
}

void main() {
  MockAuth mockAuth;
  MockValueNotifier<bool> isLoading;
  SignInController controller;

  setUp(() {
    mockAuth = MockAuth();
    isLoading = MockValueNotifier<bool>(false);
    controller = SignInController(auth: mockAuth, isLoadingNotifier: isLoading);
  });

  testWidgets('sign in -- success', (tester) async {
    when(mockAuth.signInAnonymously())
        .thenAnswer((_) => Future.value(MockUser.uid('123')));

    await controller.signInAnonymously();

    expect(isLoading.values, [true]);
  });

  testWidgets('sign in -- failure', (tester) async {
    when(mockAuth.signInAnonymously())
        .thenThrow(PlatformException(code: 'ERROR', message: 'SIGN_IN_FAILED'));

    try {
      await controller.signInAnonymously();
    } catch (e) {
      expect(isLoading.values, [true, false]);
    }
  });
}
