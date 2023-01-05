import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/Ads/AdmobClass.dart';
import 'package:first_app/View/Meeting/Sheets/CreateSheetView.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../Constants/Constants.dart';
import '../../Meeting/Sheets/JoinSheetView.dart';
import '../../Meeting/Sheets/ScheduleSheetView.dart';
import 'HomeMainButton.dart';

class HomeRow extends StatelessWidget {
  const HomeRow({super.key, required this.scrollController});
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMainButton(
                bgColor: Colors.white,
                icon: Icons.join_full,
                text: "jin_meet".tr(),
                txtColor: kPrimaryColor,
                onPress: (() {
                  AdmobClass.shared.showInitAd();
                  Navigator.pushNamed(context, JoinMeetingView.screenRouteName);
                })),
            HomeMainButton(
                bgColor: Colors.white,
                icon: Icons.add_circle,
                text: "crt_meet".tr(),
                txtColor: kPrimaryColor,
                onPress: (() {
                  AdmobClass.shared.showInitAd();
                  Navigator.pushNamed(
                      context, CreateMeetingView.screenRouteName);
                })),
            HomeMainButton(
                bgColor: Colors.white,
                icon: Icons.alarm_add,
                text: "schd_meet".tr(),
                txtColor: kPrimaryColor,
                onPress: (() {
                  AdmobClass.shared.showInitAd();
                  Navigator.pushNamed(
                      context, ScheduleMeetingView.screenRouteName);
                }))
          ],
        ),
      ),
    );
  }
}
