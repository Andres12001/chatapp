// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Helpers/FirebaseMethods.dart';
import 'package:first_app/Models/Meeting.dart';
import 'package:first_app/View/Auth/Screens/SignupView.dart';
import 'package:first_app/View/Auth/Screens/WelcomeView.dart';
import 'package:first_app/View/Home/Screens/HomeView.dart';
import 'package:first_app/ViewModel/Meeting/MeetingVM.dart';
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

  void checkName() {
    // codeController.text = "4ddbab20-84f1-11ed-abe7-3555e7df4320";

    if (myId == null) {
      nameController.text = "guest".tr();
      return;
    }
    nameController.text =
        FirebaseAuth.instance.currentUser?.displayName ?? "guest".tr();
  }

  void joinPre({
    required String name,
    required String code,
    required String password,
    required BuildContext context,
  }) async {
    if (code.trim().isEmpty || name.trim().isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'ops'.tr(),
        text: "fill_all_fields".tr(),
      );
      return;
    }

    Provider.of<ListenedValues>(context, listen: false).setLoading(true);

    if (myId == null) {
      FirebaseAuthMethods authMethods = FirebaseAuthMethods();
      User? user = await authMethods.signInAnonymously(
          onSucc: (user) {},
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

      if (user == null) {
        Provider.of<ListenedValues>(context, listen: false).setLoading(false);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'ops'.tr(),
          text: "err_login".tr(),
        );
        return;
      }
    }

    if (FirebaseAuth.instance.currentUser!.isAnonymous) {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
    }

    MeetingVM.shared.joinRoom(
        context: context,
        userName: name,
        userId: myId!,
        enteredMeetingId: code,
        password: password);
  }

  void goToSignup(BuildContext context) {
    Navigator.pushReplacementNamed(context, SignupView.screenRouteName);
  }
}
