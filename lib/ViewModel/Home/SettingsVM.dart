import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Helpers/NavigationService.dart';
import 'package:provider/provider.dart';
import '../../Constants/FirebaseConst.dart';
import '../../Constants/FirebaseMessages.dart';
import '../../Helpers/FirebaseMethods.dart';
import 'package:flutter/material.dart';
import 'package:first_app/Models/User.dart' as dbUser;
import '../../Helpers/ListenedValues.dart';
import '../../View/Auth/Screens/WelcomeView.dart';

class SettingsVM {
  FirebaseMethods _firebaseMethods = FirebaseMethods();
  var imageFinal;

  void signout(BuildContext context) {
    FirebaseMethods.onlineControl(false);
    FirebaseMethods.goOfflineDisconnect();
    FirebaseAuth.instance.signOut();
  }

  SettingsVM() {
    // if (myId == null ||
    //     (FirebaseAuth.instance.currentUser?.isAnonymous ?? true)) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Navigator.pushNamedAndRemoveUntil(
    //         NavigationService.navigatorKey.currentContext!,
    //         WelcomeView.screenRouteName,
    //         (route) => false);
    //   });
    //   return;
    // }
    getmyUser(NavigationService.navigatorKey.currentContext!);
  }
  void getmyUser(BuildContext context) {
    if (myId == null ||
        Provider.of<ListenedValues>(context, listen: false).myUser != null) {
      return;
    }

    Provider.of<ListenedValues>(context, listen: false).setLoading(true);
    _firebaseMethods.getSingleDataFromFirebase(
        childPath: "/${FirebaseConst.USERS}/$myId",
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
          Provider.of<ListenedValues>(context, listen: false).setLoading(false);
          Provider.of<ListenedValues>(context, listen: false)
              .updateMyUser(user);
        }),
        onFailed: (error) {});
  }

  void uploadAva(BuildContext context) {
    Provider.of<ListenedValues>(context, listen: false).setLoading(true);

    _firebaseMethods.uploadPhotoStorage(
        childPath: FirebaseConst.AVA,
        file: imageFinal,
        onSucc: (url) {
          regUserDb(context, url);
        },
        onFailed: (e) {
          Provider.of<ListenedValues>(context, listen: false).setLoading(false);
        });
  }

  void regUserDb(BuildContext context, String ava) async {
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(ava);
    _firebaseMethods.setValueInFirebase(
        childPath: "${FirebaseConst.USERS}/$myId/${FirebaseConst.AVA_DB}",
        value: ava,
        onSucc: () {
          Provider.of<ListenedValues>(context, listen: false).setLoading(false);
        },
        onFailed: (e) {
          Provider.of<ListenedValues>(context, listen: false).setLoading(false);
          FirebaseMessages.getMessageFromErrorCode(e);
        });
  }
}
