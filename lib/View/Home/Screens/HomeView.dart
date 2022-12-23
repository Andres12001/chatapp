import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../../Helpers/FirebaseMethods.dart';
import '../../Auth/Widgets/ButtonOriginal.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  static const String screenRouteName = "/Home";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ButtonOriginal(
          text: "signout",
          bgColor: Colors.blue,
          txtColor: Colors.white,
          onPress: () => signout(context),
          icon: Icons.person,
          width: 200),
    );
  }

  void signout(BuildContext context) {
    FirebaseMethods.onlineControl(false);
    FirebaseMethods.goOfflineDisconnect();
    _auth.signOut();
  }
}
