import 'package:flutter/material.dart';

import '../../../../Constants/Constants.dart';

class LetterAva extends StatelessWidget {
  LetterAva({
    Key? key,
    required this.radius,
    required this.name,
  }) : super(key: key);

  final double radius;
  final String name;
  Color bgColor = (avaColors..shuffle()).first;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(radius / 2)),
        child: Center(
            child: Text(
          getText(name),
          style: TextStyle(
              color: Colors.white,
              fontSize: radius / 3,
              fontWeight: FontWeight.w500),
        )));
  }

  String getText(String name) {
    final nameTemp = name.toUpperCase().trim().split(" ");
    var txtF = '';
    for (var word in nameTemp) {
      txtF += word.isNotEmpty ? word[0] : "";
    }

    return txtF.isEmpty ? "^  ^" : txtF;
  }
}
