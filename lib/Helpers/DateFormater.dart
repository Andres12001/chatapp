import 'package:get_time_ago/get_time_ago.dart';

class DateFormater {
  static String getTimeAgo(int timestamp) {
    return GetTimeAgo.parse(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }
}
