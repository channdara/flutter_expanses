import 'package:flutter/material.dart';

import '../../../common/extension/context_extension.dart';
import '../../../common/extension/double_extension.dart';
import '../../../model/month_model.dart';
import '../monthly_expenses/monthly_expenses_screen.dart';

class DailyExpensesScreenSummaryWidget extends StatelessWidget {
  const DailyExpensesScreenSummaryWidget({super.key, required this.item});

  final MonthModel? item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item == null) return;
        context.push(MonthlyExpensesScreen(date: item!.date));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: 16.0.spacingAll(),
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text(
                    item?.getMyExpenses ?? '...',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: 16.0.spacingAll(),
                  color: Colors.pinkAccent,
                  alignment: Alignment.center,
                  child: Text(
                    item?.getBeeExpenses ?? '...',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: 16.0.spacingAll(),
            color: Colors.green,
            alignment: Alignment.center,
            child: Text(
              item?.getTotalMonthlyExpenses ?? '...',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
