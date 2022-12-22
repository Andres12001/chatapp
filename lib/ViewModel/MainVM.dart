import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Helpers/NavigationService.dart';
import '../View/Auth/Screens/WelcomeView.dart';
import '../View/Home/Screens/HomeView.dart';

class MainVM {
  void authStream(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        performSignout(
            NavigationService.navigatorKey.currentContext ?? context);
      } else {
        print('User is signed in!');
      }
    });
  }

  void performSignout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, WelcomeView.screenRouteName, (route) => false);
  }
}
