import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Constants/FirebaseConst.dart';
import 'package:first_app/Helpers/FirebaseMethods.dart';
import 'package:first_app/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Helpers/ListenedValues.dart';
import '../../Models/Meeting.dart';
import '../../Models/MeetingHistory.dart';

class HistoryVM {
  final FirebaseMethods _firebaseMethods = FirebaseMethods();
  HistoryVM(BuildContext context, bool isSchedule) {
    getHistory(context, false, isSchedule);
  }

  void getHistory(BuildContext context, bool isReloaded, bool isSchedule) {
    if (myId == null) {
      return;
    }
    // if (!isReloaded) {
    //   Provider.of<ListenedValues>(context, listen: false).setLoading(true);
    // }
    if (isSchedule) {
      Provider.of<ListenedValues>(context, listen: false)
          .clearScheduleHistoryList();
    } else {
      Provider.of<ListenedValues>(context, listen: false).clearHistoryList();
    }

    _firebaseMethods.getSingleDataFromFirebase(
        childPath: "/${FirebaseConst.HISTORY}/$myId",
        onSucc: ((snapshot) {
          Map<String, dynamic> historyMap =
              Map<String, dynamic>.from(snapshot.value as Map);

          if (historyMap.keys.isEmpty) {
            Provider.of<ListenedValues>(context, listen: false)
                .clearHistoryList();
            Provider.of<ListenedValues>(context, listen: false)
                .setLoading(false);
            return;
          }

          for (var key in historyMap.keys) {
            _getMeeting(context, key, isSchedule);
          }
        }),
        onFailed: (error) {
          Provider.of<ListenedValues>(context, listen: false).setLoading(false);
        });
  }

  void _getMeeting(BuildContext context, String meetingKey, bool isSchedule) {
    _firebaseMethods.getSingleDataFromFirebase(
        childPath: "/${FirebaseConst.MEETINGS}/$meetingKey",
        onSucc: ((snapshot) {
          late Map<String, dynamic> meetingMap;

          meetingMap = Map<String, dynamic>.from(snapshot.value as Map);
          if (meetingMap is! Map<String, dynamic>) {
            Provider.of<ListenedValues>(context, listen: false)
                .setLoading(false);
            return;
          }

          var meeting = Meeting.transformMeeting(meetingMap);
          if (meeting is! Meeting) {
            Provider.of<ListenedValues>(context, listen: false)
                .setLoading(false);
            return;
          }

//for history
          if (meeting.started && !isSchedule) {
            _getAdmin(context, meeting, isSchedule);
          }

          //for schedule history
          if (!meeting.started && isSchedule) {
            _getAdmin(context, meeting, isSchedule);
          }
        }),
        onFailed: (error) {});
  }

  void _getAdmin(BuildContext context, Meeting meeting, bool isSchedule) {
    _firebaseMethods.getSingleDataFromFirebase(
        childPath: "/${FirebaseConst.USERS}/${meeting.adminId}",
        onSucc: ((snapshot) {
          late Map<String, dynamic> userMap;

          userMap = Map<String, dynamic>.from(snapshot.value as Map);
          if (userMap is! Map<String, dynamic>) {
            Provider.of<ListenedValues>(context, listen: false)
                .setLoading(false);
            return;
          }

          var user = User.transformUser(userMap);
          if (user is! User) {
            Provider.of<ListenedValues>(context, listen: false)
                .setLoading(false);
            return;
          }

          //for history
          if (meeting.started && !isSchedule) {
            Provider.of<ListenedValues>(context, listen: false)
                .updateHistoryList(
                    MeetingHistory(meeting: meeting, user: user));
          }

          //for schedule history
          if (!meeting.started && isSchedule) {
            Provider.of<ListenedValues>(context, listen: false)
                .updateScheduleHistoryList(
                    MeetingHistory(meeting: meeting, user: user));
          }
        }),
        onFailed: (error) {});
  }

  String getCallStateString(int state) {
    String stateString = "";
    switch (MeetingStateTypes.values[state]) {
      case MeetingStateTypes.active:
        stateString = "Active";
        break;
      case MeetingStateTypes.ended:
        stateString = "Ended";
        break;
      case MeetingStateTypes.scheduld:
        stateString = "Scheduled";
        break;
    }
    return stateString;
  }

  Color getCallStateColor(int state) {
    Color stateColor = kLabelColor;
    switch (MeetingStateTypes.values[state]) {
      case MeetingStateTypes.active:
        stateColor = kPrimaryColor;
        break;
      case MeetingStateTypes.ended:
        stateColor = Colors.red;
        break;
      case MeetingStateTypes.scheduld:
        stateColor = Colors.orange;
        break;
    }
    return stateColor;
  }
}
