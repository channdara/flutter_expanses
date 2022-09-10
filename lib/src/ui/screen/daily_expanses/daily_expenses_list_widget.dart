import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../common/extension/double_extension.dart';
import '../../../model/day_model.dart';
import '../../screen/daily_expanses/daily_expenses_list_item_widget.dart';

class DailyExpensesListWidget extends StatelessWidget {
  const DailyExpensesListWidget({super.key, required this.docs});

  final List<QueryDocumentSnapshot> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: 70.0.spacingBottom(),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final data = docs[index].data();
        if (data == null) return const SizedBox();
        final item = DayModel.fromJson(data as Map<String, dynamic>);
        return DailyExpensesListItemWidget(item: item);
      },
    );
  }
}
