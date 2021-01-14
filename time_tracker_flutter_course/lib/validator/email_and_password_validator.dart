import 'non_empty_string_validator.dart';

class EmailAndPasswordValidator {
  final emailValidator = NonEmptyStringValidator();
  final passwordValidator = NonEmptyStringValidator();

  final invalidEmailErrorText = 'Email can\'t be empty';
  final invalidPasswordErrorText = 'Password can\'t be empty';
}
