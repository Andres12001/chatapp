import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Helpers/ListenedValues.dart';
import 'package:first_app/View/Auth/Sheets/TermsSheetView.dart';
import 'package:first_app/View/Home/Screens/HomeView.dart';
import 'package:first_app/View/Meeting/MeetingView.dart';
import 'package:first_app/ViewModel/MainVM.dart';
import 'package:first_app/ViewModel/Meeting/MeetingVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'Helpers/NavigationService.dart';
import 'View/Auth/Screens/LoginView.dart';
import 'View/Auth/Screens/SignupView.dart';
import 'View/Auth/Screens/WelcomeView.dart';
import 'View/Auth/Sheets/JoinSheetView.dart';
import 'firebase_options.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // List<String> events = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final MainVM _mainVM = MainVM();
  final MeetingVM _meetingVM = MeetingVM.shared;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // events.add(state.toString());
    _mainVM.performStateChange(state);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    _mainVM.authStream(context);
    return FGBGNotifier(
        onEvent: (event) {
          //  events.add(event.toString());
          _mainVM.performEventChange(event);
        },
        child: ChangeNotifierProvider(
          create: (context) => ListenedValues(),
          child: MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            theme: ThemeData(
              primaryColor: kPrimaryColor,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: (_auth.currentUser == null ||
                    (_auth.currentUser?.isAnonymous ?? true))
                ? WelcomeView.screenRouteName
                : HomeView.screenRouteName,
            routes: {
              WelcomeView.screenRouteName: (context) => WelcomeView(),
              LoginView.screenRouteName: (context) => LoginView(),
              SignupView.screenRouteName: (context) => SignupView(),
              HomeView.screenRouteName: (context) => HomeView(),
              MeetingView.screenRouteName: (context) => MeetingView(),
              JoinSheetView.screenRouteName: (context) => JoinSheetView(),
              TermsSheetView.screenRouteName: (context) => TermsSheetView(),
            },
          ),
        ));
  }
}
