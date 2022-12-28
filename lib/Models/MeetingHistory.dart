import 'package:first_app/Models/Meeting.dart';
import 'package:first_app/Models/User.dart';

class MeetingHistory {
  Meeting meeting;
  final User user;

  MeetingHistory({required this.meeting, required this.user});
}
