// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/Helpers/NavigationService.dart';
import 'package:first_app/View/Home/Cells/HistoryCell.dart';
import 'package:first_app/View/Home/Screens/HomeView.dart';
import 'package:first_app/View/Meeting/Sheets/ScheduleSheetView.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:locally/locally.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../Ads/AdmobClass.dart';
import '../../../Constants/Constants.dart';
import '../../../Helpers/FirebaseMethods.dart';
import '../../../Helpers/ListenedValues.dart';
import '../../../ViewModel/Home/HistoryVM.dart';
import '../../Auth/Screens/WelcomeView.dart';
import '../../Auth/Widgets/ButtonOriginal.dart';

class ScheduleView extends StatelessWidget {
  ScheduleView({super.key, required this.historyVM});
  static const String screenRouteName = "/Schedule";

  final HistoryVM historyVM;

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusLost: () {
        // print(
        //   'Focus Lost.'
        //   '\nTriggered when either [onVisibilityLost] or [onForegroundLost] '
        //   'is called.'
        //   '\nEquivalent to onPause() on Android or viewDidDisappear() on iOS.',
        // );
      },
      onFocusGained: () {
        // print(
        //   'Focus Gained.'
        //   '\nTriggered when either [onVisibilityGained] or [onForegroundGained] '
        //   'is called.'
        //   '\nEquivalent to onResume() on Android or viewDidAppear() on iOS.',
        // );
        historyVM.getHistory(
            NavigationService.navigatorKey.currentContext!, true, true);
      },
      onVisibilityLost: () {
        // print(
        //   'Visibility Lost.'
        //   '\nIt means the widget is no longer visible within your app.',
        // );
      },
      onVisibilityGained: () {
        // print(
        //   'Visibility Gained.'
        //   '\nIt means the widget is now visible within your app.',
        // );
      },
      onForegroundLost: () {
        // print(
        //   'Foreground Lost.'
        //   '\nIt means, for example, that the user sent your app to the background by opening '
        //   'another app or turned off the device\'s screen while your '
        //   'widget was visible.',
        // );
      },
      onForegroundGained: () {
        // print(
        //   'Foreground Gained.'
        //   '\nIt means, for example, that the user switched back to your app or turned the '
        //   'device\'s screen back on while your widget was visible.',
        // );
      },
      child: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                children: [
                  ButtonOriginal(
                      text: "schd_meet".tr(),
                      bgColor: kBackgroundColor,
                      txtColor: kPrimaryColor,
                      onPress: () {
                        Navigator.pushNamed(
                            context, ScheduleMeetingView.screenRouteName);
                      },
                      icon: Icons.alarm_add,
                      width: double.infinity),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "ur_schd_meet".tr(),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 20,
                        color: kLabelColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text("meet_order_nearst".tr(),
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Provider.of<ListenedValues>(context)
                          .scheduleHistoryList
                          .isEmpty
                      ? Center(
                          child: Text("no_sched".tr(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey)),
                        )
                      : ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: Provider.of<ListenedValues>(context)
                              .scheduleHistoryList
                              .length,
                          itemBuilder: (context, index) {
                            return HistoryCell(
                              historyItem: Provider.of<ListenedValues>(context)
                                  .scheduleHistoryList[index],
                              historyVM: historyVM,
                            );
                          },
                        ),
                  AdmobClass.shared.displayAdBanner()
                ],
              ),
            ),
          )),
    );
  }

  Future<void> _pullRefresh() async {
    historyVM.getHistory(
        NavigationService.navigatorKey.currentContext!, true, true);
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
