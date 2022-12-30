import 'package:flutter/material.dart';

import '../../../common/extension/context_extension.dart';
import '../../../common/extension/double_extension.dart';
import '../../../common/extension/timestamp_extension.dart';
import '../../../model/month_model.dart';
import '../monthly_summary/monthly_summary_screen.dart';

class MonthlyExpensesScreenListItemWidget extends StatelessWidget {
  const MonthlyExpensesScreenListItemWidget({super.key, required this.item});

  final MonthModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(MonthlySummaryScreen(date: item.date)),
      child: Card(
        margin: 16.0.spacingAll().copyWith(top: 0.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: 12.0.circular()),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.blue,
              padding: [8.0, 16.0].spacingSymmetric(),
              child: Text(
                item.date.toYearMonth(),
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            Container(
              width: double.infinity,
              padding: 16.0.spacingAll(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My expenses is:   ${item.getMyExpenses}'),
                  Text('Bee expenses is:   ${item.getBeeExpenses}'),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'ProductSan',
                      ),
                      children: [
                        const TextSpan(text: 'Total expense is:   '),
                        TextSpan(
                          text: item.getTotalMonthlyExpenses,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
