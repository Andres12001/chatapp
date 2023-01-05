import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Constants/FirebaseConst.dart';
import 'package:first_app/Constants/MainConstants.dart';
import 'package:first_app/Dics/MeetingDic.dart';
import 'package:first_app/Helpers/FirebaseMethods.dart';
import 'package:first_app/Models/Meeting.dart';
import 'package:first_app/View/Home/Screens/HomeView.dart';
import 'package:first_app/ViewModel/Home/HistoryVM.dart';
import 'package:first_app/ViewModel/MainVM.dart';
import 'package:flutter/material.dart';
import 'package:locally/locally.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../Helpers/ListenedValues.dart';
import '../../Helpers/NavigationService.dart';
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
                      meetingState,
                      Provider.of<ListenedValues>(context, listen: false)
                          .scheduleDateTime
                          ?.millisecondsSinceEpoch),
              "${FirebaseConst.HISTORY}/$myId/$generatedMeetingId/${FirebaseConst.TIME_CHILD}":
                  ServerValue.timestamp
            };

            if (started) {
              map["${FirebaseConst.USERS}/$myId/${FirebaseConst.IN_MEETING}"] =
                  generatedMeetingId;
            }
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

                  if (!started) {
                    if (!kIsWeb) {
                      Locally locally = Locally(
                        context: context,
                        payload: generatedMeetingId,
                        pageRoute: MaterialPageRoute(builder: (context) {
                          Provider.of<ListenedValues>(context, listen: false)
                              .setHomeIndex(2);
                          return HomeView();
                        }),
                        appIcon: 'mipmap/ic_launcher',
                      );
                      locally.schedule(
                          title: meetingTitle,
                          message: "schd_meet_start".tr(),
                          duration: Provider.of<ListenedValues>(context,
                                  listen: false)
                              .scheduleDateTime!
                              .difference(DateTime.now()));
                    }
                    Provider.of<ListenedValues>(context, listen: false)
                        .updateScheduleDateTime(null);
                  }

                  Provider.of<ListenedValues>(context, listen: false)
                      .setLoading(false);

                  if (kIsWeb) {
                    if (started) {
                      uni.window.navigator //for web only
                          .getUserMedia(audio: true, video: true)
                          .then((value) {
                        Navigator.pushNamed(
                            context, MeetingView.screenRouteName);
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  } else {
                    Navigator.pop(context);
                    if (started) {
                      Navigator.pushNamed(context, MeetingView.screenRouteName);
                    } //for Android and iOS
                  }
                },
                onFailed: (e) {
                  Provider.of<ListenedValues>(context, listen: false)
                      .setLoading(false);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'ops'.tr(),
                    text: e,
                  );
                });
          } else {
            Provider.of<ListenedValues>(context, listen: false)
                .setLoading(false);
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'ops'.tr(),
                text: "already_meeting_leave".tr(),
                confirmBtnColor: kPrimaryColor,
                confirmBtnText: "lv_meet".tr(),
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
                          title: 'ops'.tr(),
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
            title: 'ops'.tr(),
            text: "${e}",
          );
        });
  }

//i will start here
  void joinRoom(
      {required BuildContext context,
      required String userName,
      required String userId,
      required String enteredMeetingId,
      required String password,
      bool scheduleStart = false}) {
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
                      title: 'ops'.tr(),
                      text: "cnt_rech_meet".tr(),
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
                      title: 'ops'.tr(),
                      text: "cnt_rech_meet".tr(),
                    );
                    return;
                  }

                  if (meeting.isPrivate && (meeting.password != password)) {
                    Provider.of<ListenedValues>(context, listen: false)
                        .setLoading(false);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'ops'.tr(),
                      text: "meet_pass_inco".tr(),
                    );
                    return;
                  }

                  if (meeting.meetingState != MeetingStateTypes.active.index &&
                      !scheduleStart) {
                    Provider.of<ListenedValues>(context, listen: false)
                        .setLoading(false);
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'ops'.tr(),
                        text: (meeting.meetingState ==
                                MeetingStateTypes.ended.index)
                            ? "meet_ending".tr()
                            : "meet_not_started".tr());
                    return;
                  }

                  Map<String, dynamic> map = {
                    "${FirebaseConst.USERS}/$myId/${FirebaseConst.IN_MEETING}":
                        enteredMeetingId,
                    "${FirebaseConst.HISTORY}/$myId/$enteredMeetingId/${FirebaseConst.TIME_CHILD}":
                        ServerValue.timestamp
                  };

                  if (scheduleStart) {
                    map["${FirebaseConst.MEETINGS}/$enteredMeetingId/${FirebaseConst.MEETING_STARTED}"] =
                        true;
                    map["${FirebaseConst.MEETINGS}/$enteredMeetingId/${FirebaseConst.MEETING_STATE}"] =
                        MeetingStateTypes.active.index;
                  }
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
                        if (kIsWeb) {
                          uni.window.navigator //for web only
                              .getUserMedia(audio: true, video: true)
                              .then((value) {
                            Navigator.pushNamed(
                                context, MeetingView.screenRouteName);
                          });
                        } else {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context,
                              MeetingView
                                  .screenRouteName); //for Android and iOS
                        }
                      },
                      onFailed: (e) {
                        Provider.of<ListenedValues>(context, listen: false)
                            .setLoading(false);
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'ops'.tr(),
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
                    title: 'ops'.tr(),
                    text: "cnt_rech_meet".tr(),
                  );
                });
          } else {
            Provider.of<ListenedValues>(context, listen: false)
                .setLoading(false);
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'ops'.tr(),
                text: "already_meeting_leave".tr(),
                confirmBtnColor: kPrimaryColor,
                confirmBtnText: "lv_meet".tr(),
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
                          title: 'ops'.tr(),
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
            title: 'ops'.tr(),
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
          //  Navigator.pop(context);
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
      Provider.of<ListenedValues>(
              NavigationService.navigatorKey.currentContext!,
              listen: false)
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
            title: 'ops'.tr(),
            text: e,
          );
        });
  }
}
