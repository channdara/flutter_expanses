import 'package:flutter/material.dart';

import '../../../common/extension/double_extension.dart';
import '../../../model/monthly_summary.dart';

class MonthlySummaryListItemWidget extends StatelessWidget {
  const MonthlySummaryListItemWidget({super.key, required this.item});

  final MonthlySummary item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.arrow_circle_right_outlined,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        item.day.getSummaryTotalExpenses,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        children: item
            .getItems()
            .map((e) => Container(
                  padding: [2.0, 8.0].spacingSymmetric(),
                  decoration: BoxDecoration(
                    borderRadius: 12.0.circular(),
                    color: Colors.blue,
                  ),
                  child: Text(
                    e.content,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ))
            .toList(),
      ),
      onTap: () {},
    );
  }
}
