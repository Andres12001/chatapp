// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Helpers/FirebaseMethods.dart';
import 'package:first_app/Helpers/NavigationService.dart';
import 'package:first_app/View/Auth/Screens/SignupView.dart';
import 'package:first_app/View/Auth/Screens/WelcomeView.dart';
import 'package:first_app/View/Home/Screens/HomeView.dart';
import 'package:first_app/ViewModel/MainVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../Constants/FirebaseConst.dart';
import '../../Constants/FirebaseMessages.dart';
import '../../Helpers/FirebaseAuthMethods.dart';
import '../../Helpers/ListenedValues.dart';

class LoginVM {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuthMethods _firebaseAuthMethods = FirebaseAuthMethods();
  FirebaseMethods _firebaseMethods = FirebaseMethods();
  void fieldUpdate(String value, TextEditingController controller) {
    // controller.text = value;
  }
  LoginVM() {
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

  void loginPre({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    if (password.trim().isEmpty || email.trim().isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'ops'.tr(),
        text: "fill_all_fields".tr(),
      );
      return;
    }
    Provider.of<ListenedValues>(context, listen: false).setLoading(true);
    _firebaseAuthMethods.loginUsingEmailPassword(
        email: email,
        password: password,
        onSucc: (user) {
          _firebaseMethods.getSingleDataFromFirebase(
              childPath:
                  "${FirebaseConst.USERS}/${user!.uid}/${FirebaseConst.IS_BLCOKED}",
              onSucc: (snapshot) {
                late bool isBlocked;

                if (snapshot.value is! bool) {
                  isBlocked = true;
                } else {
                  isBlocked = snapshot.value as bool;
                }

                if (isBlocked) {
                  Provider.of<ListenedValues>(context, listen: false)
                      .setLoading(false);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'ops'.tr(),
                    text: "acc_blocked".tr(),
                  );
                } else {
                  MainVM.shared.performBlockDeleteUser(context);
                  MainVM.shared.performAdmineUser(context);
                  Provider.of<ListenedValues>(context, listen: false)
                      .setLoading(false);

                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeView.screenRouteName, (route) => false);
                }
              },
              onFailed: (e) {
                Provider.of<ListenedValues>(context, listen: false)
                    .setLoading(false);
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: 'ops'.tr(),
                  text: FirebaseMessages.getMessageFromErrorCode(e),
                );
              });
        },
        onFailed: (e) {
          Provider.of<ListenedValues>(context, listen: false).setLoading(false);
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'ops'.tr(),
            text: FirebaseMessages.getMessageFromErrorCode(e),
          );
        });
  }

  void goToSignup(BuildContext context) {
    Navigator.pushReplacementNamed(context, SignupView.screenRouteName);
  }
}
