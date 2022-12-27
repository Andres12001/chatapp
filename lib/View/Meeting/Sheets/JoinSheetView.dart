import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Helpers/ListenedValues.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/Meeting/JoinSheetVM.dart';
import 'JoinSheetContent.dart';
import '../../Auth/Widgets/WelcomeHeader.dart';

class JoinSheetView extends StatelessWidget {
  JoinSheetView({super.key});
  static const String screenRouteName = "/JoinSheet";

  final JoinSheetVM _joinSheetVM = JoinSheetVM();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          "Metix",
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
                      title: 'Join Meeting',
                      fontSize: 50,
                    ),
                    JoinSheetContent(joinSheetVM: _joinSheetVM)
                    //overlay container
                  ]),
                ),
              ]),
        ),
      ),
    );
  }
}
