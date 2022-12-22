import 'package:flutter/foundation.dart';

class ListenedValues extends ChangeNotifier {
  bool isLoading = false;

  void setLoading(bool isLoading) {
    isLoading = isLoading;
  }
}
