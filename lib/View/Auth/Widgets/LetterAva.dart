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
  Color bgColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    bgColor = getColor(name);
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

  Color getColor(String name) {
    if (avaConstMap[name] is Color) {
      return avaConstMap[name] as Color;
    } else {
      avaConstMap[name] = (avaColors..shuffle()).first;
      return avaConstMap[name] as Color;
    }
  }
}
