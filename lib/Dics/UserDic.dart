class UserDic {
  static Map<String, dynamic> createUserMap(String loginInfo, String id,
      bool ios, String nameF, String nameL, String? ava) {
    Map<String, dynamic> map = {
      "loginInfo": loginInfo,
      "id": id,
      "ava": ava,
      "isAdmin": false,
      "ios": ios,
      "isprivate": false,
      "nameF": nameF,
      "nameL": nameL,
      "online": true,
      "statue": "Hello , I'm using metix from Swirl code",
      "typing": "",
      "verify": false
    };

    return map;
  }
}
