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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: item
                  .getItems()
                  .map((item) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.subdirectory_arrow_right,
                            color: Colors.grey,
                            size: 16.0,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              item.content,
                              style: TextStyle(
                                color: item.getDisplayTextColor(),
                              ),
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
