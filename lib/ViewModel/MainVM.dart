import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:provider/provider.dart';

import '../Constants/FirebaseConst.dart';
import '../Helpers/FirebaseMethods.dart';
import '../Helpers/ListenedValues.dart';
import '../Helpers/NavigationService.dart';
import '../Models/Meeting.dart';
import '../Models/MeetingHistory.dart';
import '../View/Auth/Screens/WelcomeView.dart';
import 'package:first_app/Models/User.dart' as dbUser;

class MainVM {
  static final shared = MainVM();

  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  void authStream(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      myId = user?.uid;
      if (user == null) {
        print("user signout");
        performSignout(
            NavigationService.navigatorKey.currentContext ?? context);
      } else {
        print("user signin");
        FirebaseMethods.onlineControl(true);
      }
    });
  }

  void performBlockDeleteUser(BuildContext context) {
    if (myId == null) {
      return;
    }
    _firebaseMethods.getListnerOnData(
        childPath:
            "${FirebaseConst.USERS}/${myId!}/${FirebaseConst.IS_BLCOKED}",
        onSucc: (snapshot) {
          late bool isBlocked;

          if (snapshot.value is! bool) {
            isBlocked = true;
          } else {
            isBlocked = snapshot.value as bool;
          }

          if (isBlocked) {
            performSignout(
                NavigationService.navigatorKey.currentContext ?? context);
          }

          print("Blockkkked : $isBlocked");
        },
        listnerMapkey: FirebaseConst.LISTNER_BlOCK_DELETE,
        onFailed: (onFailed) {});
  }

  void performSignout(BuildContext context) {
    FirebaseMethods.listnersMap[FirebaseConst.LISTNER_BlOCK_DELETE]?.cancel();
    Navigator.pushNamedAndRemoveUntil(
        context, WelcomeView.screenRouteName, (route) => false);
    Provider.of<ListenedValues>(context, listen: false).setHomeIndex(0);
  }

  void performStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        FirebaseMethods.onlineControl(true);
        break;
      case AppLifecycleState.inactive:
        FirebaseMethods.onlineControl(false);
        FirebaseMethods.goOfflineDisconnect();
        break;
      case AppLifecycleState.paused:
        FirebaseMethods.onlineControl(false);
        FirebaseMethods.goOfflineDisconnect();
        break;
      case AppLifecycleState.detached:
        FirebaseMethods.onlineControl(false);
        FirebaseMethods.goOfflineDisconnect();
        break;
      default:
        break;
    }
  }

  void performEventChange(FGBGType event) {
    switch (event) {
      case FGBGType.foreground:
        FirebaseMethods.onlineControl(true);
        break;
      case FGBGType.background:
        FirebaseMethods.onlineControl(false);
        FirebaseMethods.goOfflineDisconnect();

        break;
      default:
    }
  }

  void getRecentMeeting(BuildContext context, String meetingKey) {
    _firebaseMethods.getSingleDataFromFirebase(
        childPath: "/${FirebaseConst.MEETINGS}/$meetingKey",
        onSucc: ((snapshot) {
          late Map<String, dynamic> meetingMap;

          meetingMap = Map<String, dynamic>.from(snapshot.value as Map);
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

          _getAdmin(context, meeting);
        }),
        onFailed: (error) {});
  }

  void _getAdmin(BuildContext context, Meeting meeting) {
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
              .setRecentMeeting(MeetingHistory(meeting: meeting, user: user));
        }),
        onFailed: (error) {});
  }
}
