import 'string_validator.dart';

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    if (value == null) {
      return false;
    }

    return value.isNotEmpty;
  }
}
