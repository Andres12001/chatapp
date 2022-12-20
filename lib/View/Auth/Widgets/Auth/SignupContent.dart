import 'package:first_app/View/Auth/Widgets/Auth/ButtonOriginal.dart';
import 'package:first_app/ViewModel/Auth/SignupVM.dart';
import 'package:flutter/material.dart';

import '../../../../Constants/Constants.dart';
import 'TextFieldWidget.dart';

class SignupContent extends StatelessWidget {
  const SignupContent({super.key, required this.signupVM});

  final SignupVM signupVM;
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
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        hint: "First Name",
                        keyboardType: TextInputType.emailAddress,
                        onChange: (changedValue) => {
                          signupVM.fieldUpdate(
                              changedValue, signupVM.emailController)
                        },
                        isObscureText: false,
                        controller: signupVM.emailController,
                      ),
                    ),
                    Expanded(
                      child: TextFieldWidget(
                        hint: "Last Name",
                        keyboardType: TextInputType.emailAddress,
                        onChange: (changedValue) => {
                          signupVM.fieldUpdate(
                              changedValue, signupVM.emailController)
                        },
                        isObscureText: false,
                        controller: signupVM.emailController,
                      ),
                    )
                  ],
                ),
                TextFieldWidget(
                  hint: "example@example.com",
                  keyboardType: TextInputType.emailAddress,
                  onChange: (changedValue) => {
                    signupVM.fieldUpdate(changedValue, signupVM.emailController)
                  },
                  isObscureText: false,
                  controller: signupVM.emailController,
                ),
                TextFieldWidget(
                  hint: "Password at least 6 characters",
                  keyboardType: TextInputType.emailAddress,
                  onChange: (changedValue) => {
                    signupVM.fieldUpdate(
                        changedValue, signupVM.passwordController)
                  },
                  isObscureText: true,
                  controller: signupVM.passwordController,
                ),
                ButtonOriginal(
                  text: "Login",
                  bgColor: kPrimaryColor,
                  txtColor: Colors.white,
                  onPress: () => signupVM.login(),
                  icon: Icons.login,
                  width: 200,
                )
              ],
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
