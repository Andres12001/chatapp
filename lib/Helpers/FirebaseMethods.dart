import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/Constants/FirebaseConst.dart';

String? myId = FirebaseAuth.instance.currentUser?.uid;

class FirebaseMethods {
  //Database

  //set data in database
  void setDataInFirebase(
      {required String childPath,
      required Map<String, dynamic> map,
      required Function onSucc,
      required Function(dynamic) onFailed}) async {
    if (myId == null) {
      return;
    }

    DatabaseReference ref = FirebaseDatabase.instance.ref();
    try {
      await ref.child(childPath).set(map);
      onSucc();
    } catch (e) {
      onFailed(e);
    }
  }

//Storage

//upload photo
  void uploadPhotoStorage(
      {required String childPath,
      required dynamic file,
      required Function(String) onSucc,
      required Function(dynamic) onFailed}) async {
    if (myId == null) {
      return;
    }
    final storageRef = FirebaseStorage.instance.ref();
    final newMetadata = SettableMetadata(
      contentType: "image/jpeg",
    );
    try {
      UploadTask uploadTask = storageRef
          .child(childPath + "/${myId!}.jpg")
          .putData(await file.readAsBytes(), newMetadata);

      String url = await (await uploadTask).ref.getDownloadURL();
      print(url);

      onSucc(url);
    } on FirebaseException catch (e) {
      onFailed(e);
    }
  }

//Online method
  static void onlineControl(bool online) {
    if (myId == null) {
      return;
    }

    DatabaseReference ref = FirebaseDatabase.instance.ref();
    Map<String, dynamic> map = {"online": online};

    if (!online) {
      map["lastTime"] = ServerValue.timestamp;
      map["typing"] = "";
    }
    ref.child(FirebaseConst.USERS).child(myId!).update(map);
  }

  static void goOfflineDisconnect() {
    if (myId == null) {
      return;
    }
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    Map<String, dynamic> map = {
      "online": false,
      "lastTime": ServerValue.timestamp,
      "typing": ""
    };
    ref.child(FirebaseConst.USERS).child(myId!).onDisconnect().update(map);
  }
}
