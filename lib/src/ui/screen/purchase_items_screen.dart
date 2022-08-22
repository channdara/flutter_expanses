import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../common/base/base_state.dart';
import '../../common/extension/context_extension.dart';
import '../../common/extension/timestamp_extension.dart';
import '../widget/purchase_items/purchase_items_list_widget.dart';
import 'add_item_screen.dart';

class PurchaseItemsScreen extends StatefulWidget {
  const PurchaseItemsScreen({super.key});

  String get appBarTitle => 'Expenses on: ${Timestamp.now().toYearMonthDay()}';

  @override
  State<PurchaseItemsScreen> createState() => _PurchaseItemsScreenState();
}

class _PurchaseItemsScreenState extends BaseState<PurchaseItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.appBarTitle)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.push(const AddItemScreen()),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseService.itemQuerySnapshot,
        builder: (context, snapshot) {
          if (snapshot.data == null) return const SizedBox();
          return PurchaseItemsListWidget(docs: snapshot.data!.docs);
        },
      ),
    );
  }
}
