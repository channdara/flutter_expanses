import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/model/month_model.dart';
import 'package:flutter/material.dart';

class MonthlyExpensesListItemWidget extends StatelessWidget {
  const MonthlyExpensesListItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final MonthModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.keyboard_double_arrow_right,
        color: Colors.red,
      ),
      title: Text(
        item.date.toYearMonth(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(item.getMyExpenses),
          Text(item.getBeeExpenses),
          Text(item.getTotalMonthlyExpenses),
        ],
      ),
    );
  }
}
