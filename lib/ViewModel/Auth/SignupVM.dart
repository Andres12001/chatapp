// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Dics/UserDic.dart';
import 'package:first_app/Helpers/Extensions.dart';
import 'package:first_app/View/Auth/Screens/LoginView.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../Constants/FirebaseConst.dart';
import '../../Constants/FirebaseMessages.dart';
import '../../Helpers/FirebaseAuthMethods.dart';
import '../../Helpers/FirebaseMethods.dart';
import '../../Helpers/ListenedValues.dart';
import '../../Helpers/NavigationService.dart';
import '../../View/Home/Screens/HomeView.dart';
import '../MainVM.dart';

class SignupVM {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameFController = TextEditingController();
  TextEditingController nameLController = TextEditingController();

  var imageFinal;
  final FirebaseAuthMethods _firebaseAuthMethods = FirebaseAuthMethods();
  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  SignupVM() {
    if (myId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
            NavigationService.navigatorKey.currentContext!,
            HomeView.screenRouteName,
            (route) => false);
      });
    }
  }

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
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'ops'.tr(),
        text: "fill_all_fields".tr(),
      );
      return;
    }
    if (password.trim().length > 6) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'ops'.tr(),
        text: "fill_pass_six".tr(),
      );
      return;
    }
    Provider.of<ListenedValues>(context, listen: false).setLoading(true);
    nameF = nameF.toCapitalized();
    nameL = nameL.toCapitalized();
    _firebaseAuthMethods.signupUsingEmailPassword(
        email: email,
        password: password,
        onSucc: (user) {
          uploadAva(context, email, user!.uid, false, nameF, nameL, "email");
        },
        onFailed: (e) {
          Provider.of<ListenedValues>(context, listen: false).setLoading(false);
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'ops'.tr(),
            text: FirebaseMessages.getMessageFromErrorCode(e),
          );
        });
  }

  void uploadAva(BuildContext context, String loginInfo, String id, bool ios,
      String nameF, String nameL, String loginType) {
    if (imageFinal != null) {
      _firebaseMethods.uploadPhotoStorage(
          childPath: FirebaseConst.AVA,
          file: imageFinal,
          onSucc: (url) {
            regUserDb(
                context, loginInfo, id, ios, nameF, nameL, url, loginType);
          },
          onFailed: (e) {
            Provider.of<ListenedValues>(context, listen: false)
                .setLoading(false);
          });
    } else {
      regUserDb(context, loginInfo, id, ios, nameF, nameL, null, loginType);
    }
  }

  void regUserDb(BuildContext context, String loginInfo, String id, bool ios,
      String nameF, String nameL, String? ava, String loginType) async {
    await FirebaseAuth.instance.currentUser?.updateDisplayName("$nameF $nameL");
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(ava ?? "");
    _firebaseMethods.setDataInFirebase(
        childPath: "${FirebaseConst.USERS}/$id",
        map: UserDic.createUserMap(
            loginInfo, id, ios, nameF, nameL, ava, loginType),
        onSucc: () {
          MainVM.shared.performBlockDeleteUser(context);
          MainVM.shared.performAdmineUser(context);
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
