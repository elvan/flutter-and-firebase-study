import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../service/auth_base.dart';

class SignInBloc {
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  SignInBloc({
    @required this.auth,
    this.isLoading,
  });

  Future<User> signInAnonymously() async {
    return await _signIn(auth.signInAnonymously);
  }

  Future<User> signInWithGoogle() async {
    return await _signIn(auth.signInWithGoogle);
  }

  Future<User> signInWithFacebook() async {
    return await _signIn(auth.signInWithFacebook);
  }

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }
}
