import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/common/extension/double_extension.dart';
import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/model/day_model.dart';
import 'package:expenses/src/model/month_model.dart';
import 'package:expenses/src/service/firestore_service.dart';
import 'package:expenses/src/ui/screen/add_item_screen.dart';
import 'package:expenses/src/ui/screen/daily_items_screen.dart';
import 'package:expenses/src/ui/screen/monthly_expenses_screen.dart';
import 'package:flutter/material.dart';

class DailyExpensesScreen extends StatefulWidget {
  const DailyExpensesScreen({Key? key}) : super(key: key);

  @override
  State<DailyExpensesScreen> createState() => _DailyExpensesScreenState();
}

class _DailyExpensesScreenState extends State<DailyExpensesScreen> {
  final FirestoreService _service = FirestoreService();

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
            stream: _service.monthDocumentSnapshot,
            builder: (context, snapshot) {
              if (snapshot.data == null) return const SizedBox();
              final data = snapshot.data!.data();
              final item = MonthModel.fromJson(data as Map<String, dynamic>);
              return GestureDetector(
                onTap: () => context.push(const MonthlyExpensesScreen()),
                child: Card(
                  margin: 8.0.spacingAll(),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(borderRadius: 12.0.circular()),
                  child: Container(
                    width: double.infinity,
                    padding: 16.0.spacingAll(),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(item.getMyExpenses),
                        Text(item.getBeeExpenses),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(item.getTotalMonthlyExpenses),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _service.dayQuerySnapshot,
            builder: (context, snapshot) {
              if (snapshot.data == null) return const SizedBox();
              return ListView.builder(
                shrinkWrap: true,
                padding: 70.0.spacingBottom(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data!.docs[index].data();
                  final item = DayModel.fromJson(data as Map<String, dynamic>);
                  return ListTile(
                    leading: Icon(
                      Icons.circle,
                      color: item.date.isToday ? Colors.green : Colors.red,
                    ),
                    title: Text(
                      item.date.toYearMonthDay(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      item.getTotalDailyExpenses,
                      style: const TextStyle(fontSize: 12.0),
                    ),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.red,
                    ),
                    onTap: () => context.push(const DailyItemsScreen()),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
