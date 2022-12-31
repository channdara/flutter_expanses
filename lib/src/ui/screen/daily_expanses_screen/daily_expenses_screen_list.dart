import 'package:flutter/material.dart';

import '../../../model/item_model.dart';
import 'daily_expenses_screen_list_item.dart';

class DailyExpensesScreenList extends StatelessWidget {
  const DailyExpensesScreenList({super.key, required this.docs});

  final List<ItemModel> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 70.0),
      itemCount: docs.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = docs[index];
        if (item == null) return const SizedBox();
        return DailyExpensesScreenListItem(item: item);
      },
    );
  }
}
