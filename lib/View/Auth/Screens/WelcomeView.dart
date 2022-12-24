import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/ViewModel/Auth/WelcomeVM.dart';
import 'package:flutter/material.dart';

import '../Widgets/WelcomeContent.dart';
import '../Widgets/WelcomeHeader.dart';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(children: [
                  //main container
                  WelcomeHeader(
                    size: size,
                    title: 'Metix',
                  ),
                  WelcomeContent(welcomeVM: _welcomeVM)
                  //overlay container
                ]),
              ),
            ]),
      ),
    );
  }
}
