import 'package:flutter/material.dart';

class LoginVM {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void fieldUpdate(String value, TextEditingController controller) {
    // controller.text = value;
    // print(controller.text);
  }

  void login() {}
}
