// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/View/Auth/Widgets/AvatarCustom.dart';
import 'package:flutter/material.dart';

import 'package:first_app/Models/User.dart' as dbUser;
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

import '../../../Constants/Constants.dart';
import '../../../Helpers/FirebaseAuthMethods.dart';
import '../../../ViewModel/Home/SettingsVM.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.user, required this.settingsVM});
  final dbUser.User? user;
  final SettingsVM settingsVM;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: width,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 7,
        color: kBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              //  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvatarCustom(
                    name: "${user?.nameF ?? ""} ${user?.nameL ?? ""}",
                    url: FirebaseAuthMethods.getMyPhoto(),
                    onPress: () =>
                        getImage(ImgSource.Both, context, (imagePicked) {
                          settingsVM.imageFinal = imagePicked;
                          settingsVM.uploadAva(context);
                        }),
                    isLocal: false,
                    radius: 70),
                SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "${user?.nameF ?? ""} ${user?.nameL ?? ""}",
                      maxLines: 1,
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      user?.loginInfo ?? "",
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }

  Future getImage(
      ImgSource source, BuildContext context, Function(dynamic) finish) async {
    var image = await ImagePickerGC.pickImage(
        enableCloseButton: true,
        imageQuality: 40,
        closeIcon: const Icon(
          Icons.close,
          color: Colors.red,
          size: 12,
        ),
        context: context,
        source: source,
        barrierDismissible: true,
        galleryIcon: const Icon(
          Icons.photo,
          color: kPrimaryColor,
        ),
        cameraIcon: const Icon(
          Icons.camera_alt,
          color: Colors.red,
        ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
        cameraText: Text(
          "frm_cam".tr(),
          style: TextStyle(color: Colors.red),
        ),
        galleryText: Text(
          "frm_galry".tr(),
          style: TextStyle(color: kPrimaryColor),
        ));
    finish(image);
  }
}
