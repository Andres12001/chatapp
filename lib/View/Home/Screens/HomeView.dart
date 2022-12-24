import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/ViewModel/Home/HomeVM.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../Constants/TabbarConst.dart';
import '../../../Helpers/FirebaseAuthMethods.dart';
import '../../../Helpers/ListenedValues.dart';
import '../../Auth/Widgets/AvatarCustom.dart';
import '../Tabbar/BottomBarView.dart';
import '../Widgets/HomeContent.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});
  static const String screenRouteName = "/Home";
  ScrollController scrollController = ScrollController();
  final HomeVM _homeVM = HomeVM();

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
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    widget.tabs = [
      HomeContent(
        homeVM: widget._homeVM,
        scrollController: widget.scrollController,
      ),
      Text("2"),
      Text("3"),
      Text("4"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          "Metix",
          style: GoogleFonts.lobster(
              textStyle: const TextStyle(color: Colors.white)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(
              child: AvatarCustom(
                isLocal: false,
                url: FirebaseAuthMethods.getMyPhoto(),
                name: FirebaseAuthMethods.getMyname(),
                onPress: () => {},
                radius: 40,
              ),
            ),
          )
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
