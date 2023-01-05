import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart';
import 'package:first_app/Models/User.dart' as dbUser;
import '../Models/Meeting.dart';
import '../Models/MeetingHistory.dart';
import '../Models/User.dart';

class ListenedValues extends ChangeNotifier {
  bool isLoading = false;
  bool isAdmin = false;
  int currentHomeIndex = 0;
  int currentAdminIndex = 0;
  final List<bool> selectedMeetingTypes = <bool>[true, false];
  final List<MeetingHistory> historyList = [];
  final List<MeetingHistory> scheduleHistoryList = [];
  final List<MeetingHistory> adminMeetingList = [];
  final List<User> adminUsersList = [];

  MeetingHistory? recentMeeting;
  dbUser.User? myUser;
  DateTime? scheduleDateTime;

  //Functions

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void setAdmin(bool isAdmin) {
    this.isAdmin = isAdmin;
    notifyListeners();
  }

  void setHomeIndex(int currentHomeIndex) {
    this.currentHomeIndex = currentHomeIndex;
    notifyListeners();
  }

  void setAdminIndex(int currentAdminIndex) {
    this.currentAdminIndex = currentAdminIndex;
    notifyListeners();
  }

  void updateSelectedMeetingTypes(int index) {
    for (int i = 0; i < selectedMeetingTypes.length; i++) {
      selectedMeetingTypes[i] = i == index;
    }
    notifyListeners();
  }

  void updateHistoryList(MeetingHistory history) {
    //check if no duplicate
    historyList.add(history);
    historyList.sort((a, b) {
      return b.meeting.startTime.compareTo(a.meeting.startTime);
    });
    //order
    notifyListeners();
  }

  void updateAdminMeetingList(MeetingHistory history) {
    //check if no duplicate
    adminMeetingList.add(history);
    adminMeetingList.sort((a, b) {
      return b.meeting.startTime.compareTo(a.meeting.startTime);
    });
    //order
    notifyListeners();
  }

  void updateScheduleHistoryList(MeetingHistory history) {
    //check if no duplicate
    scheduleHistoryList.add(history);
    scheduleHistoryList.sort((a, b) {
      return b.meeting.startTime.compareTo(a.meeting.startTime);
    });
    //order
    notifyListeners();
  }

  void updateAdminUsersList(User user) {
    //check if no duplicate
    adminUsersList.add(user);
    notifyListeners();
  }

  void clearHistoryList() {
    historyList.clear();
    notifyListeners();
  }

  void clearScheduleHistoryList() {
    scheduleHistoryList.clear();
    notifyListeners();
  }

  void clearAdminMeetingList() {
    adminMeetingList.clear();
    notifyListeners();
  }

  void clearAdminUsersList() {
    adminUsersList.clear();
    notifyListeners();
  }

  void setRecentMeeting(MeetingHistory historyItem) {
    recentMeeting = historyItem;
    notifyListeners();
  }

  void updateRecentMeetingState(int state) {
    recentMeeting?.meeting.meetingState = state;
    notifyListeners();
  }

  void updateMyUser(dbUser.User user) {
    myUser = user;
    notifyListeners();
  }

  void updateScheduleDateTime(DateTime? date) {
    scheduleDateTime = date;
    notifyListeners();
  }

  void deleteElementAdminUserList(String userId) {
    int index = adminUsersList.indexWhere((element) => element.id == userId);
    if (index != -1) {
      adminUsersList.removeAt(index);
      notifyListeners();
    }
  }

  void updateBlockElementAdminUserList(String userId, bool isBlocked) {
    int index = adminUsersList.indexWhere((element) => element.id == userId);
    if (index != -1) {
      adminUsersList[index].isBlocked = !isBlocked;
      notifyListeners();
    }
  }

  void updateAdminElementAdminUserList(String userId, bool isAdmin) {
    int index = adminUsersList.indexWhere((element) => element.id == userId);
    if (index != -1) {
      adminUsersList[index].isAdmin = !isAdmin;
      notifyListeners();
    }
  }

  void deleteElementAdminMeetingList(String meetingId) {
    int index = adminMeetingList
        .indexWhere((element) => element.meeting.meetingId == meetingId);
    if (index != -1) {
      adminMeetingList.removeAt(index);
      notifyListeners();
    }
  }

  void updateEndElementAdminUserList(String meetingId) {
    int index = adminMeetingList
        .indexWhere((element) => element.meeting.meetingId == meetingId);
    if (index != -1) {
      adminMeetingList[index].meeting.meetingState =
          MeetingStateTypes.ended.index;
      notifyListeners();
    }
  }
}
