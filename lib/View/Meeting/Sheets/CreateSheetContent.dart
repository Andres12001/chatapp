// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../Constants/Constants.dart';
import '../../../Helpers/ListenedValues.dart';
import '../../../PreBuilt/src/prebuilt_call_config.dart';
import '../../../ViewModel/Meeting/CreateSheetVM.dart';
import '../../Auth/Sheets/TermsSheetView.dart';
import '../../Auth/Widgets/ButtonOriginal.dart';
import '../../Auth/Widgets/TextFieldWidget.dart';

class CreateSheetContent extends StatelessWidget {
  const CreateSheetContent({super.key, required this.createSheetVM});

  final CreateSheetVM createSheetVM;
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
              Column(
                children: [
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      //here update the type
                      createSheetVM.updateMeetingTypeToggle(index);

                      Provider.of<ListenedValues>(context, listen: false)
                          .updateSelectedMeetingTypes(index);
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    selectedBorderColor: kPrimaryColor,
                    selectedColor: Colors.white,
                    fillColor: kPrimaryColor,
                    color: kPrimaryColor,
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: Provider.of<ListenedValues>(context)
                        .selectedMeetingTypes,
                    children: [
                      SizedBox(
                          width: (MediaQuery.of(context).size.width - 36) / 2,
                          child: Text(
                            "Voice Meeting",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          )),
                      SizedBox(
                          width: (MediaQuery.of(context).size.width - 36) / 2,
                          child: Text(
                            "Video Meeting",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                  TextFieldWidget(
                    hint: "Meeting Title",
                    keyboardType: TextInputType.name,
                    limitTextCount: 25,
                    onChange: (changedValue) => {
                      createSheetVM.fieldUpdate(
                          changedValue, createSheetVM.titleController)
                    },
                    isObscureText: false,
                    controller: createSheetVM.titleController,
                  ),
                  TextFieldWidget(
                    hint: "Meeting Password (optional)",
                    keyboardType: TextInputType.text,
                    onChange: (changedValue) => {
                      createSheetVM.fieldUpdate(
                          changedValue, createSheetVM.passwordController)
                    },
                    isObscureText: true,
                    controller: createSheetVM.passwordController,
                  ),
                  ButtonOriginal(
                    text: "Create",
                    bgColor: kPrimaryColor,
                    txtColor: Colors.white,
                    onPress: () => createSheetVM.createPre(
                        context: context,
                        password: createSheetVM.passwordController.text,
                        title: createSheetVM.titleController.text),
                    icon: Icons.add_circle,
                    width: 200,
                  )
                ],
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
