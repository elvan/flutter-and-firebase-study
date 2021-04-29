import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/show_alert_dialog.dart';
import '../../auth/service/auth_base.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
    );
  }

  PreferredSizeWidget _buildAppBar(context) {
    return AppBar(
      title: Text('Account'),
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
}
