// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/View/Auth/Screens/SignupView.dart';
import 'package:first_app/View/Auth/Screens/WelcomeView.dart';
import 'package:first_app/View/Home/Screens/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Helpers/ListenedValues.dart';

class LoginVM {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void fieldUpdate(String value, TextEditingController controller) {
    // controller.text = value;
    // print(controller.text);
  }

  Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    //Provider.of<ListenedValues>(context, listen: false).isLoading = true;
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      print(user);
      print("toooot");
      //  print(Provider.of<ListenedValues>(context).isLoading);
      Navigator.pushNamedAndRemoveUntil(
          context, HomeView.screenRouteName, (route) => false);
      // Provider.of<ListenedValues>(context,listen: false).setLoading(false);
    } on FirebaseAuthException catch (e) {
      //   Provider.of<ListenedValues>(context, listen: false).setLoading(false);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  void goToSignup(BuildContext context) {
    Navigator.pushReplacementNamed(context, SignupView.screenRouteName);
  }
}
