import 'package:flutter/material.dart';

import '../../../common/extension/double_extension.dart';
import '../../../model/monthly_summary.dart';

class MonthlySummaryScreenListItemWidget extends StatelessWidget {
  const MonthlySummaryScreenListItemWidget({super.key, required this.item});

  final MonthlySummary item;

  @override
  Widget build(BuildContext context) {
    return Card(
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
              item.day.getSummaryTotalExpenses,
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
          Container(
            width: double.infinity,
            padding: 16.0.spacingAll(),
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
