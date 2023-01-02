// ignore_for_file: prefer_const_constructors

import 'package:first_app/Helpers/NavigationService.dart';
import 'package:first_app/View/Home/Cells/HistoryCell.dart';
import 'package:first_app/View/Home/Screens/HomeView.dart';
import 'package:first_app/View/Meeting/Sheets/ScheduleSheetView.dart';
import 'package:first_app/ViewModel/Home/ScheduleVM.dart';
import 'package:flutter/material.dart';
import 'package:locally/locally.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../Constants/Constants.dart';
import '../../../Helpers/ListenedValues.dart';
import '../../../ViewModel/Home/HistoryVM.dart';
import '../../Auth/Widgets/ButtonOriginal.dart';

class ScheduleView extends StatelessWidget {
  ScheduleView({super.key, required this.historyVM});
  static const String screenRouteName = "/Schedule";

  final ScheduleVM _scheduleVM = ScheduleVM();
  final HistoryVM historyVM;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _pullRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ButtonOriginal(
                  text: "Schedule meeting",
                  bgColor: kBackgroundColor,
                  txtColor: kPrimaryColor,
                  onPress: () {
                    showCupertinoModalBottomSheet(
                      context: context,
                      expand: true,
                      builder: (context) => ScheduleSheetView(),
                    );
                  },
                  icon: Icons.alarm_add,
                  width: double.infinity),
              SizedBox(
                height: 10,
              ),
              Text(
                "Your Scheduled Meetings",
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
                child: Text("Meetings ordered by nearest to start",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),
              SizedBox(
                height: 30,
              ),
              Provider.of<ListenedValues>(context).scheduleHistoryList.isEmpty
                  ? Center(
                      child: Text("No scheduled meeting to show",
                          style: TextStyle(fontSize: 15, color: Colors.grey)),
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
                    )
            ],
          ),
        ));
  }

  Future<void> _pullRefresh() async {
    historyVM.getHistory(
        NavigationService.navigatorKey.currentContext!, true, true);
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
