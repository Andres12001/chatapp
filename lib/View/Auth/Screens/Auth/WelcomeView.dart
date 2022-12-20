import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/View/Auth/Widgets/Auth/WelcomeContent.dart';
import 'package:first_app/View/Auth/Widgets/Auth/WelcomeHeader.dart';
import 'package:first_app/ViewModel/Auth/WelcomeVM.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  static const String screenRouteName = "/Welcome";

  final WelcomeVM _welcomeVM = WelcomeVM();

  WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // to provide us the height and the width of the sceen
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(children: [
              //main container
              WelcomeHeader(size: size),
              WelcomeContent(welcomeVM: _welcomeVM)
              //overlay container
            ]),
          ),
        ]),
      ),
    );
  }
}
