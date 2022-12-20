import 'package:first_app/View/Auth/Widgets/Auth/ButtonOriginal.dart';
import 'package:first_app/View/Auth/Widgets/Auth/ButtonsStretch.dart';
import 'package:first_app/ViewModel/Auth/LoginVM.dart';
import 'package:flutter/material.dart';

import '../../../../Constants/Constants.dart';
import 'TextFieldWidget.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key, required this.loginVM});

  final LoginVM loginVM;
  @override
  Widget build(BuildContext context) {
    return Container(
      //  margin: EdgeInsets.only(top: size.height * 0.09),
      decoration: const BoxDecoration(
        color: kBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Spacer(),
            const SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                children: [
                  TextFieldWidget(
                    hint: "example@example.com",
                    keyboardType: TextInputType.emailAddress,
                    onChange: (changedValue) => {
                      loginVM.fieldUpdate(changedValue, loginVM.emailController)
                    },
                    isObscureText: false,
                    controller: loginVM.emailController,
                  ),
                  TextFieldWidget(
                    hint: "Password at least 6 characters",
                    keyboardType: TextInputType.emailAddress,
                    onChange: (changedValue) => {
                      loginVM.fieldUpdate(
                          changedValue, loginVM.passwordController)
                    },
                    isObscureText: true,
                    controller: loginVM.passwordController,
                  ),
                  ButtonOriginal(
                    text: "Login",
                    bgColor: kPrimaryColor,
                    txtColor: Colors.white,
                    onPress: () => loginVM.login(),
                    icon: Icons.login,
                    width: 200,
                  )
                ],
              ),
            ),

            // const Spacer(),
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
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
