import 'package:flutter/material.dart';

import '../../../common/base/base_state.dart';
import '../../../model/month_model.dart';
import 'monthly_expenses_screen_list.dart';

class MonthlyExpensesScreen extends StatefulWidget {
  const MonthlyExpensesScreen({super.key});

  @override
  State<MonthlyExpensesScreen> createState() => _MonthlyExpensesScreenState();
}

class _MonthlyExpensesScreenState extends BaseState<MonthlyExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monthly Expenses')),
      body: FutureBuilder<List<MonthModel>>(
        future: expansesService.getMonthlyExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) return const SizedBox();
          return RefreshIndicator(
            onRefresh: awaitSetState,
            child: MonthlyExpensesScreenList(docs: snapshot.data!),
          );
        },
      ),
    );
  }
}
