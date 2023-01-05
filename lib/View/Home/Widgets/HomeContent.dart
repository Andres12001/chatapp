// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Helpers/FirebaseMethods.dart';
import 'package:first_app/Helpers/NavigationService.dart';
import 'package:first_app/View/Home/Cells/HistoryCell.dart';
import 'package:first_app/View/Home/Widgets/HomeArc.dart';
import 'package:first_app/ViewModel/Home/HistoryVM.dart';
import 'package:first_app/ViewModel/Home/HomeVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../Ads/AdmobClass.dart';
import '../../../Constants/Constants.dart';
import '../../../Helpers/ListenedValues.dart';
import '../../../Models/Meeting.dart';
import '../../../ViewModel/Meeting/MeetingVM.dart';
import '../../Auth/Widgets/ButtonOriginal.dart';
import 'HomeRow.dart';

class HomeContent extends StatelessWidget {
  HomeContent(
      {super.key,
      required this.homeVM,
      required this.scrollController,
      required this.historyVM});

  final HomeVM homeVM;
  final ScrollController scrollController;
  final MeetingVM _meetingVM = MeetingVM.shared;
  final HistoryVM historyVM;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Expanded(
              child: Container(
                color: kBackgroundColor,
                child: Column(children: [
                  //main container
                  HomeArc(
                      kCurveHeight: 60,
                      kViewHeight: 200,
                      contentWidget: HomeRow(
                        scrollController: scrollController,
                      )),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "yr_recent_meet".tr(),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 30,
                            color: kLabelColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Provider.of<ListenedValues>(context).recentMeeting == null
                          ? Text("no_rece_meet".tr(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey))
                          : InkWell(
                              onTap: () {
                                if (Provider.of<ListenedValues>(context,
                                            listen: false)
                                        .recentMeeting!
                                        .meeting
                                        .meetingState ==
                                    MeetingStateTypes.active.index) {
                                  MeetingVM.shared.joinRoom(
                                      context: context,
                                      userName: FirebaseAuth.instance
                                              .currentUser?.displayName ??
                                          "",
                                      userId: myId!,
                                      enteredMeetingId:
                                          Provider.of<ListenedValues>(context,
                                                  listen: false)
                                              .recentMeeting!
                                              .meeting
                                              .meetingId,
                                      password: Provider.of<ListenedValues>(
                                              context,
                                              listen: false)
                                          .recentMeeting!
                                          .meeting
                                          .password);
                                } else {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    title: 'ops'.tr(),
                                    text: "cnt_ended_meet".tr(),
                                  );
                                }
                              },
                              child: HistoryCell(
                                  historyItem: Provider.of<ListenedValues>(
                                          context,
                                          listen: false)
                                      .recentMeeting!,
                                  historyVM: historyVM),
                            ),
                    ],
                  ),
                  AdmobClass.shared.displayAdBanner()
                ]),
              ),
            ),
          ),
        ]);
  }
}
