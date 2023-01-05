import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Helpers/ListenedValues.dart';
import 'package:first_app/View/Meeting/Sheets/CreateSheetContent.dart';
import 'package:first_app/View/Meeting/Sheets/ScheduleSheetContent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../Ads/AdmobClass.dart';
import '../../../Helpers/FirebaseMethods.dart';
import '../../../ViewModel/Meeting/ScheduleSheetVM.dart';
import '../../Auth/Screens/WelcomeView.dart';
import '../../Auth/Widgets/WelcomeHeader.dart';

class ScheduleMeetingView extends StatelessWidget {
  ScheduleMeetingView({super.key});
  static const String screenRouteName = "/ScheduleSheet";

  final ScheduleSheetVM _scheduleSheetVM = ScheduleSheetVM();

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
      body: BlurryModalProgressHUD(
        inAsyncCall: Provider.of<ListenedValues>(context).isLoading,
        blurEffectIntensity: 4,
        progressIndicator:
            const CircularProgressIndicator(color: kPrimaryColor),
        dismissible: false,
        opacity: 0.4,
        color: Colors.black87,
        child: SafeArea(
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
                      title: 'schd_meet'.tr(),
                      fontSize: 40,
                    ),
                    ScheduleMeetingContent(scheduleSheetVM: _scheduleSheetVM),
                    AdmobClass.shared.displayAdBanner()

                    //overlay container
                  ]),
                ),
              ]),
        ),
      ),
    );
  }
}
