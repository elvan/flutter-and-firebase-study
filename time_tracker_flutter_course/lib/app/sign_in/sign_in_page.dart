import 'package:flutter/material.dart';

import 'sign_in_button.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      backgroundColor: Colors.grey[200],
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
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
          SignInButton(
            text: 'Sign in with Google',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Sign in with Facebook',
            color: Color(0xFF3B5998),
            textColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Sign in with Email',
            color: Colors.teal[700],
            textColor: Colors.white,
            onPressed: () {},
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
            color: Colors.lime[300],
            textColor: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
