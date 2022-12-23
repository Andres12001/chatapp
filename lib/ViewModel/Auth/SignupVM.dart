// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Dics/UserDic.dart';
import 'package:first_app/Helpers/Extensions.dart';
import 'package:first_app/View/Auth/Screens/LoginView.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:provider/provider.dart';

import '../../Constants/FirebaseConst.dart';
import '../../Constants/FirebaseMessages.dart';
import '../../Helpers/FirebaseAuthMethods.dart';
import '../../Helpers/FirebaseMethods.dart';
import '../../Helpers/ListenedValues.dart';
import '../../View/Home/Screens/HomeView.dart';

class SignupVM {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameFController = TextEditingController();
  TextEditingController nameLController = TextEditingController();

  var imageFinal;
  final FirebaseAuthMethods _firebaseAuthMethods = FirebaseAuthMethods();
  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  void fieldUpdate(String value, TextEditingController controller,
      Function(String) updateUI) {
    // controller.text = value;
    updateUI(value);
  }

  void signUpPre(
      {required String email,
      required String password,
      required BuildContext context,
      required String nameF,
      required String nameL}) {
    if (nameF.trim().isEmpty || nameL.trim().isEmpty || email.trim().isEmpty) {
      print("Please fill all fields");
      return;
    }
    if (password.trim().length > 6) {
      print("Please enter password contains at least 6 char");
      return;
    }
    Provider.of<ListenedValues>(context, listen: false).setLoading(true);
    nameF = nameF.toCapitalized();
    nameL = nameL.toCapitalized();
    _firebaseAuthMethods.signupUsingEmailPassword(
        email: email,
        password: password,
        onSucc: (user) {
          uploadAva(context, email, user!.uid, true, nameF, nameL);
        },
        onFailed: (e) {
          Provider.of<ListenedValues>(context, listen: false).setLoading(false);
          print(e);
        });
  }

  void uploadAva(BuildContext context, String loginInfo, String id, bool ios,
      String nameF, String nameL) {
    if (imageFinal != null) {
      _firebaseMethods.uploadPhotoStorage(
          childPath: FirebaseConst.AVA,
          file: imageFinal,
          onSucc: (url) {
            regUserDb(context, loginInfo, id, ios, nameF, nameL, url);
          },
          onFailed: (e) {
            Provider.of<ListenedValues>(context, listen: false)
                .setLoading(false);
          });
    } else {
      regUserDb(context, loginInfo, id, ios, nameF, nameL, null);
    }
  }

  void regUserDb(BuildContext context, String loginInfo, String id, bool ios,
      String nameF, String nameL, String? ava) async {
    await FirebaseAuth.instance.currentUser?.updateDisplayName("$nameF $nameL");
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(ava ?? "");
    print(id);
    _firebaseMethods.setDataInFirebase(
        childPath: "${FirebaseConst.USERS}/$id",
        map: UserDic.createUserMap(loginInfo, id, ios, nameF, nameL, ava),
        onSucc: () {
          Provider.of<ListenedValues>(context, listen: false).setLoading(false);

          Navigator.pushNamedAndRemoveUntil(
              context, HomeView.screenRouteName, (route) => false);
        },
        onFailed: (e) {
          Provider.of<ListenedValues>(context, listen: false).setLoading(false);
          FirebaseMessages.getMessageFromErrorCode(e);
        });
  }

  void goToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginView.screenRouteName);
  }
}
