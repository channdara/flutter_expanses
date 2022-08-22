import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/model/day_model.dart';
import 'package:expenses/src/ui/screen/purchase_items_screen.dart';
import 'package:flutter/material.dart';

class DailyExpensesListItemWidget extends StatelessWidget {
  const DailyExpensesListItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final DayModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.circle,
        color: item.date.isToday ? Colors.green : Colors.red,
      ),
      title: Text(
        item.date.toYearMonthDay(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        item.getTotalDailyExpenses,
        style: const TextStyle(fontSize: 12.0),
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
        color: Colors.red,
      ),
      onTap: () => context.push(const PurchaseItemsScreen()),
    );
  }
}
