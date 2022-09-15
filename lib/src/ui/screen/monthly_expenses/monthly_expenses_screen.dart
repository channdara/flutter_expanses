import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../common/base/base_state.dart';
import '../../../common/extension/timestamp_extension.dart';
import 'monthly_expenses_list_widget.dart';

class MonthlyExpensesScreen extends StatefulWidget {
  const MonthlyExpensesScreen({super.key, required this.date});

  final Timestamp date;

  String get appBarTitle => 'Expenses on: ${date.year}';

  @override
  State<MonthlyExpensesScreen> createState() => _MonthlyExpensesScreenState();
}

class _MonthlyExpensesScreenState extends BaseState<MonthlyExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.appBarTitle)),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseService.monthQuerySnapshot(widget.date),
        builder: (context, snapshot) {
          if (snapshot.data == null) return const SizedBox();
          return MonthlyExpensesListWidget(docs: snapshot.data!.docs);
        },
      ),
    );
  }
}