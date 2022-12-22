import 'package:first_app/ViewModel/Auth/SignupVM.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'dart:io';
import '../../../../Constants/Constants.dart';
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
                    onPress: () => widget.signupVM.getImage(
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
                        hint: "First Name",
                        keyboardType: TextInputType.emailAddress,
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
                        hint: "Last Name",
                        keyboardType: TextInputType.emailAddress,
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
                  hint: "Password at least 6 characters",
                  keyboardType: TextInputType.emailAddress,
                  onChange: (changedValue) => {
                    widget.signupVM.fieldUpdate(changedValue,
                        widget.signupVM.passwordController, (newValue) => {})
                  },
                  isObscureText: true,
                  controller: widget.signupVM.passwordController,
                ),
                ButtonOriginal(
                  text: "Signup",
                  bgColor: kPrimaryColor,
                  txtColor: Colors.white,
                  onPress: () => widget.signupVM.signupUsingEmailPassword(
                      context: context,
                      email: "test2@test.com",
                      password: "123456"),
                  icon: Icons.person_add,
                  width: 200,
                ),
                // widget.signupVM.imageFinal != null
                //     ? Image.file(File(widget.signupVM.imageFinal.path))
                //     : Container(),
              ],
            ),

            // const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => widget.signupVM.goToLogin(context),
                child: const Text(
                  "Already a member? Login now",
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
                onTap: () => {},
                child: const Text(
                  "Terms and conditions",
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
}
