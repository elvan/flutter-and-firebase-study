import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/view/home_page.dart';
import '../../jobs/service/database_service.dart';
import '../../jobs/service/firestore_service.dart';
import '../page/sign_in_page.dart';
import '../service/auth_base.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          }

          return Provider<DatabaseService>(
            create: (_) => FirestoreService(uid: user.uid),
            child: HomePage(),
          );
        }

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
