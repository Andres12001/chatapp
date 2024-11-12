import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/Helpers/ListenedValues.dart';
import 'package:first_app/View/Admin/Widgets/AdminLists.dart';
import 'package:first_app/ViewModel/Admin/AdminVM.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../Constants/Constants.dart';
import '../../../Helpers/FirebaseMethods.dart';
import '../../Auth/Screens/WelcomeView.dart';
import '../../Home/Widgets/HomeArc.dart';
import '../Widgets/AdminRow.dart';

class AdminView extends StatelessWidget {
  AdminView({super.key});
  static const String screenRouteName = "/Admin";

  final AdminVM _adminVM = AdminVM();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _adminVM.getAllMeetings(context);
      _adminVM.getAllUsers(context);
    });

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          title: Text(
            "app_admin_name".tr(),
            style: GoogleFonts.lobster(
                textStyle: const TextStyle(color: Colors.white)),
          ),
        ),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            color: kBackgroundColor,
            child: Column(children: [
              //main container
              HomeArc(
                  kCurveHeight: 60,
                  kViewHeight: 200,
                  contentWidget: AdminRow()),
              const SizedBox(
                height: 10,
              ),
              AdminLists(adminVM: _adminVM)
            ]),
          ),
        ));
  }
}
