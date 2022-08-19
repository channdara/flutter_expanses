import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/common/extension/double_extension.dart';
import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/model/purchase_item.dart';
import 'package:expenses/src/model/total_expanses.dart';
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
  final Stream<DocumentSnapshot> _totalExpenses = FirebaseFirestore.instance
      .collection(TotalExpenses.collection)
      .doc(Timestamp.now().toYM())
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: const Text('My Expenses'), elevation: 0.0),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.push(const AddExpensesScreen()),
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: _totalExpenses,
            builder: (context, snapshot) {
              if (snapshot.data == null) return const SizedBox();
              final data = snapshot.data!.data();
              final item = TotalExpenses.fromJson(
                data as Map<String, dynamic>,
              );
              return Card(
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
                        child: Text(item.getTotalExpenses()),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _purchaseItems,
              builder: (context, snapshot) {
                return ListView.builder(
                  padding: 70.0.spacingBottom(),
                  itemCount:
                      snapshot.data != null ? snapshot.data!.docs.length : 0,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index].data();
                    final item = PurchaseItem.fromJson(
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
          )
        ],
      ),
    );
  }
}
