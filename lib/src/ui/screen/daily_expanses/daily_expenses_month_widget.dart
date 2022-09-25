import 'package:flutter/material.dart';

import '../../../common/extension/context_extension.dart';
import '../../../common/extension/double_extension.dart';
import '../../../model/month_model.dart';
import '../../widget/card_widget.dart';
import '../monthly_expenses/monthly_expenses_screen.dart';

class DailyExpensesMonthWidget extends StatelessWidget {
  const DailyExpensesMonthWidget({super.key, required this.item});

  final MonthModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(MonthlyExpensesScreen(date: item.date)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: CardWidget(
                  margin: [8.0, 8.0, 0.0, 0.0].spacingLTRB(),
                  borderRadius: 12.0.radiusTopLeft(),
                  child: Container(
                    width: double.infinity,
                    padding: 16.0.spacingAll(),
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text(
                      item.getMyExpenses,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CardWidget(
                  margin: [0.0, 8.0, 8.0, 0.0].spacingLTRB(),
                  borderRadius: 12.0.radiusTopRight(),
                  child: Container(
                    width: double.infinity,
                    padding: 16.0.spacingAll(),
                    color: Colors.pinkAccent,
                    alignment: Alignment.center,
                    child: Text(
                      item.getBeeExpenses,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          CardWidget(
            margin: 8.0.spacingHorizontal(),
            borderRadius: 12.0.radiusBothBottom(),
            child: Container(
              width: double.infinity,
              padding: 16.0.spacingAll(),
              color: Colors.green,
              alignment: Alignment.center,
              child: Text(
                item.getTotalMonthlyExpenses,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
