import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/double_extension.dart';
import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/model/month_model.dart';
import 'package:expenses/src/service/firestore_service.dart';
import 'package:flutter/material.dart';

class MonthlyExpensesScreen extends StatefulWidget {
  const MonthlyExpensesScreen({Key? key}) : super(key: key);

  String get appBarTitle => 'Expenses on: ${Timestamp.now().toYearMonth()}';

  @override
  State<MonthlyExpensesScreen> createState() => _MonthlyExpensesScreenState();
}

class _MonthlyExpensesScreenState extends State<MonthlyExpensesScreen> {
  final FirestoreService _service = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.appBarTitle)),
      body: StreamBuilder<QuerySnapshot>(
        stream: _service.monthQuerySnapshot,
        builder: (context, snapshot) {
          if (snapshot.data == null) return const SizedBox();
          return ListView.builder(
            padding: 8.0.spacingVertical(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index].data();
              final item = MonthModel.fromJson(data as Map<String, dynamic>);
              return ListTile(
                leading: const Icon(
                  Icons.keyboard_double_arrow_right,
                  color: Colors.red,
                ),
                title: Text(
                  item.date.toYearMonth(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item.getMyExpenses),
                    Text(item.getBeeExpenses),
                    Text(item.getTotalMonthlyExpenses),
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
