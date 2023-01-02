// ignore_for_file: prefer_const_constructors

import 'package:first_app/Helpers/DateFormater.dart';
import 'package:first_app/Helpers/FirebaseMethods.dart';
import 'package:first_app/Models/Meeting.dart';
import 'package:first_app/Models/MeetingHistory.dart';
import 'package:first_app/View/Auth/Widgets/AvatarCustom.dart';
import 'package:first_app/View/Auth/Widgets/ButtonOriginal.dart';
import 'package:first_app/ViewModel/Meeting/MeetingVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import '../../../Constants/Constants.dart';
import '../../../ViewModel/Home/HistoryVM.dart';

class HistoryCell extends StatelessWidget {
  const HistoryCell(
      {super.key, required this.historyItem, required this.historyVM});

  final MeetingHistory historyItem;
  final HistoryVM historyVM;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: SizedBox(
          // width: width,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            elevation: 7,
            color: kBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          (historyItem.meeting.meetingType ==
                                  MeetingLocalTypes.groupVideoCall.index)
                              ? SFSymbols.videocam_circle
                              : SFSymbols.phone_circle,
                          size: 30,
                          color: kLabelColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          historyItem.meeting.meetingTitle,
                          maxLines: 1,
                          style: TextStyle(
                              color: kLabelColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          historyItem.meeting.isPrivate
                              ? Icons.lock
                              : Icons.public,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Created by : ",
                          maxLines: 1,
                          style: TextStyle(
                              color: kLabelColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        AvatarCustom(
                            name:
                                "${historyItem.user.nameF} ${historyItem.user.nameL}",
                            onPress: () {},
                            url: historyItem.user.ava,
                            isLocal: false,
                            radius: 30),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${historyItem.user.nameF} ${historyItem.user.nameL}",
                          maxLines: 1,
                          style: TextStyle(
                              color: kLabelColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    historyItem.meeting.started
                        ? Container()
                        : ButtonOriginal(
                            text: "Start meeting",
                            bgColor: kPrimaryColor,
                            txtColor: Colors.white,
                            onPress: () {
                              MeetingVM.shared.joinRoom(
                                  context: context,
                                  userName:
                                      "${historyItem.user.nameF} ${historyItem.user.nameL}",
                                  userId: historyItem.user.id,
                                  enteredMeetingId:
                                      historyItem.meeting.meetingId,
                                  password: historyItem.meeting.password,
                                  scheduleStart: true);
                            },
                            icon: Icons.arrow_circle_right,
                            width: double.infinity),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          DateFormater.getTimeAgo(
                              historyItem.meeting.startTime),
                          maxLines: 1,
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        Spacer(),
                        Text(
                          historyVM.getCallStateString(
                              historyItem.meeting.meetingState),
                          maxLines: 1,
                          style: TextStyle(
                              color: historyVM.getCallStateColor(
                                  historyItem.meeting.meetingState),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ));
  }
}
