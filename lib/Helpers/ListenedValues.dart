import 'package:flutter/foundation.dart';

class ListenedValues extends ChangeNotifier {
  bool isLoading = false;
  int currentHomeIndex = 0;
  final List<bool> selectedMeetingTypes = <bool>[true, false];

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
}
