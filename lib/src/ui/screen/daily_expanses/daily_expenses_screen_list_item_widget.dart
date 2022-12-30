import 'package:flutter/material.dart';

import '../../../common/color_constant.dart';
import '../../../common/extension/context_extension.dart';
import '../../../common/extension/timestamp_extension.dart';
import '../../../model/day_model.dart';
import '../purchased_items/purchased_items_screen.dart';

class DailyExpensesScreenListItemWidget extends StatelessWidget {
  const DailyExpensesScreenListItemWidget({super.key, required this.item});

  final DayModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.circle,
        size: 20.0,
        color: ColorConstant.colorPrimary,
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
      onTap: () => context.push(PurchasedItemsScreen(date: item.date)),
    );
  }
}
