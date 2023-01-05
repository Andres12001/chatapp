import 'package:admob_flutter/admob_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/Ads/AdmobClass.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Helpers/ListenedValues.dart';
import 'package:first_app/View/Admin/Screens/AdminView.dart';
import 'package:first_app/View/Auth/Sheets/PolicySheetView.dart';
import 'package:first_app/View/Auth/Sheets/TermsSheetView.dart';
import 'package:first_app/View/Home/Screens/HistoryView.dart';
import 'package:first_app/View/Home/Screens/HomeView.dart';
import 'package:first_app/View/Home/Screens/ScheduleView.dart';
import 'package:first_app/View/Home/Screens/SettingsView.dart';
import 'package:first_app/View/Meeting/MeetingView.dart';
import 'package:first_app/View/Meeting/Sheets/CreateSheetView.dart';
import 'package:first_app/View/Meeting/Sheets/ScheduleSheetView.dart';
import 'package:first_app/ViewModel/MainVM.dart';
import 'package:first_app/ViewModel/Meeting/MeetingVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get_time_ago/get_time_ago.dart';
import 'package:provider/provider.dart';
import 'Helpers/NavigationService.dart';
import 'View/Auth/Screens/LoginView.dart';
import 'View/Auth/Screens/SignupView.dart';
import 'View/Auth/Screens/WelcomeView.dart';
import 'View/Meeting/Sheets/JoinSheetView.dart';
import 'firebase_options.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Admob.initialize();

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
          Locale('de'),
          Locale('es'),
          Locale('fr'),
          Locale('hi'),
          Locale('in'),
          Locale('ko'),
          Locale('ms'),
          Locale('pt'),
          Locale('ru'),
          Locale('tr'),
          Locale('uk')
        ],
        useOnlyLangCode: true,
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // List<String> events = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final MainVM _mainVM = MainVM.shared;
  final MeetingVM _meetingVM = MeetingVM.shared;
  final AdmobClass _admobClass = AdmobClass.shared;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // events.add(state.toString());
    _mainVM.performStateChange(state);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //GetTimeAgo.setCustomLocaleMessages('en', CustomMessages()); //here for lang and custom
    GetTimeAgo.setDefaultLocale('en'); //here for lang
    _mainVM.authStream(context);
    _mainVM.performBlockDeleteUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return FGBGNotifier(
        onEvent: (event) {
          //  events.add(event.toString());
          _mainVM.performEventChange(event);
        },
        child: ChangeNotifierProvider(
          create: (context) => ListenedValues(),
          child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
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
              JoinMeetingView.screenRouteName: (context) =>
                  JoinMeetingView(), //open
              TermsSheetView.screenRouteName: (context) =>
                  TermsSheetView(), //open
              CreateMeetingView.screenRouteName: (context) =>
                  CreateMeetingView(),
              ScheduleMeetingView.screenRouteName: (context) =>
                  ScheduleMeetingView(),
              // ScheduleView.screenRouteName: (context) => ScheduleView(),
              // HistoryView.screenRouteName: (context) => HistoryView(historyVM: null,),
              SettingsView.screenRouteName: (context) => SettingsView(),
              PolicySheetView.screenRouteName: (context) =>
                  PolicySheetView(), //open
              //Admin
              AdminView.screenRouteName: (context) => AdminView(),
            },
          ),
        ));
  }
}
