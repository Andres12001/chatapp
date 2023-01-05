// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/ViewModel/Auth/LoginVM.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../Constants/Constants.dart';
import '../../../Helpers/ListenedValues.dart';
import '../Sheets/TermsSheetView.dart';
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
                      hint: "pass_hint".tr(),
                      keyboardType: TextInputType.text,
                      onChange: (changedValue) => {
                        loginVM.fieldUpdate(
                            changedValue, loginVM.passwordController)
                      },
                      isObscureText: true,
                      controller: loginVM.passwordController,
                    ),
                    ButtonOriginal(
                      text: "login".tr(),
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
                  child: Text(
                    "nt_mmbr_signup".tr(),
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
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
    });
  }
}
