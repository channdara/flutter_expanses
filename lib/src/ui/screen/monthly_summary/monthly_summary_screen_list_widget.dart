import 'package:flutter/material.dart';

import '../../../model/monthly_summary.dart';
import 'monthly_summary_screen_list_item_widget.dart';

class MonthlySummaryScreenListWidget extends StatelessWidget {
  const MonthlySummaryScreenListWidget({super.key, required this.docs});

  final List<MonthlySummary> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: docs.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = docs[index];
        if (item == null) return const SizedBox();
        return MonthlySummaryScreenListItemWidget(item: item);
      },
    );
  }
}
