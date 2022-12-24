import 'package:flutter/foundation.dart';

class ListenedValues extends ChangeNotifier {
  bool isLoading = false;
  int currentHomeIndex = 0;

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void setHomeIndex(int currentHomeIndex) {
    this.currentHomeIndex = currentHomeIndex;
    notifyListeners();
  }
}
