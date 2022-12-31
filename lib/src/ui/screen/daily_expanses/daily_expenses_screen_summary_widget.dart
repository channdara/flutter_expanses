import 'package:flutter/material.dart';

import '../../../common/extension/context_extension.dart';
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
      child: Card(
        margin: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: const [
                  Expanded(
                    child: Text(
                      'My expenses',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Bee expenses',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item?.getMyExpenses ?? '...',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      item?.getBeeExpenses ?? '...',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.pinkAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Total expenses for this month',
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
              Text(
                item?.getTotalMonthlyExpenses ?? '...',
                style: const TextStyle(color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
