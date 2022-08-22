import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/double_extension.dart';
import 'package:expenses/src/model/month_model.dart';
import 'package:expenses/src/ui/widget/monthly_expenses/monthly_expenses_list_item_widget.dart';
import 'package:flutter/material.dart';

class MonthlyExpensesListWidget extends StatelessWidget {
  const MonthlyExpensesListWidget({
    Key? key,
    required this.docs,
  }) : super(key: key);

  final List<QueryDocumentSnapshot> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: 8.0.spacingVertical(),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final data = docs[index].data();
        final item = MonthModel.fromJson(data as Map<String, dynamic>);
        return MonthlyExpensesListItemWidget(item: item);
      },
    );
  }
}
