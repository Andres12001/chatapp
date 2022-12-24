import 'package:first_app/View/Home/Widgets/HomeArc.dart';
import 'package:first_app/ViewModel/Home/HomeVM.dart';
import 'package:flutter/material.dart';

import '../../../Constants/Constants.dart';
import '../../Auth/Widgets/ButtonOriginal.dart';
import 'HomeRow.dart';

class HomeContent extends StatelessWidget {
  const HomeContent(
      {super.key, required this.homeVM, required this.scrollController});

  final HomeVM homeVM;
  final ScrollController scrollController;
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
                  Text("hello"),
                  ButtonOriginal(
                      text: "signout",
                      bgColor: kPrimaryColor,
                      txtColor: Colors.white,
                      onPress: () => homeVM.signout(context),
                      icon: Icons.person,
                      width: 200),
                  // HomeHeader(
                  //   size: size,
                  //   title: 'Login',
                  // ),
                  //LoginContent(loginVM: _loginVM)
                  //overlay container
                ]),
              ),
            ),
          ),
        ]);
  }
}
