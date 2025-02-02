import 'package:firebase_auth/firebase_auth.dart';

import 'FirebaseMethods.dart';

class FirebaseAuthMethods {
// Email Auth
//Login
  static String getMyPhoto() {
    if (myId == null) {
      return "";
    }

    return FirebaseAuth.instance.currentUser?.photoURL ?? "";
  }

  static String getMyname() {
    if (myId == null) {
      return "";
    }
    return FirebaseAuth.instance.currentUser?.displayName ?? "";
  }

  Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required Function(User?) onSucc,
      required Function(dynamic) onFailed}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      onSucc(user);
    } on FirebaseAuthException catch (e) {
      onFailed(e);
    }
    return user;
  }

//Signup
  Future<User?> signupUsingEmailPassword(
      {required String email,
      required String password,
      required Function(User?) onSucc,
      required Function(dynamic) onFailed}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      onSucc(user);
    } on FirebaseAuthException catch (e) {
      onFailed(e);
    }
    return user;
  }

  Future<User?> signInAnonymously(
      {required Function(User?) onSucc,
      required Function(dynamic) onFailed}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInAnonymously();
      user = userCredential.user;
      onSucc(user);
    } on FirebaseAuthException catch (e) {
      onFailed(e);
    }
    return user;
  }
}
