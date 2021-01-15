import 'package:flutter/material.dart';

import 'auth_base.dart';

class AuthProvider extends InheritedWidget {
  final AuthBase auth;
  final Widget child;

  AuthProvider({@required this.auth, @required this.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static AuthBase of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>().auth;
  }
}
