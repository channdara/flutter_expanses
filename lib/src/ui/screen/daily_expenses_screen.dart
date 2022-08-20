import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/common/extension/double_extension.dart';
import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/model/purchase_item.dart';
import 'package:expenses/src/model/total_expanses.dart';
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
  final _monthlyExpenses = FirebaseFirestore.instance
      .collection(TotalExpenses.collectionMonthly)
      .doc(Timestamp.now().toYearMonth())
      .snapshots();
  final _dailyExpenses = FirebaseFirestore.instance
      .collection(TotalExpenses.collectionDaily)
      .orderBy(PurchaseItem.idField, descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Expenses'), elevation: 0.0),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.push(const AddItemScreen()),
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: _monthlyExpenses,
            builder: (context, snapshot) {
              if (snapshot.data == null) return const SizedBox();
              final data = snapshot.data!.data();
              final item = TotalExpenses.fromJson(data as Map<String, dynamic>);
              return GestureDetector(
                onTap: () => context.push(const MonthlyExpensesScreen()),
                child: Card(
                  margin: 0.0.spacingAll(),
                  shape: RoundedRectangleBorder(borderRadius: 0.0.circular()),
                  child: Container(
                    width: double.infinity,
                    padding: 16.0.spacingAll(),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(item.getMyExpenses()),
                        Text(item.getBeeExpenses()),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(item.getTotalMonthlyExpenses()),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _dailyExpenses,
              builder: (context, snapshot) {
                return ListView.builder(
                  padding: 70.0.spacingBottom(),
                  itemCount:
                      snapshot.data != null ? snapshot.data!.docs.length : 0,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index].data();
                    final item = TotalExpenses.fromJson(
                      data as Map<String, dynamic>,
                    );
                    return ListTile(
                      title: Text(
                        item.id,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        item.getTotalDailyExpenses(),
                        style: const TextStyle(fontSize: 12.0),
                      ),
                      trailing: const Icon(
                        Icons.keyboard_double_arrow_right,
                        color: Colors.red,
                      ),
                      onTap: () => context.push(const DailyItemsScreen()),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
