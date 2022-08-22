import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/double_extension.dart';
import 'package:expenses/src/model/day_model.dart';
import 'package:expenses/src/ui/widget/daily_expenses/daily_expenses_list_item_widget.dart';
import 'package:flutter/material.dart';

class DailyExpensesListWidget extends StatelessWidget {
  const DailyExpensesListWidget({
    Key? key,
    required this.docs,
  }) : super(key: key);

  final List<QueryDocumentSnapshot> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: 70.0.spacingBottom(),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final data = docs[index].data();
        final item = DayModel.fromJson(data as Map<String, dynamic>);
        return DailyExpensesListItemWidget(item: item);
      },
    );
  }
}
