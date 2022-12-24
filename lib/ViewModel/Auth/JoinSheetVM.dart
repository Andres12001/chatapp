// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/View/Auth/Screens/SignupView.dart';
import 'package:first_app/View/Auth/Screens/WelcomeView.dart';
import 'package:first_app/View/Home/Screens/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../Constants/FirebaseMessages.dart';
import '../../Helpers/FirebaseAuthMethods.dart';
import '../../Helpers/ListenedValues.dart';

class JoinSheetVM {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuthMethods _firebaseAuthMethods = FirebaseAuthMethods();

  void fieldUpdate(String value, TextEditingController controller) {
    // controller.text = value;
  }

  void loginPre({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    if (password.trim().isEmpty || email.trim().isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: "Please fill all fields",
      );
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
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Oops...',
            text: FirebaseMessages.getMessageFromErrorCode(e),
          );
        });
  }

  void goToSignup(BuildContext context) {
    Navigator.pushReplacementNamed(context, SignupView.screenRouteName);
  }
}
