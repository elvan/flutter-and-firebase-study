import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/show_exception_alert_dialog.dart';
import '../auth/auth_base.dart';
import 'email_sign_in_page.dart';
import 'sign_in_button.dart';
import 'social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
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
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 48.0),
          SocialSignInButton(
            text: 'Sign in with Google',
            assetName: 'images/google-logo.png',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: () => _signInWithGoogle(context),
          ),
          SizedBox(height: 8.0),
          SocialSignInButton(
            text: 'Sign in with Facebook',
            assetName: 'images/facebook-logo.png',
            color: Color(0xFF3B5998),
            textColor: Colors.white,
            onPressed: () => _signInWithFacebook(context),
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Sign in with Email',
            color: Colors.tealAccent[700],
            textColor: Colors.white,
            onPressed: () => _signInWithEmail(context),
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
            onPressed: () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);

    try {
      await auth.signInWithGoogle();
    } on Exception catch (exc) {
      _showSignInError(context, exc);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);

    try {
      await auth.signInWithFacebook();
    } on Exception catch (exc) {
      _showSignInError(context, exc);
    }
  }

  void _signInWithEmail(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);

    try {
      await auth.signInAnonymously();
    } on Exception catch (exc) {
      _showSignInError(context, exc);
    }
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
}
