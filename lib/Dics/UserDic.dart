class UserDic {
  static Map<String, dynamic> createUserMap(
      String loginInfo, String id, bool ios, String name, String? ava) {
    Map<String, dynamic> map = {
      "loginInfo": loginInfo,
      "id": id,
      "ava": ava,
      "isAdmin": false,
      "ios": ios,
      "isprivate": false,
      "name": name,
      "online": true,
      "statue": "Hello , I'm using metix from Swirl code",
      "typing": "",
      "verify": false
    };

    return map;
  }
}
