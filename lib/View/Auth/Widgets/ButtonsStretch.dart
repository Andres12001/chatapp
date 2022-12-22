import 'package:flutter/material.dart';

class ButtonsStretch extends StatelessWidget {
  const ButtonsStretch(
      {super.key,
      required this.text,
      required this.bgColor,
      required this.txtColor,
      required this.onPress,
      required this.icon});

  final String text;
  final Color bgColor;
  final Color txtColor;
  final VoidCallback onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 7,
          color: bgColor,
          child: ListTile(
            title: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: txtColor,
              ),
            ),
            leading: Icon(
              icon,
              size: 25,
              color: txtColor,
            ),
          ),
        ));
  }
}
