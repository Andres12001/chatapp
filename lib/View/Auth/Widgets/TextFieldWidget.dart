import 'package:first_app/Constants/Constants.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      required this.hint,
      required this.keyboardType,
      required this.onChange,
      this.limitTextCount = 0,
      required this.isObscureText,
      required this.controller});
  final String hint;
  final TextInputType keyboardType;
  final Function(String) onChange;
  final bool isObscureText;
  final TextEditingController controller;
  final int limitTextCount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: kBackgroundColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              maxLength:
                  limitTextCount > 0 ? limitTextCount : TextField.noMaxLength,
              autofocus: true,
              textAlign: TextAlign.start,
              maxLines: 1,
              controller: controller,
              obscureText: isObscureText,
              keyboardType: keyboardType,
              onChanged: (value) => onChange(value),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: hint, counterText: ''),
            ),
          ),
        ),
      ),
    );
  }
}
