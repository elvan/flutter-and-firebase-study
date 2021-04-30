import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/validator/non_empty_string_validator.dart';

void main() {
  test('non empty string is valid', () {
    final validator = NonEmptyStringValidator();

    expect(validator.isValid('test'), true);
  });

  test('empty string is invalid', () {
    final validator = NonEmptyStringValidator();

    expect(validator.isValid(''), false);
  });
}
