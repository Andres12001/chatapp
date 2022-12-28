import '../PreBuilt/src/prebuilt_call_config.dart';

class Meeting {
  final String meetingTitle, password, adminId, meetingId;
  final bool isPrivate, started;
  final int meetingType, startTime;
  int meetingState;

  Meeting(
      {required this.meetingTitle,
      required this.password,
      required this.adminId,
      required this.meetingId,
      required this.isPrivate,
      required this.started,
      required this.meetingType,
      required this.meetingState,
      required this.startTime});

  static Meeting? transformMeeting(Map<String, dynamic> map) {
    //required
    final meetingTitle = map["meetingTitle"] ?? "";
    final password = map["password"];
    final adminId = map["adminId"];
    final meetingId = map["meetingId"];
    final isPrivate = map["isPrivate"];
    final meetingType = map["meetingType"];
    final meetingState = map["meetingState"];
    final startTime = map["startTime"];
    final started = map["started"] ?? false;
    if ((password is! String) ||
        (adminId is! String) ||
        (meetingId is! String) ||
        (isPrivate is! bool) ||
        (meetingState is! int) ||
        (meetingType is! int) ||
        (startTime is! int)) {
      print("Ddd");
      return null;
    }

    return Meeting(
        meetingTitle: meetingTitle,
        password: password,
        adminId: adminId,
        meetingId: meetingId,
        isPrivate: isPrivate,
        started: started,
        meetingType: meetingType,
        meetingState: meetingState,
        startTime: startTime);
  }

  static ZegoUIKitPrebuiltCallConfig getMeetingType(int intmeetingType) {
    final types = MeetingLocalTypes.values[intmeetingType];

    switch (types) {
      case MeetingLocalTypes.groupVideoCall:
        return ZegoUIKitPrebuiltCallConfig.groupVideoCall();
        break;
      case MeetingLocalTypes.groupVoiceCall:
        return ZegoUIKitPrebuiltCallConfig.groupVoiceCall();
        break;
      case MeetingLocalTypes.oneOnOneVideoCall:
        return ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall();
        break;
      case MeetingLocalTypes.oneOnOneVoiceCall:
        return ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();
        break;
    }
  }
}

enum MeetingLocalTypes {
  groupVideoCall,
  groupVoiceCall,
  oneOnOneVideoCall,
  oneOnOneVoiceCall
}

enum MeetingStateTypes { scheduld, active, ended }
