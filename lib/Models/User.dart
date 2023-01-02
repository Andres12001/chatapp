class User {
  final String loginInfo, id, ava, nameF, nameL, statue, meetingId, loginType;
  final bool isAdmin, ios, isprivate, verify, online, isBlocked;

  User(
      {required this.loginInfo,
      required this.id,
      required this.ava,
      required this.online,
      required this.nameF,
      required this.nameL,
      required this.loginType,
      required this.statue,
      required this.meetingId,
      required this.isAdmin,
      required this.ios,
      required this.isprivate,
      required this.verify,
      required this.isBlocked});

  static User? transformUser(Map<String, dynamic> map) {
    //required
    final loginInfo = map["loginInfo"];
    final id = map["id"];
    final nameF = map["nameF"];
    final nameL = map["nameL"];
    final loginType = map["loginType"];
    final ava = map["ava"] ?? "";
    final statue = map["statue"] ?? "";
    final isBlocked = map["isBlocked"];
    final meetingId = map["meetingId"] ?? "";
    final isAdmin = map["isAdmin"] ?? false;
    final ios = map["ios"] ?? false;
    final isprivate = map["isprivate"] ?? false;
    final verify = map["verify"] ?? false;
    final online = map["online"] ?? false;

    if ((loginInfo is! String) ||
        (id is! String) ||
        (nameF is! String) ||
        (nameL is! String) ||
        (loginType is! String) ||
        (isBlocked is! bool)) {
      return null;
    }

    return User(
        loginInfo: loginInfo,
        id: id,
        ava: ava,
        online: online,
        nameF: nameF,
        nameL: nameL,
        statue: statue,
        meetingId: meetingId,
        isAdmin: isAdmin,
        ios: ios,
        isprivate: isprivate,
        verify: verify,
        isBlocked: isBlocked,
        loginType: loginType);
  }
}
