// ignore_for_file: prefer_const_constructors

import 'package:first_app/ViewModel/Auth/LoginVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Constants/Constants.dart';
import '../../../Helpers/ListenedValues.dart';
import 'ButtonOriginal.dart';
import 'TextFieldWidget.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key, required this.loginVM});

  final LoginVM loginVM;
  @override
  Widget build(BuildContext context) {
    return Consumer<ListenedValues>(builder: (context, updatedData, child) {
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
                        loginVM.fieldUpdate(
                            changedValue, loginVM.emailController)
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
                      onPress: () => loginVM.loginPre(
                          context: context,
                          email: loginVM.emailController.text,
                          password: loginVM.passwordController.text),
                      icon: Icons.login,
                      width: 200,
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => loginVM.goToSignup(context),
                  child: const Text(
                    "Not a member yet? Signup now",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 17,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),

              // const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => {},
                  child: Text(
                    "Terms and conditions",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12,
                      color: kSecondaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
    });
  }
}
