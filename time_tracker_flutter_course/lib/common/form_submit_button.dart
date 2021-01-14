import 'package:flutter/material.dart';

import 'custom_raised_button.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
          height: 44.0,
          color: Colors.tealAccent[700],
          borderRadius: 4.0,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        );
}
