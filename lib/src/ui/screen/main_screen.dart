import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/common/extension/double_extension.dart';
import 'package:expenses/src/model/purchase_item.dart';
import 'package:expenses/src/ui/screen/add_expenses_screen.dart';
import 'package:expenses/src/ui/widget/base_scaffold.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Stream<QuerySnapshot> _purchaseItems = FirebaseFirestore.instance
      .collection(PurchaseItem.collection)
      .orderBy(PurchaseItem.idField, descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: const Text('My Expenses')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.push(const AddExpensesScreen()),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _purchaseItems,
        builder: (context, snapshot) {
          return ListView.builder(
            padding: [0.0, 16.0, 0.0, 70.0].spacingLTRB(),
            itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index].data();
              final PurchaseItem item = PurchaseItem.fromJson(
                data as Map<String, dynamic>,
              );
              return ListTile(
                leading: item.getDisplayIcon(),
                trailing: Text(
                  item.getDisplayDate(),
                  style: const TextStyle(fontSize: 12.0),
                ),
                title: Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  item.getDisplayAmount(),
                  style: const TextStyle(fontSize: 12.0),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
