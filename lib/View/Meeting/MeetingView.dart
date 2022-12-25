import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Constants/ZegoConstants.dart';
import 'package:first_app/Helpers/FirebaseMethods.dart';
import 'package:first_app/ViewModel/Meeting/MeetingVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../PreBuilt/zego_uikit_prebuilt_call.dart';

class MeetingView extends StatelessWidget {
  const MeetingView(
      {Key? key, required this.meetingId, required this.meetingType})
      : super(key: key);
  static const String screenRouteName = "/Meeting";
  final String meetingId;
  final ZegoUIKitPrebuiltCallConfig meetingType;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ZegoUIKitPrebuiltCall(
        appID: ZegoConstants
            .appID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign: kIsWeb
            ? ZegoConstants.ServerSecret
            : ZegoConstants
                .appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: myId ?? "",
        tokenServerUrl: kIsWeb ? ZegoConstants.tokenServerUrl : "",
        userName: FirebaseAuth.instance.currentUser?.displayName ?? "Guest",
        callID: meetingId,
        // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
        config: meetingType
          ..avatarBuilder = (context, size, user, extraInfo) {
            return Image.asset("images/welcome.png");
          }
          ..onOnlySelfInRoom = (context) {
            //firebase compelete room
            //remove from user > roomid for all users
            //make it as ended
            Navigator.of(context).pop();
          },
        meetingVM: MeetingVM.shared,
      ),
    );
  }
}
