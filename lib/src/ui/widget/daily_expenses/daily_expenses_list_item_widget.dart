import 'package:flutter/material.dart';

import '../../../common/extension/context_extension.dart';
import '../../../common/extension/timestamp_extension.dart';
import '../../../model/day_model.dart';
import '../../screen/purchased_items_screen.dart';

class DailyExpensesListItemWidget extends StatelessWidget {
  const DailyExpensesListItemWidget({
    super.key,
    required this.item,
  });

  final DayModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.circle,
        size: 20.0,
        color: item.date.isToday ? Colors.green : Colors.pinkAccent,
      ),
      title: Text(
        item.date.toYearMonthDay(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        item.getTotalDailyExpenses,
        style: const TextStyle(fontSize: 12.0),
      ),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () =>
          context.push(PurchasedItemsScreen(docId: item.date.getDay())),
    );
  }
}
