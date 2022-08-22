import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/common/extension/double_extension.dart';
import 'package:expenses/src/model/month_model.dart';
import 'package:expenses/src/ui/screen/monthly_expenses_screen.dart';
import 'package:flutter/material.dart';

class DailyExpensesMonthWidget extends StatelessWidget {
  const DailyExpensesMonthWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final MonthModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(const MonthlyExpensesScreen()),
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
