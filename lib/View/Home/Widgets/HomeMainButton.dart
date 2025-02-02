import 'package:flutter/material.dart';

class HomeMainButton extends StatelessWidget {
  const HomeMainButton({
    super.key,
    required this.text,
    required this.bgColor,
    required this.txtColor,
    required this.onPress,
    required this.icon,
  });

  final String text;
  final Color bgColor;
  final Color txtColor;
  final VoidCallback onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
          onTap: onPress,
          child: SizedBox(
            //width: width,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 7,
              color: bgColor,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 30,
                      color: txtColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
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
