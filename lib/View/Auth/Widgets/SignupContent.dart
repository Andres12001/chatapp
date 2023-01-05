import 'package:easy_localization/easy_localization.dart';
import 'package:first_app/ViewModel/Auth/SignupVM.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:io';
import '../../../../Constants/Constants.dart';
import '../Sheets/TermsSheetView.dart';
import 'AvatarCustom.dart';
import 'ButtonOriginal.dart';
import 'TextFieldWidget.dart';

class SignupContent extends StatefulWidget {
  const SignupContent({super.key, required this.signupVM});

  final SignupVM signupVM;

  @override
  State<SignupContent> createState() => _SignupContentState();
}

class _SignupContentState extends State<SignupContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //  margin: EdgeInsets.only(top: size.height * 0.09),
      decoration: const BoxDecoration(
        color: kBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Spacer(),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: AvatarCustom(
                    isLocal: true,
                    url: widget.signupVM.imageFinal?.path,
                    name:
                        "${widget.signupVM.nameFController.text} ${widget.signupVM.nameLController.text}",
                    onPress: () => getImage(
                        ImgSource.Both,
                        context,
                        (imagePicked) => {
                              setState(() {
                                widget.signupVM.imageFinal = imagePicked;
                              })
                            }),
                    radius: 150,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        hint: "f_name".tr(),
                        limitTextCount: 15,
                        keyboardType: TextInputType.name,
                        onChange: (changedValue) => {
                          widget.signupVM.fieldUpdate(
                              changedValue,
                              widget.signupVM.nameFController,
                              (newValue) => {setState(() {})})
                        },
                        isObscureText: false,
                        controller: widget.signupVM.nameFController,
                      ),
                    ),
                    Expanded(
                      child: TextFieldWidget(
                        hint: "l_name".tr(),
                        limitTextCount: 15,
                        keyboardType: TextInputType.name,
                        onChange: (changedValue) => {
                          widget.signupVM.fieldUpdate(
                              changedValue,
                              widget.signupVM.nameLController,
                              (newValue) => {setState(() {})})
                        },
                        isObscureText: false,
                        controller: widget.signupVM.nameLController,
                      ),
                    )
                  ],
                ),
                TextFieldWidget(
                  hint: "example@example.com",
                  keyboardType: TextInputType.emailAddress,
                  onChange: (changedValue) => {
                    widget.signupVM.fieldUpdate(changedValue,
                        widget.signupVM.emailController, (newValue) => {})
                  },
                  isObscureText: false,
                  controller: widget.signupVM.emailController,
                ),
                TextFieldWidget(
                  hint: "pass_hint".tr(),
                  keyboardType: TextInputType.text,
                  onChange: (changedValue) => {
                    widget.signupVM.fieldUpdate(changedValue,
                        widget.signupVM.passwordController, (newValue) => {})
                  },
                  isObscureText: true,
                  controller: widget.signupVM.passwordController,
                ),
                ButtonOriginal(
                  text: "signup".tr(),
                  bgColor: kPrimaryColor,
                  txtColor: Colors.white,
                  onPress: () => widget.signupVM.signUpPre(
                      context: context,
                      email: widget.signupVM.emailController.text,
                      password: widget.signupVM.passwordController.text,
                      nameF: widget.signupVM.nameFController.text,
                      nameL: widget.signupVM.nameLController.text),
                  icon: Icons.person_add,
                  width: 200,
                ),
              ],
            ),

            // const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => widget.signupVM.goToLogin(context),
                child: Text(
                  "alrdy_mem".tr(),
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 17,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),

            // const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    expand: true,
                    builder: (context) => TermsSheetView(),
                  );
                },
                child: Text(
                  "trms".tr(),
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    color: kSecondaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Future getImage(
      ImgSource source, BuildContext context, Function(dynamic) finish) async {
    var image = await ImagePickerGC.pickImage(
        enableCloseButton: true,
        imageQuality: 40,
        closeIcon: const Icon(
          Icons.close,
          color: Colors.red,
          size: 12,
        ),
        context: context,
        source: source,
        barrierDismissible: true,
        galleryIcon: const Icon(
          Icons.photo,
          color: kPrimaryColor,
        ),
        cameraIcon: const Icon(
          Icons.camera_alt,
          color: Colors.red,
        ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
        cameraText: Text(
          "frm_cam".tr(),
          style: TextStyle(color: Colors.red),
        ),
        galleryText: Text(
          "frm_galry".tr(),
          style: TextStyle(color: kPrimaryColor),
        ));
    finish(image);
  }
}
