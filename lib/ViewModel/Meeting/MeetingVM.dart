import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Constants/FirebaseConst.dart';
import 'package:first_app/Constants/MainConstants.dart';
import 'package:first_app/Dics/MeetingDic.dart';
import 'package:first_app/Helpers/FirebaseMethods.dart';
import 'package:first_app/Models/Meeting.dart';
import 'package:first_app/ViewModel/MainVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../Helpers/ListenedValues.dart';
import '../../PreBuilt/zego_uikit_prebuilt_call.dart';
import 'package:universal_html/html.dart' as uni;
import 'package:first_app/View/Meeting/MeetingView.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MeetingVM {
  static final shared = MeetingVM();
  // var uuid = const Uuid();
  final FirebaseMethods _firebaseMethods = FirebaseMethods();
  String meetingId = '';
  String adminId = '';
  String meetingTitle = '';
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
            //  final generatedMeetingId = uuid.v1().toString();
            final generatedMeetingId =
                "${MainConstants.meetingPrefix}-${DateTime.now().millisecondsSinceEpoch}";
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
                  generatedMeetingId,
              "${FirebaseConst.HISTORY}/$myId/$generatedMeetingId/${FirebaseConst.TIME_CHILD}":
                  ServerValue.timestamp
            };

            _firebaseMethods.setDataInFirebase(
                childPath: "/",
                map: map,
                onSucc: () {
                  this.meetingId = generatedMeetingId;
                  this.adminId = myId!;
                  this.meetingTitle = meetingTitle ?? "";
                  this.meetingType = Meeting.getMeetingType(meetingType);
                  MainVM.shared.getRecentMeeting(context, generatedMeetingId);
                  //  Navigator.pop(context);

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

//i will start here
  void joinRoom({
    required BuildContext context,
    required String userName,
    required String userId,
    required String enteredMeetingId,
    required String password,
  }) {
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

          if (inRoom.isEmpty || inRoom == enteredMeetingId) {
            _firebaseMethods.getSingleDataFromFirebase(
                childPath: "${FirebaseConst.MEETINGS}/$enteredMeetingId",
                onSucc: (snapshot) {
                  late Map<String, dynamic> meetingMap;

                  meetingMap = Map<String, dynamic>.from(snapshot.value as Map);
                  if (meetingMap is! Map<String, dynamic>) {
                    Provider.of<ListenedValues>(context, listen: false)
                        .setLoading(false);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: "Can't reach the meeting.",
                    );
                    return;
                  }

                  var meeting = Meeting.transformMeeting(meetingMap);
                  if (meeting is! Meeting) {
                    Provider.of<ListenedValues>(context, listen: false)
                        .setLoading(false);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: "Can't reach the meeting.",
                    );
                    return;
                  }

                  if (meeting.isPrivate && (meeting.password != password)) {
                    Provider.of<ListenedValues>(context, listen: false)
                        .setLoading(false);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: "Meeting password is incorrect",
                    );
                    return;
                  }

                  if (meeting.meetingState != MeetingStateTypes.active.index) {
                    Provider.of<ListenedValues>(context, listen: false)
                        .setLoading(false);
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Oops...',
                        text: (meeting.meetingState ==
                                MeetingStateTypes.ended.index)
                            ? "Meeting has been ended"
                            : "Meeting didn't start yet");
                    return;
                  }

                  Map<String, dynamic> map = {
                    "${FirebaseConst.USERS}/$myId/${FirebaseConst.IN_MEETING}":
                        enteredMeetingId,
                    "${FirebaseConst.HISTORY}/$myId/$enteredMeetingId/${FirebaseConst.TIME_CHILD}":
                        ServerValue.timestamp
                  };

                  _firebaseMethods.setDataInFirebase(
                      childPath: "/",
                      map: map,
                      onSucc: () {
                        this.meetingId = meeting.meetingId;
                        this.adminId = meeting.adminId;
                        this.meetingTitle = meeting.meetingTitle;
                        this.meetingType =
                            Meeting.getMeetingType(meeting.meetingType);
                        MainVM.shared
                            .getRecentMeeting(context, meeting.meetingId);
                        Provider.of<ListenedValues>(context, listen: false)
                            .setLoading(false);
                        // Navigator.pop(context);
                        kIsWeb
                            ? uni.window.navigator //for web only
                                .getUserMedia(audio: true, video: true)
                                .then((value) {
                                Navigator.pushNamed(
                                    context, MeetingView.screenRouteName);
                              })
                            : Navigator.pushNamed(
                                context,
                                MeetingView
                                    .screenRouteName); //for Android and iOS
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
                },
                onFailed: (onFailed) {
                  Provider.of<ListenedValues>(context, listen: false)
                      .setLoading(false);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Oops...',
                    text: "Can't reach the meeting.",
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
                        joinRoom(
                            context: context,
                            userName: userName,
                            userId: userId,
                            enteredMeetingId: enteredMeetingId,
                            password: password);
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

  void afterJoinMeeting(BuildContext context) {
    if (myId == null) {
      return;
    }
    FirebaseMethods firebaseMethods = FirebaseMethods();

    firebaseMethods.getListnerOnData(
      childPath:
          "/${FirebaseConst.MEETINGS}/${this.meetingId}/${FirebaseConst.MEETING_STATE}",
      listnerMapkey: FirebaseConst.LISTNER_MEETING_END,
      onSucc: (snapshot) {
        late MeetingStateTypes meetingState;

        if (snapshot.value is! int) {
          meetingState = MeetingStateTypes.ended;
        } else {
          meetingState = MeetingStateTypes.values[snapshot.value as int];
        }
        if (meetingState == MeetingStateTypes.ended) {
          Navigator.pop(context);
        }
      },
      onFailed: (error) {},
    );
  }

  void leaveMeeting(
      {required bool endRoom,
      required BuildContext context,
      required Function onComp}) {
    if (myId == null) {
      return;
    }
    Map<String, dynamic> map = {
      "${FirebaseConst.USERS}/$myId/${FirebaseConst.IN_MEETING}": ""
    };

    if (endRoom) {
      map["${FirebaseConst.MEETINGS}/$meetingId/${FirebaseConst.MEETING_STATE}"] =
          MeetingStateTypes.ended.index;
      Provider.of<ListenedValues>(context, listen: false)
          .updateRecentMeetingState(MeetingStateTypes.ended.index);
    }

    _firebaseMethods.setDataInFirebase(
        childPath: "/",
        map: map,
        onSucc: () {
          this.meetingId = "";
          this.adminId = "";
          this.meetingTitle = "";
          FirebaseMethods.listnersMap[FirebaseConst.LISTNER_MEETING_END]
              ?.cancel();

          onComp();
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
