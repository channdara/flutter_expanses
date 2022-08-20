import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/common/extension/double_extension.dart';
import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/model/purchase_item.dart';
import 'package:expenses/src/model/total_expanses.dart';
import 'package:expenses/src/ui/screen/add_item_screen.dart';
import 'package:flutter/material.dart';

class DailyItemsScreen extends StatefulWidget {
  const DailyItemsScreen({Key? key}) : super(key: key);

  @override
  State<DailyItemsScreen> createState() => _DailyItemsScreenState();
}

class _DailyItemsScreenState extends State<DailyItemsScreen> {
  final _dailyExpenses = FirebaseFirestore.instance
      .collection(TotalExpenses.collectionDaily)
      .doc(Timestamp.now().toYearMonthDay())
      .collection(PurchaseItem.collection)
      .orderBy(PurchaseItem.idField, descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final appBarText = 'Expenses on: ${Timestamp.now().toYearMonthDay()}';
    return Scaffold(
      appBar: AppBar(title: Text(appBarText)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.push(const AddItemScreen()),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _dailyExpenses,
        builder: (context, snapshot) {
          return ListView.builder(
            padding: 70.0.spacingBottom(),
            itemCount: snapshot.data != null ? snapshot.data!.docs.length : 0,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index].data();
              final item = PurchaseItem.fromJson(data as Map<String, dynamic>);
              return ListTile(
                leading: item.getDisplayIcon(),
                title: Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  item.getDisplayAmount(),
                  style: const TextStyle(fontSize: 12.0),
                ),
                trailing: Text(
                  item.date?.toHourMinute() ?? '',
                  style: const TextStyle(fontSize: 12.0),
                ),
                onTap: () => context.push(AddItemScreen(item: item)),
              );
            },
          );
        },
      ),
    );
  }
}
