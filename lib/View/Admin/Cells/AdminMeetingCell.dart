// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/Helpers/DateFormater.dart';
import 'package:first_app/Models/Meeting.dart';
import 'package:first_app/Models/MeetingHistory.dart';
import 'package:first_app/View/Auth/Widgets/AvatarCustom.dart';
import 'package:first_app/View/Auth/Widgets/ButtonOriginal.dart';
import 'package:first_app/ViewModel/Admin/AdminVM.dart';
import 'package:first_app/ViewModel/Meeting/MeetingVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import '../../../Constants/Constants.dart';

class AdminMeetingCell extends StatelessWidget {
  const AdminMeetingCell(
      {super.key, required this.historyItem, required this.adminVM});

  final MeetingHistory historyItem;
  final AdminVM adminVM;

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
                        historyItem.meeting.meetingState ==
                                MeetingStateTypes.active.index
                            ? InkWell(
                                onTap: () {
                                  adminVM.endMeeting(
                                      context, historyItem.meeting.meetingId);
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 25,
                                  color: kPrimaryColor,
                                ),
                              )
                            : Container(),
                        InkWell(
                          onTap: () {
                            adminVM.deleteMeeting(
                                context, historyItem.meeting.meetingId);
                          },
                          child: Icon(
                            Icons.delete,
                            size: 25,
                            color: Colors.red,
                          ),
                        ),
                        Icon(
                          historyItem.meeting.isPrivate
                              ? Icons.lock
                              : Icons.public,
                          size: 25,
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
                          "crt_by".tr(),
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
                      height: 20,
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
                          adminVM.getCallStateString(
                              historyItem.meeting.meetingState),
                          maxLines: 1,
                          style: TextStyle(
                              color: adminVM.getCallStateColor(
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
