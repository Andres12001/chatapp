import 'package:firebase_database/firebase_database.dart';

class MeetingDic {
  static Map<String, dynamic> createMeetingMap(
      String? meetingTitle,
      String password,
      String adminId,
      String meetingId,
      bool isPrivate,
      bool started,
      int meetingType,
      int meetingState) {
    Map<String, dynamic> map = {
      "meetingTitle": meetingTitle,
      "password": password,
      "adminId": adminId,
      "meetingId": meetingId,
      "isPrivate": isPrivate,
      "started": started,
      "meetingType": meetingType,
      "meetingState": meetingState,
      "startTime": ServerValue.timestamp,
    };

    return map;
  }

  static Map<String, dynamic> updateMeetingState(int meetingState) {
    Map<String, dynamic> map = {
      "meetingState": meetingState,
    };

    return map;
  }
}
