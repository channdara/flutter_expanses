import 'package:flutter/material.dart';

import '../../../common/extension/double_extension.dart';
import '../../../model/month_model.dart';
import 'monthly_expenses_list_item_widget.dart';

class MonthlyExpensesListWidget extends StatelessWidget {
  const MonthlyExpensesListWidget({super.key, required this.docs});

  final List<MonthModel> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: 8.0.spacingVertical(),
      itemCount: docs.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = docs[index];
        if (item == null) return const SizedBox();
        return MonthlyExpensesListItemWidget(item: item);
      },
    );
  }
}
