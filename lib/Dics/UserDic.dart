class UserDic {
  static Map<String, dynamic> createUserMap(String loginInfo, String id,
      bool ios, String nameF, String nameL, String? ava, String loginType) {
    Map<String, dynamic> map = {
      "loginInfo": loginInfo,
      "id": id,
      "ava": ava,
      "isAdmin": false,
      "ios": ios,
      "isprivate": false,
      "nameF": nameF,
      "nameL": nameL,
      "loginType": loginType,
      "online": true,
      "statue": "Hello , I'm using metix from Swirl code",
      "meetingId": "",
      "isBlocked": false,
      "verify": false
    };

    return map;
  }

  static Map<String, dynamic> updateUserRoomId(String meetingId) {
    Map<String, dynamic> map = {
      "meetingId": meetingId,
    };

    return map;
  }
}
