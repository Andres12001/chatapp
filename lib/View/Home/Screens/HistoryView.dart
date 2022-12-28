import 'package:first_app/Helpers/NavigationService.dart';
import 'package:first_app/View/Home/Cells/HistoryCell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constants/Constants.dart';
import '../../../Helpers/ListenedValues.dart';
import '../../../ViewModel/Home/HistoryVM.dart';
import '../../Auth/Widgets/ButtonOriginal.dart';

class HistoryView extends StatelessWidget {
  HistoryView({super.key, required this.historyVM});

  final HistoryVM historyVM;
  @override
  Widget build(BuildContext context) {
    //_historyVM.getHistory(context, false);
    return RefreshIndicator(
        onRefresh: _pullRefresh,
        child: ListView.builder(
          itemCount: Provider.of<ListenedValues>(context).historyList.length,
          itemBuilder: (context, index) {
            return HistoryCell(
              historyItem:
                  Provider.of<ListenedValues>(context).historyList[index],
              historyVM: historyVM,
            );
          },
        ));
  }

  Future<void> _pullRefresh() async {
    historyVM.getHistory(NavigationService.navigatorKey.currentContext!, true);
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
