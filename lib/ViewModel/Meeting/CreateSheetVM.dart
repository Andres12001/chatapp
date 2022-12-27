// ignore_for_file: use_build_context_synchronously

import 'package:first_app/Helpers/FirebaseMethods.dart';
import 'package:first_app/Models/Meeting.dart';
import 'package:first_app/View/Auth/Screens/SignupView.dart';

import 'package:first_app/ViewModel/Meeting/MeetingVM.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../Helpers/FirebaseAuthMethods.dart';

class CreateSheetVM {
  TextEditingController titleController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  MeetingLocalTypes meetingType = MeetingLocalTypes.groupVoiceCall;
  FirebaseAuthMethods _firebaseAuthMethods = FirebaseAuthMethods();

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
        title: 'Oops...',
        text: "Please fill meeting title field",
      );
      return;
    }

    if (password.trim().isNotEmpty && password.trim().length < 6) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: "Please enter password contains at least 6 char",
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
