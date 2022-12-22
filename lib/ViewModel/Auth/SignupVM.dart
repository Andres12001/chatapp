// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Dics/UserDic.dart';
import 'package:first_app/View/Auth/Screens/LoginView.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:provider/provider.dart';

import '../../Helpers/ListenedValues.dart';
import '../../View/Home/Screens/HomeView.dart';

class SignupVM {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameFController = TextEditingController();
  TextEditingController nameLController = TextEditingController();

  var imageFinal;

  void fieldUpdate(String value, TextEditingController controller,
      Function(String) updateUI) {
    // controller.text = value;
    updateUI(value);
  }

  Future<User?> signupUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    Provider.of<ListenedValues>(context, listen: false).isLoading = true;
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      print(user);
      print("toooot");
      uploadAva("loginInfo", "id", true, "name", null);
      Navigator.pushNamedAndRemoveUntil(
          context, HomeView.screenRouteName, (route) => false);
    } on FirebaseAuthException catch (e) {
      //  Provider.of<ListenedValues>(context, listen: false).setLoading(false);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  void uploadAva(
      String loginInfo, String id, bool ios, String name, String? ava) {
    if (imageFinal != null) {
      print("not");
    } else {
      print("yes");

      regUserDb(loginInfo, id, ios, name, ava);
    }
  }

  void regUserDb(
      String loginInfo, String id, bool ios, String name, String? ava) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    try {
      await ref.set(UserDic.createUserMap(loginInfo, id, ios, name, ava));
      // Provider.of<ListenedValues>(context, listen: false).setLoading(false);
    } catch (e) {
      // Provider.of<ListenedValues>(context, listen: false).setLoading(false);
      print(e);
    }
  }

  Future getImage(
      ImgSource source, BuildContext context, Function(dynamic) finish) async {
    var image = await ImagePickerGC.pickImage(
        enableCloseButton: true,
        closeIcon: const Icon(
          Icons.close,
          color: Colors.red,
          size: 12,
        ),
        context: context,
        source: source,
        barrierDismissible: true,
        galleryIcon: const Icon(
          Icons.photo,
          color: kPrimaryColor,
        ),
        cameraIcon: const Icon(
          Icons.camera_alt,
          color: Colors.red,
        ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
        cameraText: const Text(
          "From Camera",
          style: TextStyle(color: Colors.red),
        ),
        galleryText: const Text(
          "From Gallery",
          style: TextStyle(color: kPrimaryColor),
        ));
    finish(image);
  }

  void goToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginView.screenRouteName);
  }
}
