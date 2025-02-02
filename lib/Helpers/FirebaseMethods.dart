import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/Constants/FirebaseConst.dart';

String? myId = FirebaseAuth.instance.currentUser?.uid;

class FirebaseMethods {
  //Database

  static Map<String, StreamSubscription<DatabaseEvent>?> listnersMap = {};
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

    await ref.child(childPath).update(map).then((value) {
      onSucc();
    }).catchError((onError) {
      onFailed(onError.toString());
    });
  }

  void setValueInFirebase(
      {required String childPath,
      required dynamic value,
      required Function onSucc,
      required Function(dynamic) onFailed}) async {
    if (myId == null) {
      return;
    }

    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.child(childPath).set(value).then((value) {
      onSucc();
    }).catchError((onError) {
      onFailed(onError.toString());
    });
  }

  //single listner on databaseR
  void getSingleDataFromFirebase(
      {required String childPath,
      required Function(DataSnapshot snapshot) onSucc,
      required Function(dynamic) onFailed}) async {
    if (myId == null) {
      return;
    }

    DatabaseReference ref = FirebaseDatabase.instance.ref();

    await ref.child(childPath).get().then((value) {
      onSucc(value);
    }).catchError((onError) {
      onFailed(onError);
    });
  }

//event listner on databse
  void getListnerOnData(
      {required String childPath,
      required Function(dynamic snapshot) onSucc,
      required String listnerMapkey,
      required Function(dynamic) onFailed}) async {
    if (myId == null) {
      return;
    }

    DatabaseReference ref = FirebaseDatabase.instance.ref();
    try {
      var stream = ref.child(childPath).onValue.listen(
        (event) {
          onSucc(event.snapshot);
        },
      );
      FirebaseMethods.listnersMap[listnerMapkey] = stream;
    } catch (e) {
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
      onSucc(url);
    } on FirebaseException catch (e) {
      onFailed(e);
    }
  }
}
