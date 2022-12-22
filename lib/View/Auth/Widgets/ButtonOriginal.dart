import 'package:flutter/material.dart';

class ButtonOriginal extends StatelessWidget {
  const ButtonOriginal(
      {super.key,
      required this.text,
      required this.bgColor,
      required this.txtColor,
      required this.onPress,
      required this.icon,
      required this.width});

  final String text;
  final Color bgColor;
  final Color txtColor;
  final VoidCallback onPress;
  final IconData icon;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
          onTap: onPress,
          child: SizedBox(
            width: width,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 7,
              color: bgColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 25,
                      color: txtColor,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: txtColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
