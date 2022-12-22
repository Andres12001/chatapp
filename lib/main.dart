import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Helpers/ListenedValues.dart';
import 'package:first_app/View/Home/Screens/HomeView.dart';
import 'package:first_app/ViewModel/MainVM.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'Constants/MainVars.dart';
import 'Helpers/NavigationService.dart';
import 'View/Auth/Screens/LoginView.dart';
import 'View/Auth/Screens/SignupView.dart';
import 'View/Auth/Screens/WelcomeView.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MainVM _mainVM = MainVM();
  @override
  Widget build(BuildContext context) {
    _mainVM.authStream(context);
    return ChangeNotifierProvider(
      create: (context) => ListenedValues(),
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: _auth.currentUser == null
            ? WelcomeView.screenRouteName
            : HomeView.screenRouteName,
        routes: {
          WelcomeView.screenRouteName: (context) => WelcomeView(),
          LoginView.screenRouteName: (context) => LoginView(),
          SignupView.screenRouteName: (context) => SignupView(),
          HomeView.screenRouteName: (context) => HomeView(),
        },
      ),
    );
  }
}
