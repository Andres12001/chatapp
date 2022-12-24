import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';

import '../Helpers/FirebaseMethods.dart';
import '../Helpers/NavigationService.dart';
import '../View/Auth/Screens/WelcomeView.dart';

class MainVM {
  void authStream(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      myId = user?.uid;

      if (user == null) {
        performSignout(
            NavigationService.navigatorKey.currentContext ?? context);
      } else {
        FirebaseMethods.onlineControl(true);
      }
    });
  }

  void performSignout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, WelcomeView.screenRouteName, (route) => false);
  }

  void performStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        FirebaseMethods.onlineControl(true);
        break;
      case AppLifecycleState.inactive:
        FirebaseMethods.onlineControl(false);
        FirebaseMethods.goOfflineDisconnect();
        break;
      case AppLifecycleState.paused:
        FirebaseMethods.onlineControl(false);
        FirebaseMethods.goOfflineDisconnect();
        break;
      case AppLifecycleState.detached:
        FirebaseMethods.onlineControl(false);
        FirebaseMethods.goOfflineDisconnect();
        break;
      default:
        break;
    }
  }

  void performEventChange(FGBGType event) {
    switch (event) {
      case FGBGType.foreground:
        FirebaseMethods.onlineControl(true);
        break;
      case FGBGType.background:
        FirebaseMethods.onlineControl(false);
        FirebaseMethods.goOfflineDisconnect();

        break;
      default:
    }
  }
}
