import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/View/Auth/Screens/Auth/WelcomeView.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io' show Platform;

import 'View/Auth/Screens/Auth/LoginView.dart';
import 'View/Auth/Screens/Auth/SignupView.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await windowManager.ensureInitialized();
  // if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
  //   WindowManager.instance.setMinimumSize(const Size(1200, 600));
  //   //  WindowManager.instance.setMaximumSize(const Size(1200, 900));
  // }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeView.screenRouteName,
      routes: {
        WelcomeView.screenRouteName: (context) => WelcomeView(),
        LoginView.screenRouteName: (context) => LoginView(),
        SignupView.screenRouteName: (context) => SignupView(),
      },
    );
  }
}
