import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Constants/FirebaseConst.dart';
import 'package:first_app/Dics/MeetingDic.dart';
import 'package:first_app/Helpers/FirebaseMethods.dart';
import 'package:first_app/Models/Meeting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';
import '../../Helpers/ListenedValues.dart';
import '../../PreBuilt/zego_uikit_prebuilt_call.dart';
import 'package:universal_html/html.dart' as uni;
import 'package:first_app/View/Meeting/MeetingView.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MeetingVM {
  static final shared = MeetingVM();
  var uuid = const Uuid();
  final FirebaseMethods _firebaseMethods = FirebaseMethods();
  String meetingId = '';
  ZegoUIKitPrebuiltCallConfig meetingType =
      ZegoUIKitPrebuiltCallConfig.groupVoiceCall();

  void createMeeting(
      {required BuildContext context,
      required String? meetingTitle,
      required String password,
      required bool isPrivate,
      required bool started,
      required int meetingType,
      required int meetingState}) {
    if (myId == null) {
      return;
    }
    Provider.of<ListenedValues>(context, listen: false).setLoading(true);

    _firebaseMethods.getSingleDataFromFirebase(
        childPath: "${FirebaseConst.USERS}/$myId/${FirebaseConst.IN_MEETING}",
        onSucc: (snapshot) {
          late String inRoom;

          if (snapshot.value is! String) {
            inRoom = "";
          } else {
            inRoom = snapshot.value as String;
          }

          if (inRoom.isEmpty) {
            final generatedMeetingId = uuid.v1().toString();

            Map<String, dynamic> map = {
              "${FirebaseConst.MEETINGS}/$generatedMeetingId":
                  MeetingDic.createMeetingMap(
                      meetingTitle,
                      password,
                      myId!,
                      generatedMeetingId,
                      isPrivate,
                      started,
                      meetingType,
                      meetingState),
              "${FirebaseConst.USERS}/$myId/${FirebaseConst.IN_MEETING}":
                  generatedMeetingId
            };

            _firebaseMethods.setDataInFirebase(
                childPath: "/",
                map: map,
                onSucc: () {
                  this.meetingId = generatedMeetingId;
                  this.meetingType = Meeting.getMeetingType(meetingType);
                  Provider.of<ListenedValues>(context, listen: false)
                      .setLoading(false);
                  kIsWeb
                      ? uni.window.navigator //for web only
                          .getUserMedia(audio: true, video: true)
                          .then((value) {
                          Navigator.pushNamed(
                              context, MeetingView.screenRouteName);
                        })
                      : Navigator.pushNamed(context,
                          MeetingView.screenRouteName); //for Android and iOS
                },
                onFailed: (e) {
                  Provider.of<ListenedValues>(context, listen: false)
                      .setLoading(false);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Oops...',
                    text: e,
                  );
                });
          } else {
            Provider.of<ListenedValues>(context, listen: false)
                .setLoading(false);
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Oops...',
                text:
                    "You are already in meeting you can't create meeting until you leave the other meeting.",
                confirmBtnColor: kPrimaryColor,
                confirmBtnText: "Leave Meeting",
                onConfirmBtnTap: () {
                  Provider.of<ListenedValues>(context, listen: false)
                      .setLoading(true);
                  _firebaseMethods.setValueInFirebase(
                      childPath:
                          "${FirebaseConst.USERS}/$myId/${FirebaseConst.IN_MEETING}",
                      value: "",
                      onSucc: () {
                        Navigator.pop(context);
                        createMeeting(
                            context: context,
                            meetingTitle: meetingTitle,
                            password: password,
                            isPrivate: isPrivate,
                            started: started,
                            meetingType: meetingType,
                            meetingState: meetingState);
                      },
                      onFailed: (e) {
                        Navigator.pop(context);
                        Provider.of<ListenedValues>(context, listen: false)
                            .setLoading(false);
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Oops...',
                          text: e,
                        );
                      });
                });
          }
        },
        onFailed: (e) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Oops...',
            text: e,
          );
        });
  }
}
