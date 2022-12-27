import 'package:first_app/View/Home/Widgets/HomeArc.dart';
import 'package:first_app/ViewModel/Home/HomeVM.dart';
import 'package:flutter/material.dart';
import '../../../Constants/Constants.dart';
import '../../../Models/Meeting.dart';
import '../../../ViewModel/Meeting/MeetingVM.dart';
import '../../Auth/Widgets/ButtonOriginal.dart';
import 'HomeRow.dart';

class HomeContent extends StatelessWidget {
  HomeContent(
      {super.key, required this.homeVM, required this.scrollController});

  final HomeVM homeVM;
  final ScrollController scrollController;
  final MeetingVM _meetingVM = MeetingVM.shared;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Expanded(
              child: Container(
                color: kBackgroundColor,
                child: Column(children: [
                  //main container
                  HomeArc(
                      kCurveHeight: 60,
                      kViewHeight: 200,
                      contentWidget: HomeRow(
                        scrollController: scrollController,
                      )),
                  ButtonOriginal(
                      text: "signout",
                      bgColor: kPrimaryColor,
                      txtColor: Colors.white,
                      onPress: () => homeVM.signout(context),
                      icon: Icons.person,
                      width: 200),
                ]),
              ),
            ),
          ),
        ]);
  }
}
