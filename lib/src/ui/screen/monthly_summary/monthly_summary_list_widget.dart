import 'package:flutter/material.dart';

import '../../../common/extension/double_extension.dart';
import '../../../model/monthly_summary.dart';
import 'monthly_summary_list_item_widget.dart';

class MonthlySummaryListWidget extends StatelessWidget {
  const MonthlySummaryListWidget({super.key, required this.docs});

  final List<MonthlySummary> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: 8.0.spacingVertical(),
      itemCount: docs.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = docs[index];
        if (item == null) return const SizedBox();
        return MonthlySummaryListItemWidget(item: item);
      },
    );
  }
}
