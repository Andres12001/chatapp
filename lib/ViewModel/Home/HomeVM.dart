import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Helpers/ListenedValues.dart';

class HomeVM {
  void scrollAnimated(ScrollController scrollController, double position) {
    scrollController.animateTo(position,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void onTabTapped(int index, BuildContext context) {
    Provider.of<ListenedValues>(context, listen: false).setHomeIndex(index);
  }
}
