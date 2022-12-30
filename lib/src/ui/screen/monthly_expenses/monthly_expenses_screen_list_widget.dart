import 'package:flutter/material.dart';

import '../../../model/month_model.dart';
import 'monthly_expenses_screen_list_item_widget.dart';

class MonthlyExpensesScreenListWidget extends StatelessWidget {
  const MonthlyExpensesScreenListWidget({super.key, required this.docs});

  final List<MonthModel> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: docs.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = docs[index];
        if (item == null) return const SizedBox();
        return MonthlyExpensesScreenListItemWidget(item: item);
      },
    );
  }
}
