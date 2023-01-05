import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/Helpers/ListenedValues.dart';
import 'package:first_app/View/Meeting/Sheets/CreateSheetView.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../Constants/Constants.dart';
import '../../Home/Widgets/HomeMainButton.dart';
import '../../Meeting/Sheets/JoinSheetView.dart';
import '../../Meeting/Sheets/ScheduleSheetView.dart';

class AdminRow extends StatelessWidget {
  const AdminRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMainButton(
                bgColor:
                    Provider.of<ListenedValues>(context).currentAdminIndex == 0
                        ? kSecondaryColor
                        : Colors.white,
                icon: Icons.group,
                text: "all_usrs".tr(),
                txtColor:
                    Provider.of<ListenedValues>(context).currentAdminIndex == 0
                        ? Colors.white
                        : kPrimaryColor,
                onPress: (() {
                  Provider.of<ListenedValues>(context, listen: false)
                      .setAdminIndex(0);
                })),
            HomeMainButton(
                bgColor:
                    Provider.of<ListenedValues>(context).currentAdminIndex == 1
                        ? kSecondaryColor
                        : Colors.white,
                icon: Icons.workspaces,
                text: "all_mtings".tr(),
                txtColor:
                    Provider.of<ListenedValues>(context).currentAdminIndex == 1
                        ? Colors.white
                        : kPrimaryColor,
                onPress: (() {
                  Provider.of<ListenedValues>(context, listen: false)
                      .setAdminIndex(1);
                })),
          ],
        ),
      ),
    );
  }
}
