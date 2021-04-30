import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracker_flutter_course/app/auth/service/auth_base.dart';
import 'package:time_tracker_flutter_course/app/jobs/service/database_service.dart';

class MockAuth extends Mock implements AuthBase {}

class MockDatabase extends Mock implements DatabaseService {}

class MockUser extends Mock implements User {
  MockUser();

  factory MockUser.uid(String uid) {
    final user = MockUser();
    when(user.uid).thenReturn(uid);

    return user;
  }
}
