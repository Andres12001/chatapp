import 'package:easy_localization/easy_localization.dart';

class FirebaseMessages {
  static String getMessageFromErrorCode(dynamic e) {
    switch (e.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "email-already-in-use".tr();
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "wrong-password".tr();
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "user-not-found".tr();
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "user-disabled".tr();
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "operation-not-allowed".tr();
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "operation-not-allowed".tr();
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "invalid-email".tr();
        break;
      default:
        return "login-failed".tr();
        break;
    }
  }
}
