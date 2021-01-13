import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../sign_in/sign_in_page.dart';
import 'auth_base.dart';

class AuthCheck extends StatefulWidget {
  final AuthBase auth;

  const AuthCheck({Key key, @required this.auth}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  User _user;

  @override
  void initState() {
    super.initState();
    _updateUser(widget.auth.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        auth: widget.auth,
        onSignIn: _updateUser,
      );
    }

    return HomePage(
      auth: widget.auth,
      onSignOut: () => _updateUser(null),
    );
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }
}
