import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Helpers/FirebaseMethods.dart';
import 'package:first_app/ViewModel/Meeting/MeetingVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../Constants/FirebaseConst.dart';
import '../../Constants/MainConstants.dart';
import '../../PreBuilt/zego_uikit_prebuilt_call.dart';

class MeetingView extends StatelessWidget {
  const MeetingView({Key? key}) : super(key: key);
  static const String screenRouteName = "/Meeting";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ZegoUIKitPrebuiltCall(
        appID: MainConstants
            .appID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign: kIsWeb
            ? MainConstants.ServerSecret
            : MainConstants
                .appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: myId ?? "",
        tokenServerUrl: kIsWeb ? MainConstants.tokenServerUrl : "",
        userName: FirebaseAuth.instance.currentUser?.displayName ?? "Guest",
        callID: MeetingVM.shared.meetingId,
        // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
        config: MeetingVM.shared.meetingType
          ..onOnlySelfInRoom = (context) {
            MeetingVM.shared.leaveMeeting(
                endRoom: true,
                context: context,
                onComp: () {
                  Navigator.of(context).pop();
                });
          },
        onDispose: (endRoom) {
          MeetingVM.shared
              .leaveMeeting(endRoom: endRoom, context: context, onComp: () {});
        },
        meetingVM: MeetingVM.shared, adminID: MeetingVM.shared.adminId,
        meetingTitle: MeetingVM.shared.meetingTitle,
      ),
    );
  }
}
