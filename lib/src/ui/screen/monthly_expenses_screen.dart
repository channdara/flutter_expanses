import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/double_extension.dart';
import 'package:expenses/src/model/total_expanses.dart';
import 'package:flutter/material.dart';

class MonthlyExpensesScreen extends StatefulWidget {
  const MonthlyExpensesScreen({Key? key}) : super(key: key);

  @override
  State<MonthlyExpensesScreen> createState() => _MonthlyExpensesScreenState();
}

class _MonthlyExpensesScreenState extends State<MonthlyExpensesScreen> {
  final _monthlyExpenses = FirebaseFirestore.instance
      .collection(TotalExpenses.collectionMonthly)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monthly Expenses')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _monthlyExpenses,
        builder: (context, snapshot) {
          return ListView.builder(
            padding: 8.0.spacingVertical(),
            itemCount: snapshot.data != null ? snapshot.data!.docs.length : 0,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index].data();
              final item = TotalExpenses.fromJson(
                data as Map<String, dynamic>,
              );
              return ListTile(
                leading: const Icon(
                  Icons.keyboard_double_arrow_right,
                  color: Colors.red,
                ),
                title: Text(
                  item.id,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item.getMyExpenses()),
                    Text(item.getBeeExpenses()),
                    Text(item.getTotalMonthlyExpenses()),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
