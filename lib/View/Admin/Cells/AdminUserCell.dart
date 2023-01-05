// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/Helpers/DateFormater.dart';
import 'package:first_app/Models/Meeting.dart';
import 'package:first_app/Models/MeetingHistory.dart';
import 'package:first_app/View/Auth/Widgets/AvatarCustom.dart';
import 'package:first_app/View/Auth/Widgets/ButtonOriginal.dart';
import 'package:first_app/ViewModel/Admin/AdminVM.dart';
import 'package:first_app/ViewModel/Meeting/MeetingVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import '../../../Constants/Constants.dart';
import '../../../Models/User.dart';

class AdminUserCell extends StatelessWidget {
  const AdminUserCell({super.key, required this.user, required this.adminVM});

  final User user;
  final AdminVM adminVM;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: SizedBox(
          // width: width,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            elevation: 7,
            color: kBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AvatarCustom(
                            name: "${user.nameF} ${user.nameL}",
                            onPress: () {},
                            url: user.ava,
                            isLocal: false,
                            radius: 30),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${user.nameF} ${user.nameL}",
                          maxLines: 1,
                          style: TextStyle(
                              color: kLabelColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        user.isBlocked
                            ? Text(
                                "usr_blc".tr(),
                                maxLines: 1,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 14),
                              )
                            : Container(),
                        user.isAdmin
                            ? Text(
                                "admin".tr(),
                                maxLines: 1,
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 14),
                              )
                            : Container(),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            adminVM.makeUserAdmin(
                                context, user.id, user.isAdmin);
                          },
                          child: Icon(
                            user.isAdmin
                                ? Icons.person
                                : Icons.admin_panel_settings,
                            size: 25,
                            color: kPrimaryColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            adminVM.blockUser(context, user.id, user.isBlocked);
                          },
                          child: Icon(
                            user.isBlocked ? Icons.undo : Icons.block,
                            size: 25,
                            color: Colors.red,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            adminVM.deleteUser(context, user.id);
                          },
                          child: Icon(
                            Icons.delete,
                            size: 25,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ));
  }
}
