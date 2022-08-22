import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/base/base_state.dart';
import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/ui/widget/monthly_expenses/monthly_expenses_list_widget.dart';
import 'package:flutter/material.dart';

class MonthlyExpensesScreen extends StatefulWidget {
  const MonthlyExpensesScreen({Key? key}) : super(key: key);

  String get appBarTitle => 'Expenses on: ${Timestamp.now().toYearMonth()}';

  @override
  State<MonthlyExpensesScreen> createState() => _MonthlyExpensesScreenState();
}

class _MonthlyExpensesScreenState extends BaseState<MonthlyExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.appBarTitle)),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseService.monthQuerySnapshot,
        builder: (context, snapshot) {
          if (snapshot.data == null) return const SizedBox();
          return MonthlyExpensesListWidget(docs: snapshot.data!.docs);
        },
      ),
    );
  }
}
