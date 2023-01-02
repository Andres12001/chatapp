// ignore_for_file: use_build_context_synchronously

import 'package:first_app/Helpers/FirebaseMethods.dart';
import 'package:first_app/Models/Meeting.dart';
import 'package:first_app/View/Auth/Screens/SignupView.dart';

import 'package:first_app/ViewModel/Meeting/MeetingVM.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../Constants/Constants.dart';
import '../../Helpers/FirebaseAuthMethods.dart';
import '../../Helpers/ListenedValues.dart';

class ScheduleSheetVM {
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

    if (Provider.of<ListenedValues>(context, listen: false).scheduleDateTime ==
        null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: "Please choose schedule date and time",
      );
      return;
    }
    MeetingVM.shared.createMeeting(
        context: context,
        meetingTitle: title,
        password: password,
        isPrivate: password.isNotEmpty,
        started: false,
        meetingType: meetingType.index,
        meetingState: MeetingStateTypes.scheduld.index);
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

  String formateDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy hh:mm a');
    final String formatted = formatter.format(date);
    return formatted;
  }

  void chooseDateAndTime(BuildContext context) async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      type: OmniDateTimePickerType.dateAndTime,
      primaryColor: kPrimaryColor,
      backgroundColor: Colors.grey[900],
      calendarTextColor: Colors.white,
      tabTextColor: Colors.white,
      unselectedTabBackgroundColor: Colors.grey[700],
      buttonTextColor: Colors.white,
      timeSpinnerTextStyle:
          const TextStyle(color: Colors.white70, fontSize: 18),
      timeSpinnerHighlightedTextStyle:
          const TextStyle(color: Colors.white, fontSize: 24),
      is24HourMode: false,
      isShowSeconds: false,
      startInitialDate: DateTime.now(),
      startFirstDate: DateTime.now(),
      startLastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      borderRadius: const Radius.circular(16),
    );
    Provider.of<ListenedValues>(context, listen: false)
        .updateScheduleDateTime(dateTime);
  }
}
