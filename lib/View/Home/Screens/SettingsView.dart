// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/Constants/Constants.dart';
import 'package:first_app/View/Auth/Sheets/PolicySheetView.dart';
import 'package:first_app/ViewModel/Home/SettingsVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:universal_html/js.dart';

import '../../../Ads/AdmobClass.dart';
import '../../../Helpers/FirebaseMethods.dart';
import '../../../Helpers/ListenedValues.dart';
import '../../Auth/Screens/WelcomeView.dart';
import '../../Auth/Sheets/TermsSheetView.dart';
import '../../Auth/Widgets/ButtonOriginal.dart';
import '../Widgets/ProfileCard.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  static const String screenRouteName = "/Settings";

  final SettingsVM _settingsVM = SettingsVM();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: kSecBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(3, 5, 3, 20),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "settings".tr(),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 40,
                          color: kLabelColor,
                          fontWeight: FontWeight.w900),
                    ),
                    Spacer()
                  ],
                ),
              ),
              ProfileCard(
                user: Provider.of<ListenedValues>(context).myUser,
                settingsVM: _settingsVM,
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        ListTile(
                          leading: Icon(SFSymbols.doc_plaintext),
                          title: Text('priv_plcy'.tr()),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: (() {
                            showCupertinoModalBottomSheet(
                              context: context,
                              expand: true,
                              builder: (context) => PolicySheetView(),
                            );
                          }),
                        ),
                        ListTile(
                          leading: Icon(SFSymbols.doc_plaintext),
                          title: Text('trms'.tr()),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: (() {
                            showCupertinoModalBottomSheet(
                              context: context,
                              expand: true,
                              builder: (context) => TermsSheetView(),
                            );
                          }),
                        ),
                        ListTile(
                          leading: Icon(SFSymbols.info_circle_fill),
                          title: Text('abt_us'.tr()),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.info,
                              title: 'abt_us'.tr(),
                              text: "abt_desc".tr(),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(SFSymbols.info),
                          title: Text('app_ver'.tr()),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.info,
                              title: 'app_ver'.tr(),
                              text: "app_ver_desc".tr(),
                            );
                          },
                        ),
                      ],
                    ).toList(),
                  ),
                ),
              ),
              ButtonOriginal(
                  text: "signout".tr(),
                  bgColor: kBackgroundColor,
                  txtColor: kPrimaryColor,
                  onPress: () => _settingsVM.signout(context),
                  icon: Icons.logout,
                  width: double.infinity),
              AdmobClass.shared.displayAdBanner()
            ],
          ),
        ),
      ),
    );
  }
}
