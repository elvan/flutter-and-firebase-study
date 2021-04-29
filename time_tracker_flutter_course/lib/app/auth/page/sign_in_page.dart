import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/show_exception_alert_dialog.dart';
import '../bloc/sign_in_controller.dart';
import '../service/auth_base.dart';
import '../widget/sign_in_button.dart';
import '../widget/social_sign_in_button.dart';
import 'email_sign_in_page.dart';

class SignInPage extends StatelessWidget {
  final SignInController controller;
  final bool isLoading;

  const SignInPage({
    Key key,
    @required this.controller,
    @required this.isLoading,
  }) : super(key: key);

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoadingNotifier, __) => Provider<SignInController>(
          create: (_) => SignInController(
            auth: auth,
            isLoadingNotifier: isLoadingNotifier,
          ),
          child: Consumer<SignInController>(
            builder: (_, controller, __) => SignInPage(
              controller: controller,
              isLoading: isLoadingNotifier.value,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      backgroundColor: Colors.grey[200],
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50.0, child: _buildHeader(isLoading)),
          SizedBox(height: 48.0),
          SocialSignInButton(
            text: 'Sign in with Google',
            assetName: 'images/google-logo.png',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
          ),
          SizedBox(height: 8.0),
          SocialSignInButton(
            text: 'Sign in with Facebook',
            assetName: 'images/facebook-logo.png',
            color: Color(0xFF3B5998),
            textColor: Colors.white,
            onPressed: isLoading ? null : () => _signInWithFacebook(context),
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Sign in with Email',
            color: Colors.tealAccent[700],
            textColor: Colors.white,
            onPressed: isLoading ? null : () => _signInWithEmail(context),
          ),
          SizedBox(height: 8.0),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Go anonymous',
            color: Colors.blueGrey[400],
            textColor: Colors.white,
            onPressed: isLoading ? null : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await controller.signInAnonymously();
    } on Exception catch (exc) {
      _showSignInError(context, exc);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await controller.signInWithGoogle();
    } on Exception catch (exc) {
      _showSignInError(context, exc);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await controller.signInWithFacebook();
    } on Exception catch (exc) {
      _showSignInError(context, exc);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseAuthException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }

    showExceptionAlertDialog(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
