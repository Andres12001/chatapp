import 'package:flutter/material.dart';

class WelcomeVM {
  void navigationRoute(BuildContext ctx, String routeName) {
    Navigator.pushNamed(ctx, routeName);
  }

  void showSheet() {}
}
