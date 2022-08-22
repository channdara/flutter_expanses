import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../common/base/base_state.dart';
import '../../common/extension/context_extension.dart';
import '../../model/month_model.dart';
import '../widget/daily_expenses/daily_expenses_list_widget.dart';
import '../widget/daily_expenses/daily_expenses_month_widget.dart';
import 'add_item_screen.dart';

class DailyExpensesScreen extends StatefulWidget {
  const DailyExpensesScreen({super.key});

  @override
  State<DailyExpensesScreen> createState() => _DailyExpensesScreenState();
}

class _DailyExpensesScreenState extends BaseState<DailyExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Expenses')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.push(const AddItemScreen()),
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: firebaseService.monthDocumentSnapshot,
            builder: (context, snapshot) {
              if (snapshot.data == null) return const SizedBox();
              final data = snapshot.data!.data();
              final item = MonthModel.fromJson(data! as Map<String, dynamic>);
              return DailyExpensesMonthWidget(item: item);
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: firebaseService.dayQuerySnapshot,
            builder: (context, snapshot) {
              if (snapshot.data == null) return const SizedBox();
              return DailyExpensesListWidget(docs: snapshot.data!.docs);
            },
          ),
        ],
      ),
    );
  }
}
