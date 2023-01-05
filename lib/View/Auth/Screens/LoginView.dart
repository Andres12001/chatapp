import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/Ads/AdmobClass.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Helpers/ListenedValues.dart';
import 'package:first_app/ViewModel/Auth/LoginVM.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../Helpers/FirebaseMethods.dart';
import '../../Home/Screens/HomeView.dart';
import '../Widgets/LoginContent.dart';
import '../Widgets/WelcomeHeader.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  static const String screenRouteName = "/Login";

  final LoginVM _loginVM = LoginVM();

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
                      title: 'login'.tr(),
                    ),
                    LoginContent(loginVM: _loginVM),
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
