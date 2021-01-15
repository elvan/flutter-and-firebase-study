import 'dart:async';

import '../model/email_sign_in_model.dart';

class EmailSignInBloc {
  final _modelController = StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  void dispose() {
    _modelController.close();
  }
}
