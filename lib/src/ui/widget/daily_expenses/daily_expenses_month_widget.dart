import 'package:flutter/material.dart';

import '../../../common/extension/context_extension.dart';
import '../../../common/extension/double_extension.dart';
import '../../../model/month_model.dart';
import '../../screen/monthly_expenses_screen.dart';

class DailyExpensesMonthWidget extends StatelessWidget {
  const DailyExpensesMonthWidget({super.key, required this.item});

  final MonthModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(MonthlyExpensesScreen(date: item.date)),
      child: Card(
        margin: 8.0.spacingAll(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: 12.0.circular()),
        child: Container(
          width: double.infinity,
          padding: 16.0.spacingAll(),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(item.getMyExpenses),
              Text(item.getBeeExpenses),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.topRight,
                child: Text(item.getTotalMonthlyExpenses),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
