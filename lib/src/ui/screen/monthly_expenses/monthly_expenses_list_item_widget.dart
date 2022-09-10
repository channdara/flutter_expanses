import 'package:flutter/material.dart';

import '../../../common/extension/timestamp_extension.dart';
import '../../../model/month_model.dart';

class MonthlyExpensesListItemWidget extends StatelessWidget {
  const MonthlyExpensesListItemWidget({super.key, required this.item});

  final MonthModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.keyboard_double_arrow_right,
        color: Colors.pink,
      ),
      title: Text(
        item.date.toYearMonth(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.getMyExpenses,
            style: const TextStyle(fontSize: 12.0),
          ),
          Text(
            item.getBeeExpenses,
            style: const TextStyle(fontSize: 12.0),
          ),
          Text(
            item.getTotalMonthlyExpenses,
            style: const TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
