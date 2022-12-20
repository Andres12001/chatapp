import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/View/Auth/Widgets/Auth/LoginContent.dart';
import 'package:first_app/View/Auth/Widgets/Auth/SignupContent.dart';
import 'package:first_app/ViewModel/Auth/SignupVM.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/Auth/WelcomeHeader.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});
  static const String screenRouteName = "/Signup";

  final SignupVM _signupVM = SignupVM();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          "Metix",
          style: GoogleFonts.lobster(
              textStyle: const TextStyle(color: Colors.white)),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(children: [
              //main container
              WelcomeHeader(size: size),
              SignupContent(signupVM: _signupVM)
              //overlay container
            ]),
          ),
        ]),
      ),
    );
  }
}
