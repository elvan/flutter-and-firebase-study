import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/app/auth/model/email_sign_in_notifier_model.dart';

import '../../../mocks.dart';

void main() {
  MockAuth mockAuth;
  EmailSignInNotifierModel model;

  setUp(() {
    mockAuth = MockAuth();
    model = EmailSignInNotifierModel(auth: mockAuth);
  });
  testWidgets('updateEmail', (tester) async {
    var didNotifyListener = false;
    const sampleEmail = 'user@example.com';

    model.addListener(() => didNotifyListener = true);
    model.updateEmail(sampleEmail);

    expect(model.email, sampleEmail);
    expect(didNotifyListener, true);
  });
}
