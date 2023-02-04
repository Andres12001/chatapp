import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Helpers/NavigationService.dart';
import 'package:flutter/material.dart';

import '../../Helpers/FirebaseMethods.dart';
import '../../View/Home/Screens/HomeView.dart';

class WelcomeVM {
  void navigationRoute(BuildContext ctx, String routeName) {
    Navigator.pushNamed(ctx, routeName);
  }

  WelcomeVM() {
    // if (myId != null &&
    //     !(FirebaseAuth.instance.currentUser?.isAnonymous ?? true)) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Navigator.pushNamedAndRemoveUntil(
    //         NavigationService.navigatorKey.currentContext!,
    //         HomeView.screenRouteName,
    //         (route) => false);
    //   });
    // }
  }

  void showSheet() {}
}
