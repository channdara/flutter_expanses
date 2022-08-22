import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/base/base_state.dart';
import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/model/month_model.dart';
import 'package:expenses/src/ui/screen/add_item_screen.dart';
import 'package:expenses/src/ui/widget/daily_expenses/daily_expenses_list_widget.dart';
import 'package:expenses/src/ui/widget/daily_expenses/daily_expenses_month_widget.dart';
import 'package:flutter/material.dart';

class DailyExpensesScreen extends StatefulWidget {
  const DailyExpensesScreen({Key? key}) : super(key: key);

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
              final item = MonthModel.fromJson(data as Map<String, dynamic>);
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
