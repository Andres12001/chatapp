import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Constants/FirebaseConst.dart';
import 'package:first_app/Helpers/FirebaseMethods.dart';
import 'package:first_app/Models/User.dart' as dbUser;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../Helpers/ListenedValues.dart';
import '../../Helpers/NavigationService.dart';
import '../../Models/Meeting.dart';
import '../../Models/MeetingHistory.dart';
import '../../View/Auth/Screens/WelcomeView.dart';

class AdminVM {
  final FirebaseMethods _firebaseMethods = FirebaseMethods();
  AdminVM() {
    if (myId == null ||
        !Provider.of<ListenedValues>(
                NavigationService.navigatorKey.currentContext!)
            .isAdmin ||
        (FirebaseAuth.instance.currentUser?.isAnonymous ?? true)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
            NavigationService.navigatorKey.currentContext!,
            WelcomeView.screenRouteName,
            (route) => false);
      });
    }
  }

  void getAllMeetings(BuildContext context) {
    if (myId == null) {
      return;
    }

    Provider.of<ListenedValues>(context, listen: false).setLoading(true);
    Provider.of<ListenedValues>(context, listen: false).clearAdminMeetingList();
    _firebaseMethods.getSingleDataFromFirebase(
        childPath: "/${FirebaseConst.MEETINGS}/",
        onSucc: ((snapshot) {
          late Map<String, dynamic> allMeetingMap;

          allMeetingMap = Map<String, dynamic>.from(snapshot.value as Map);
          if (allMeetingMap is! Map<String, dynamic>) {
            Provider.of<ListenedValues>(context, listen: false)
                .setLoading(false);
            return;
          }

          for (var value in allMeetingMap.values) {
            late Map<String, dynamic> meetingMap;
            print(value);
            meetingMap = Map<String, dynamic>.from(value as Map);
            if (meetingMap is! Map<String, dynamic>) {
              Provider.of<ListenedValues>(context, listen: false)
                  .setLoading(false);
              return;
            }

            var meeting = Meeting.transformMeeting(meetingMap);
            if (meeting is! Meeting) {
              Provider.of<ListenedValues>(context, listen: false)
                  .setLoading(false);
              return;
            }
            getAdmin(context, meeting);
          }
          Provider.of<ListenedValues>(context, listen: false).setLoading(false);
        }),
        onFailed: (error) {});
  }

  void getAdmin(BuildContext context, Meeting meeting) {
    _firebaseMethods.getSingleDataFromFirebase(
        childPath: "/${FirebaseConst.USERS}/${meeting.adminId}",
        onSucc: ((snapshot) {
          late Map<String, dynamic> userMap;

          userMap = Map<String, dynamic>.from(snapshot.value as Map);
          if (userMap is! Map<String, dynamic>) {
            Provider.of<ListenedValues>(context, listen: false)
                .setLoading(false);
            return;
          }

          var user = dbUser.User.transformUser(userMap);
          if (user is! dbUser.User) {
            Provider.of<ListenedValues>(context, listen: false)
                .setLoading(false);
            return;
          }

          Provider.of<ListenedValues>(context, listen: false)
              .updateAdminMeetingList(
                  MeetingHistory(meeting: meeting, user: user));
        }),
        onFailed: (error) {});
  }

  void getAllUsers(BuildContext context) {
    if (myId == null) {
      return;
    }

    Provider.of<ListenedValues>(context, listen: false).setLoading(true);
    Provider.of<ListenedValues>(context, listen: false).clearAdminUsersList();
    _firebaseMethods.getSingleDataFromFirebase(
        childPath: "/${FirebaseConst.USERS}/",
        onSucc: ((snapshot) {
          late Map<String, dynamic> allUsersMap;

          allUsersMap = Map<String, dynamic>.from(snapshot.value as Map);
          if (allUsersMap is! Map<String, dynamic>) {
            Provider.of<ListenedValues>(context, listen: false)
                .setLoading(false);
            return;
          }

          for (var value in allUsersMap.values) {
            late Map<String, dynamic> userMap;
            userMap = Map<String, dynamic>.from(value as Map);
            if (userMap is! Map<String, dynamic>) {
              Provider.of<ListenedValues>(context, listen: false)
                  .setLoading(false);
              return;
            }

            var user = dbUser.User.transformUser(userMap);
            if (user is! dbUser.User) {
              Provider.of<ListenedValues>(context, listen: false)
                  .setLoading(false);
              return;
            }
            Provider.of<ListenedValues>(context, listen: false)
                .updateAdminUsersList(user);
          }
          Provider.of<ListenedValues>(context, listen: false).setLoading(false);
        }),
        onFailed: (error) {});
  }

  String getCallStateString(int state) {
    String stateString = "";
    switch (MeetingStateTypes.values[state]) {
      case MeetingStateTypes.active:
        stateString = "active".tr();
        break;
      case MeetingStateTypes.ended:
        stateString = "ended".tr();
        break;
      case MeetingStateTypes.scheduld:
        stateString = "scheduled".tr();
        break;
    }
    return stateString;
  }

  void deleteUser(BuildContext context, String userId) {
    if (myId == userId) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'ops'.tr(),
        text: "cnt_delete_ur".tr(),
      );
      return;
    }
    _firebaseMethods.setValueInFirebase(
        childPath: "${FirebaseConst.USERS}/$userId",
        value: null,
        onSucc: () {
          Provider.of<ListenedValues>(context, listen: false)
              .deleteElementAdminUserList(userId);
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

  void deleteMeeting(BuildContext context, String meetingId) {
    _firebaseMethods.setValueInFirebase(
        childPath: "${FirebaseConst.MEETINGS}/$meetingId",
        value: null,
        onSucc: () {
          Provider.of<ListenedValues>(context, listen: false)
              .deleteElementAdminMeetingList(meetingId);
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

  void blockUser(BuildContext context, String userId, bool isBlocked) {
    if (myId == userId) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'ops'.tr(),
        text: "cnt_blck_ur".tr(),
      );
      return;
    }
    _firebaseMethods.setValueInFirebase(
        childPath: "${FirebaseConst.USERS}/$userId/${FirebaseConst.IS_BLCOKED}",
        value: !isBlocked,
        onSucc: () {
          Provider.of<ListenedValues>(context, listen: false)
              .updateBlockElementAdminUserList(userId, isBlocked);
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

  void makeUserAdmin(BuildContext context, String userId, bool isAdmin) {
    if (myId == userId) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'ops'.tr(),
        text: "cnt_rem_ur".tr(),
      );
      return;
    }
    _firebaseMethods.setValueInFirebase(
        childPath: "${FirebaseConst.USERS}/$userId/${FirebaseConst.IS_ADMIN}",
        value: !isAdmin,
        onSucc: () {
          Provider.of<ListenedValues>(context, listen: false)
              .updateAdminElementAdminUserList(userId, isAdmin);
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

  void endMeeting(BuildContext context, String meetingId) {
    _firebaseMethods.setValueInFirebase(
        childPath:
            "${FirebaseConst.MEETINGS}/$meetingId/${FirebaseConst.MEETING_STATE}",
        value: MeetingStateTypes.ended.index,
        onSucc: () {
          Provider.of<ListenedValues>(context, listen: false)
              .updateEndElementAdminUserList(meetingId);
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

  Color getCallStateColor(int state) {
    Color stateColor = kLabelColor;
    switch (MeetingStateTypes.values[state]) {
      case MeetingStateTypes.active:
        stateColor = kPrimaryColor;
        break;
      case MeetingStateTypes.ended:
        stateColor = Colors.red;
        break;
      case MeetingStateTypes.scheduld:
        stateColor = Colors.orange;
        break;
    }
    return stateColor;
  }
}
