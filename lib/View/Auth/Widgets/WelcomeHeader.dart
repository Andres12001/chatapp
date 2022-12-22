import 'package:first_app/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key, required this.size, required this.title});
  final Size size;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.21,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100), bottomRight: Radius.circular(0)),
        color: kPrimaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          //Lobster font
          child: Text(
            title,
            style: GoogleFonts.lobster(
                textStyle: const TextStyle(color: Colors.white, fontSize: 60)),
          ),
        ),
      ),
    );
  }
}
