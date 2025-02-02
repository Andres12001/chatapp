// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/ViewModel/Auth/WelcomeVM.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../Screens/LoginView.dart';
import '../Screens/SignupView.dart';
import '../../Meeting/Sheets/JoinSheetView.dart';
import '../Sheets/TermsSheetView.dart';
import 'ButtonsStretch.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key, required this.welcomeVM});
  final WelcomeVM welcomeVM;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kBackgroundColor,
      ),
      //hhere
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //   const Spacer(),
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              "images/welcome.png",
              fit: BoxFit.cover,
            ),
            //   const Spacer(),
            const SizedBox(
              height: 40,
            ),
            ButtonsStretch(
              text: "login".tr(),
              bgColor: kPrimaryColor,
              txtColor: Colors.white,
              onPress: () =>
                  welcomeVM.navigationRoute(context, LoginView.screenRouteName),
              icon: Icons.person,
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonsStretch(
              text: "signup".tr(),
              bgColor: Colors.green,
              txtColor: Colors.white,
              onPress: () => welcomeVM.navigationRoute(
                  context, SignupView.screenRouteName),
              icon: Icons.person_add,
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonsStretch(
              text: "jin_meet".tr(),
              bgColor: kBackgroundColor,
              txtColor: kPrimaryColor,
              onPress: () {
                Navigator.pushNamed(context, JoinMeetingView.screenRouteName);
              },
              icon: Icons.join_full,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    expand: true,
                    builder: (context) => TermsSheetView(),
                  );
                },
                child: Text(
                  "trms".tr(),
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    color: kSecondaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
