import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/ViewModel/Auth/WelcomeVM.dart';
import 'package:flutter/material.dart';

import '../Screens/LoginView.dart';
import '../Screens/SignupView.dart';
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
        child: Expanded(
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
                text: "Login",
                bgColor: kPrimaryColor,
                txtColor: Colors.white,
                onPress: () => welcomeVM.navigationRoute(
                    context, LoginView.screenRouteName),
                icon: Icons.person,
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonsStretch(
                text: "Signup",
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
                text: "Join Meeting",
                bgColor: kLabelColor,
                txtColor: kBackgroundColor,
                onPress: () => welcomeVM.navigationRoute(context, "routeName"),
                icon: Icons.join_full,
              ),
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Terms and conditions",
                  style: TextStyle(
                    fontSize: 15,
                    color: kSecondaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
