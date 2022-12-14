import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../common/base/base_state.dart';
import '../../../common/extension/context_extension.dart';
import '../../../model/day_model.dart';
import '../../../model/month_model.dart';
import '../add_item/add_item_screen.dart';
import 'daily_expenses_list_widget.dart';
import 'daily_expenses_month_widget.dart';

class DailyExpensesScreen extends StatefulWidget {
  const DailyExpensesScreen({super.key, required this.date});

  final Timestamp date;

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
          FutureBuilder<MonthModel>(
            future: firestoreService.getCurrentMonthSummary(widget.date),
            builder: (context, snapshot) {
              return DailyExpensesMonthWidget(item: snapshot.data);
            },
          ),
          Expanded(
            child: FutureBuilder<List<DayModel>>(
              future: firestoreService.getDailyExpenses(widget.date),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data == null) return const SizedBox();
                return RefreshIndicator(
                  onRefresh: awaitSetState,
                  child: DailyExpensesListWidget(docs: snapshot.data!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
