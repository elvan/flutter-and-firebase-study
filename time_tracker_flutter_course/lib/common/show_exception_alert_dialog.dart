import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'show_alert_dialog.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context, {
  @required String title,
  @required Exception exception,
}) {
  return showAlertDialog(
    context,
    title: title,
    content: _message(exception),
    defaultActionText: 'OK',
  );
}

String _message(Exception exception) {
  if (exception is FirebaseAuthException) {
    return exception.message;
  }
  return exception.toString();
}
