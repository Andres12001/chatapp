import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart';

import '../Models/MeetingHistory.dart';

class ListenedValues extends ChangeNotifier {
  bool isLoading = false;
  int currentHomeIndex = 0;
  final List<bool> selectedMeetingTypes = <bool>[true, false];
  final List<MeetingHistory> historyList = [];
  MeetingHistory? recentMeeting;

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void setHomeIndex(int currentHomeIndex) {
    this.currentHomeIndex = currentHomeIndex;
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

  void clearHistoryList() {
    historyList.clear();
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
}
