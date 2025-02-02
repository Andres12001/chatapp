// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../Constants/Constants.dart';
import '../../../Helpers/ListenedValues.dart';
import '../../../ViewModel/Meeting/JoinSheetVM.dart';
import '../../Auth/Sheets/TermsSheetView.dart';
import '../../Auth/Widgets/ButtonOriginal.dart';
import '../../Auth/Widgets/TextFieldWidget.dart';

class JoinMeetingContent extends StatelessWidget {
  const JoinMeetingContent({super.key, required this.joinSheetVM});

  final JoinSheetVM joinSheetVM;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      joinSheetVM.checkName();
    });
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
                      hint: "yr_name".tr(),
                      keyboardType: TextInputType.name,
                      onChange: (changedValue) => {
                        joinSheetVM.fieldUpdate(
                            changedValue, joinSheetVM.nameController)
                      },
                      isObscureText: false,
                      controller: joinSheetVM.nameController,
                    ),
                    TextFieldWidget(
                      hint: "meet_code".tr(),
                      keyboardType: TextInputType.text,
                      onChange: (changedValue) => {
                        joinSheetVM.fieldUpdate(
                            changedValue, joinSheetVM.codeController)
                      },
                      isObscureText: false,
                      controller: joinSheetVM.codeController,
                    ),
                    TextFieldWidget(
                      hint: "meet_pass".tr(),
                      keyboardType: TextInputType.text,
                      onChange: (changedValue) => {
                        joinSheetVM.fieldUpdate(
                            changedValue, joinSheetVM.passwordController)
                      },
                      isObscureText: true,
                      controller: joinSheetVM.passwordController,
                    ),
                    ButtonOriginal(
                      text: "join".tr(),
                      bgColor: kPrimaryColor,
                      txtColor: Colors.white,
                      onPress: () => joinSheetVM.joinPre(
                          context: context,
                          code: joinSheetVM.codeController.text,
                          password: joinSheetVM.passwordController.text,
                          name: joinSheetVM.nameController.text),
                      icon: Icons.join_full,
                      width: 200,
                    )
                  ],
                ),
              ),

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
