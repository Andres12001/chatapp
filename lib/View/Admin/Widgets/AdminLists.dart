// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/View/Admin/Cells/AdminMeetingCell.dart';
import 'package:first_app/View/Admin/Cells/AdminUserCell.dart';
import 'package:first_app/ViewModel/Admin/AdminVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Helpers/ListenedValues.dart';

class AdminLists extends StatelessWidget {
  AdminLists({super.key, required this.adminVM});

  final AdminVM adminVM;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: kSecBackgroundColor, width: 1),
            borderRadius: BorderRadius.circular(20),
            color: kBackgroundColor),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: kSecBackgroundColor),
            child: Row(
              children: [
                Spacer(),
                Text(
                  Provider.of<ListenedValues>(context).currentAdminIndex == 0
                      ? "all_usrs".tr() +
                          " (${Provider.of<ListenedValues>(context).adminUsersList.length})"
                      : "all_mtings".tr() +
                          " (${Provider.of<ListenedValues>(context).adminMeetingList.length})",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Provider.of<ListenedValues>(context, listen: false)
                                  .currentAdminIndex ==
                              0
                          ? adminVM.getAllUsers(context)
                          : adminVM.getAllMeetings(context);
                    },
                    child: Icon(
                      Icons.refresh,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: Provider.of<ListenedValues>(context).currentAdminIndex ==
                    0
                ? Provider.of<ListenedValues>(context).adminUsersList.length
                : Provider.of<ListenedValues>(context).adminMeetingList.length,
            itemBuilder: (context, index) {
              if (Provider.of<ListenedValues>(context).currentAdminIndex == 0) {
                return AdminUserCell(
                    user: Provider.of<ListenedValues>(context)
                        .adminUsersList[index],
                    adminVM: adminVM);
              } else {
                return AdminMeetingCell(
                  historyItem: Provider.of<ListenedValues>(context)
                      .adminMeetingList[index],
                  adminVM: adminVM,
                );
              }
            },
          )
        ]),
      ),
    );
  }
}
