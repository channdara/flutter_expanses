import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/service/firestore_service.dart';
import 'package:expenses/src/ui/screen/add_item_screen.dart';
import 'package:expenses/src/ui/widget/purchase_items/purchase_items_list_widget.dart';
import 'package:flutter/material.dart';

class PurchaseItemsScreen extends StatefulWidget {
  const PurchaseItemsScreen({Key? key}) : super(key: key);

  String get appBarTitle => 'Expenses on: ${Timestamp.now().toYearMonthDay()}';

  @override
  State<PurchaseItemsScreen> createState() => _PurchaseItemsScreenState();
}

class _PurchaseItemsScreenState extends State<PurchaseItemsScreen> {
  final FirestoreService _service = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.appBarTitle)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.push(const AddItemScreen()),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _service.itemQuerySnapshot,
        builder: (context, snapshot) {
          if (snapshot.data == null) return const SizedBox();
          return PurchaseItemsListWidget(docs: snapshot.data!.docs);
        },
      ),
    );
  }
}
