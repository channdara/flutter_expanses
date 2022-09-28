import 'package:flutter/material.dart';

import '../../../common/extension/double_extension.dart';
import '../../../model/monthly_summary.dart';

class MonthlySummaryListItemWidget extends StatelessWidget {
  const MonthlySummaryListItemWidget({super.key, required this.item});

  final MonthlySummary item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.0.spacingBottom(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.day.getSummaryTotalExpenses,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4.0),
          Padding(
            padding: 16.0.spacingLeft(),
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
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              item.content,
                              style: TextStyle(
                                fontSize: 12.0,
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
