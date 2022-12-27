import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:developer';
import '../../../Constants/Constants.dart';
import '../../../Constants/TabbarConst.dart';
import '../../../ViewModel/Home/HomeVM.dart';
import '../../Auth/Sheets/JoinSheetView.dart';

class BottomBarView extends StatelessWidget {
  const BottomBarView({super.key, required this.homeVM});
  final HomeVM homeVM;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBottomNavigationBar(
          bottomBarItems: [
            BottomBarItemsModel(
              icon: const Icon(Icons.home, size: tabDimens.iconNormal),
              iconSelected: const Icon(Icons.home,
                  color: kPrimaryColor, size: tabDimens.iconNormal),
              dotColor: kPrimaryColor,
              onTap: () {
                homeVM.onTabTapped(0, context);
              },
            ),
            BottomBarItemsModel(
              icon: const Icon(Icons.history, size: tabDimens.iconNormal),
              iconSelected: const Icon(Icons.history,
                  color: kPrimaryColor, size: tabDimens.iconNormal),
              dotColor: kPrimaryColor,
              onTap: () {
                homeVM.onTabTapped(1, context);
              },
            ),
            BottomBarItemsModel(
              icon:
                  const Icon(Icons.calendar_month, size: tabDimens.iconNormal),
              iconSelected: const Icon(Icons.calendar_month,
                  color: kPrimaryColor, size: tabDimens.iconNormal),
              dotColor: kPrimaryColor,
              onTap: () {
                homeVM.onTabTapped(2, context);
              },
            ),
            BottomBarItemsModel(
                icon: const Icon(Icons.settings, size: tabDimens.iconNormal),
                iconSelected: const Icon(Icons.settings,
                    color: kPrimaryColor, size: tabDimens.iconNormal),
                dotColor: kPrimaryColor,
                onTap: () {
                  homeVM.onTabTapped(3, context);
                }),
          ],
          bottomBarCenterModel: BottomBarCenterModel(
            centerBackgroundColor: kPrimaryColor,
            centerIcon: const FloatingCenterButton(
              child: Icon(
                Icons.add,
                color: AppColors.white,
              ),
            ),
            centerIconChild: [
              FloatingCenterButtonChild(
                child: const Icon(
                  Icons.add_circle,
                  color: AppColors.white,
                ),
                onTap: () => log('Item1'),
              ),
              FloatingCenterButtonChild(
                child: const Icon(
                  Icons.join_full,
                  color: AppColors.white,
                ),
                onTap: () => showCupertinoModalBottomSheet(
                  context: context,
                  expand: true,
                  builder: (context) => JoinSheetView(),
                ),
              ),
              FloatingCenterButtonChild(
                  child: const Icon(
                    Icons.close,
                    color: AppColors.white,
                  ),
                  onTap: () => {}),
            ],
          ),
        ),
        SizedBox(
            height: 10,
            child: Container(
              color: kTabBGColor,
            ))
      ],
    );
  }
}
