import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/avatar.dart';
import '../../../common/show_alert_dialog.dart';
import '../../auth/service/auth_base.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          child: _buildUserInfo(auth.currentUser),
          preferredSize: Size.fromHeight(130),
        ),
        title: Text('Account'),
      ),
    );
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    );

    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _signOut(context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);

    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _buildUserInfo(User user) {
    return Column(children: [
      Avatar(photoUrl: user.photoURL, radius: 50),
      SizedBox(height: 8),
      if (user.displayName != null)
        Text(
          user.displayName,
          style: TextStyle(color: Colors.white),
        ),
      SizedBox(height: 8),
    ]);
  }
}
