import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/Helpers/ListenedValues.dart';
import 'package:first_app/View/Meeting/Sheets/CreateSheetContent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../ViewModel/Meeting/CreateSheetVM.dart';
import '../../Auth/Widgets/WelcomeHeader.dart';

class CreateSheetView extends StatelessWidget {
  CreateSheetView({super.key});
  static const String screenRouteName = "/CreateSheet";

  final CreateSheetVM _createSheetVM = CreateSheetVM();

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
                      title: 'Create Meeting',
                      fontSize: 50,
                    ),
                    CreateSheetContent(createSheetVM: _createSheetVM)
                    //overlay container
                  ]),
                ),
              ]),
        ),
      ),
    );
  }
}
