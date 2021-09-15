import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/screens/login.dart';
import 'package:flutter_projects/services/auth.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({@required Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // final User user = snapshot.data;
            // if (user == null) {
            //   return SignInPage(
            //     auth: auth,
            //   );
            // }
            // return HomePage(
            //   auth: auth,
            // );
            return LoginPage(auth: auth, key: null,);
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
