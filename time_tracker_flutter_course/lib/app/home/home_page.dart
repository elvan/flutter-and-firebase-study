import 'package:flutter/material.dart';

import '../auth/auth_base.dart';

class HomePage extends StatelessWidget {
  final AuthBase auth;
  final VoidCallback onSignOut;

  const HomePage({
    Key key,
    @required this.auth,
    @required this.onSignOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Home Page'),
      actions: [
        FlatButton(
          onPressed: _signOut,
          child: Text(
            'Sign Out',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      onSignOut();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
