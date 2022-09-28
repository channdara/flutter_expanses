import 'package:flutter/material.dart';

import '../../../common/extension/double_extension.dart';
import '../../../model/day_model.dart';
import '../../screen/daily_expanses/daily_expenses_list_item_widget.dart';

class DailyExpensesListWidget extends StatelessWidget {
  const DailyExpensesListWidget({super.key, required this.docs});

  final List<DayModel> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: 70.0.spacingBottom(),
      itemCount: docs.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = docs[index];
        if (item == null) return const SizedBox();
        return DailyExpensesListItemWidget(item: item);
      },
    );
  }
}
