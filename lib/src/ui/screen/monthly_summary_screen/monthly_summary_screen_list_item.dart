import 'package:flutter/material.dart';

import '../../../common/color_constant.dart';
import '../../../model/monthly_summary.dart';

class MonthlySummaryScreenListItem extends StatelessWidget {
  const MonthlySummaryScreenListItem({super.key, required this.item});

  final MonthlySummary item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0).copyWith(top: 0.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
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
              item.day.getSummaryTotalExpenses,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: item
                  .getItems()
                  .map((e) => Container(
                        decoration: BoxDecoration(
                          color: e.getDisplayTextColor(),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 12.0,
                        ),
                        child: Text(
                          e.content,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
