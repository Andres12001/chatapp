import 'package:first_app/View/Meeting/Sheets/CreateSheetView.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../Constants/Constants.dart';
import '../../Meeting/Sheets/JoinSheetView.dart';
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
                text: "Join Meeting",
                txtColor: kPrimaryColor,
                onPress: (() {
                  showCupertinoModalBottomSheet(
                    context: context,
                    expand: true,
                    builder: (context) => JoinSheetView(),
                  );
                })),
            HomeMainButton(
                bgColor: Colors.white,
                icon: Icons.add_circle,
                text: "Create Meeting",
                txtColor: kPrimaryColor,
                onPress: (() {
                  showCupertinoModalBottomSheet(
                    context: context,
                    expand: true,
                    builder: (context) => CreateSheetView(),
                  );
                })),
            HomeMainButton(
                bgColor: Colors.white,
                icon: Icons.calendar_month,
                text: "Schedule meeting",
                txtColor: kPrimaryColor,
                onPress: (() {}))
          ],
        ),
      ),
    );
  }
}
