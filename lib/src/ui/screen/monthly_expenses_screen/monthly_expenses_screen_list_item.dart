import 'package:flutter/material.dart';

import '../../../common/color_constant.dart';
import '../../../common/extension/context_extension.dart';
import '../../../common/extension/timestamp_extension.dart';
import '../../../model/month_model.dart';
import '../monthly_summary_screen/monthly_summary_screen.dart';

class MonthlyExpensesScreenListItem extends StatelessWidget {
  const MonthlyExpensesScreenListItem({super.key, required this.item});

  final MonthModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(MonthlySummaryScreen(date: item.date)),
      child: Card(
        margin: const EdgeInsets.all(16.0).copyWith(top: 0.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: ColorConstant.colorPrimary,
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Text(
                item.date.toYearMonth(),
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
