import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../service/auth_base.dart';

class SignInBloc {
  final _isLoadingController = StreamController<bool>();
  final AuthBase auth;

  SignInBloc({@required this.auth});

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  void dispose() {
    _isLoadingController.close();
  }

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
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      rethrow;
    } finally {
      _setIsLoading(false);
    }
  }
}
