// ignore_for_file: prefer_const_constructors

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/View/Admin/Screens/AdminView.dart';
import 'package:first_app/View/Auth/Screens/WelcomeView.dart';
import 'package:first_app/View/Home/Screens/HistoryView.dart';
import 'package:first_app/View/Home/Screens/ScheduleView.dart';
import 'package:first_app/View/Home/Screens/SettingsView.dart';
import 'package:first_app/ViewModel/Home/HomeVM.dart';
import 'package:first_app/ViewModel/MainVM.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../Ads/AdmobClass.dart';
import '../../../Constants/TabbarConst.dart';
import '../../../Helpers/FirebaseAuthMethods.dart';
import '../../../Helpers/FirebaseMethods.dart';
import '../../../Helpers/ListenedValues.dart';
import '../../../Helpers/NavigationService.dart';
import '../../../ViewModel/Home/HistoryVM.dart';
import '../../Auth/Widgets/AvatarCustom.dart';
import '../Tabbar/BottomBarView.dart';
import '../Widgets/HomeContent.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeView extends StatefulWidget {
  HomeView({super.key});
  static const String screenRouteName = "/Home";
  ScrollController scrollController = ScrollController();
  final HomeVM _homeVM = HomeVM();
  final HistoryVM _historyVM =
      HistoryVM(NavigationService.navigatorKey.currentContext!, false);
  final HistoryVM _historyScheduleVM =
      HistoryVM(NavigationService.navigatorKey.currentContext!, true);
  List<Widget> tabs = [];

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool circleButtonToggle = false;

  @override
  void initState() {
    super.initState();
    //Waiting the widget to be loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._homeVM.scrollAnimated(widget.scrollController, 38);
    });
    MainVM.shared.performAdmineUser(context);
    if (myId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
            context, WelcomeView.screenRouteName, (route) => false);
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    widget.tabs = [
      HomeContent(
        homeVM: widget._homeVM,
        scrollController: widget.scrollController,
        historyVM: widget._historyVM,
      ),
      HistoryView(
        historyVM: widget._historyVM,
      ),
      ScheduleView(historyVM: widget._historyScheduleVM),
      SettingsView()
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._homeVM.scrollAnimated(widget.scrollController, 38);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          "app_name".tr(),
          style: GoogleFonts.lobster(
              textStyle: const TextStyle(color: Colors.white)),
        ),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AdminView.screenRouteName);
                },
                child: kIsWeb
                    ? Provider.of<ListenedValues>(context).isAdmin
                        ? Row(
                            children: [
                              Icon(
                                Icons.admin_panel_settings,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              if (kIsWeb)
                                Text(
                                  "admn_pnl".tr(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              else
                                Container(),
                            ],
                          )
                        : Container()
                    : Container(),
              ),
              const SizedBox(
                width: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Center(
                  child: AvatarCustom(
                    isLocal: false,
                    url: FirebaseAuthMethods.getMyPhoto(),
                    name: FirebaseAuthMethods.getMyname(),
                    onPress: () {
                      AdmobClass.shared.showInitAd();
                      widget._homeVM.onTabTapped(3, context);
                    },
                    radius: 40,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      backgroundColor: kBackgroundColor,
      floatingActionButton: const SizedBox(
        height: tabDimens.heightNormal,
        width: tabDimens.widthNormal,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBarView(
        homeVM: widget._homeVM,
      ),
      body: BlurryModalProgressHUD(
        inAsyncCall: Provider.of<ListenedValues>(context).isLoading,
        blurEffectIntensity: 4,
        progressIndicator:
            const CircularProgressIndicator(color: kPrimaryColor),
        dismissible: false,
        opacity: 0.4,
        color: Colors.black87,
        child: SafeArea(
            bottom: false,
            child: widget
                .tabs[Provider.of<ListenedValues>(context).currentHomeIndex]),
      ),
    );
  }

  // void onTabTapped(int index) {
  //   setState(() {
  //     Provider.of<ListenedValues>(context, listen: false).setHomeIndex(index);
  //   });
  // }
}
