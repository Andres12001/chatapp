// ignore_for_file: prefer_const_constructors

import 'package:first_app/ViewModel/Meeting/ScheduleSheetVM.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../../../Constants/Constants.dart';
import '../../../Helpers/ListenedValues.dart';
import '../../Auth/Sheets/TermsSheetView.dart';
import '../../Auth/Widgets/ButtonOriginal.dart';
import '../../Auth/Widgets/TextFieldWidget.dart';

class ScheduleSheetContent extends StatelessWidget {
  const ScheduleSheetContent({super.key, required this.scheduleSheetVM});

  final ScheduleSheetVM scheduleSheetVM;
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
                      scheduleSheetVM.updateMeetingTypeToggle(index);

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
                      scheduleSheetVM.fieldUpdate(
                          changedValue, scheduleSheetVM.titleController)
                    },
                    isObscureText: false,
                    controller: scheduleSheetVM.titleController,
                  ),
                  TextFieldWidget(
                    hint: "Meeting Password (optional)",
                    keyboardType: TextInputType.text,
                    onChange: (changedValue) => {
                      scheduleSheetVM.fieldUpdate(
                          changedValue, scheduleSheetVM.passwordController)
                    },
                    isObscureText: true,
                    controller: scheduleSheetVM.passwordController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonOriginal(
                      text: Provider.of<ListenedValues>(context)
                                  .scheduleDateTime ==
                              null
                          ? "Choose Date Time"
                          : scheduleSheetVM.formateDate(
                              Provider.of<ListenedValues>(context)
                                  .scheduleDateTime!),
                      bgColor: kBackgroundColor,
                      txtColor: kPrimaryColor,
                      onPress: () => scheduleSheetVM.chooseDateAndTime(context),
                      icon: Icons.calendar_month,
                      width: double.infinity),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonOriginal(
                    text: "Schedule",
                    bgColor: kPrimaryColor,
                    txtColor: Colors.white,
                    onPress: () => scheduleSheetVM.createPre(
                        context: context,
                        password: scheduleSheetVM.passwordController.text,
                        title: scheduleSheetVM.titleController.text),
                    icon: Icons.alarm_add,
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
