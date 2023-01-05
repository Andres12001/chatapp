import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Ads/AdmobClass.dart';
import '../Widgets/WelcomeHeader.dart';

class PolicySheetView extends StatelessWidget {
  PolicySheetView({super.key});
  static const String screenRouteName = "/Policy";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          "app_name".tr(),
          style: GoogleFonts.lobster(
              textStyle: const TextStyle(color: Colors.white)),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(children: [
                  //main container
                  WelcomeHeader(
                    size: size,
                    title: 'priv_plcy'.tr(),
                    fontSize: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("lorem".tr()),
                  )
                  // JoinSheetContent(joinSheetVM: _joinSheetVM)
                  //overlay container
                  ,
                  AdmobClass.shared.displayAdBanner()
                ]),
              ),
            ]),
      ),
    );
  }
}
