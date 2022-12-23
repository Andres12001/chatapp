// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/View/Auth/Screens/SignupView.dart';
import 'package:first_app/View/Auth/Screens/WelcomeView.dart';
import 'package:first_app/View/Home/Screens/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants/FirebaseMessages.dart';
import '../../Helpers/FirebaseAuthMethods.dart';
import '../../Helpers/ListenedValues.dart';

class LoginVM {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuthMethods _firebaseAuthMethods = FirebaseAuthMethods();

  void fieldUpdate(String value, TextEditingController controller) {
    // controller.text = value;
    // print(controller.text);
  }

  void loginPre({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    if (password.trim().isEmpty || email.trim().isEmpty) {
      print("Please fill all fields");
      return;
    }
    Provider.of<ListenedValues>(context, listen: false).setLoading(true);
    _firebaseAuthMethods.loginUsingEmailPassword(
        email: email,
        password: password,
        onSucc: (user) {
          Provider.of<ListenedValues>(context, listen: false).setLoading(false);

          Navigator.pushNamedAndRemoveUntil(
              context, HomeView.screenRouteName, (route) => false);
        },
        onFailed: (e) {
          Provider.of<ListenedValues>(context, listen: false).setLoading(false);
          FirebaseMessages.getMessageFromErrorCode(e);
        });
  }

  void goToSignup(BuildContext context) {
    Navigator.pushReplacementNamed(context, SignupView.screenRouteName);
  }
}
