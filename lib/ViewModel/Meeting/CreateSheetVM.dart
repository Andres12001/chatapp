// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Helpers/FirebaseMethods.dart';
import 'package:first_app/Models/Meeting.dart';
import 'package:first_app/View/Auth/Screens/SignupView.dart';

import 'package:first_app/ViewModel/Meeting/MeetingVM.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../Helpers/FirebaseAuthMethods.dart';
import '../../Helpers/NavigationService.dart';
import '../../View/Auth/Screens/WelcomeView.dart';

class CreateSheetVM {
  TextEditingController titleController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  MeetingLocalTypes meetingType = MeetingLocalTypes.groupVoiceCall;
  FirebaseAuthMethods _firebaseAuthMethods = FirebaseAuthMethods();

  CreateSheetVM() {
    if (myId == null ||
        (FirebaseAuth.instance.currentUser?.isAnonymous ?? true)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
            NavigationService.navigatorKey.currentContext!,
            WelcomeView.screenRouteName,
            (route) => false);
      });
    }
  }

  void fieldUpdate(String value, TextEditingController controller) {
    // controller.text = value;
  }

  void createPre({
    required String title,
    required String password,
    required BuildContext context,
  }) async {
    if (myId == null) {
      return;
    }

    if (title.trim().isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'ops'.tr(),
        text: "fill_meeting_title".tr(),
      );
      return;
    }

    if (password.trim().isNotEmpty && password.trim().length < 6) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'ops'.tr(),
        text: "fill_pass_six".tr(),
      );
      return;
    }

    MeetingVM.shared.createMeeting(
        context: context,
        meetingTitle: title,
        password: password,
        isPrivate: password.isNotEmpty,
        started: true,
        meetingType: meetingType.index,
        meetingState: MeetingStateTypes.active.index);
  }

  void goToSignup(BuildContext context) {
    Navigator.pushReplacementNamed(context, SignupView.screenRouteName);
  }

  void updateMeetingTypeToggle(int index) {
    switch (index) {
      case 0:
        meetingType = MeetingLocalTypes.groupVoiceCall;
        break;
      case 1:
        meetingType = MeetingLocalTypes.groupVideoCall;
        break;
    }
  }
}
