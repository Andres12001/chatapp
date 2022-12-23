import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthMethods {
// Email Auth
//Login

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
}
