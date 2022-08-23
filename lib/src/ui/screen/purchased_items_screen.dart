import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../common/base/base_state.dart';
import '../../common/extension/context_extension.dart';
import '../../common/extension/timestamp_extension.dart';
import '../widget/purchased_items/purchased_items_list_widget.dart';
import 'add_item_screen.dart';

class PurchasedItemsScreen extends StatefulWidget {
  const PurchasedItemsScreen({super.key, required this.docId});

  final String docId;

  String get appBarTitle => 'Expenses on: ${Timestamp.now().toYearMonthDay()}';

  @override
  State<PurchasedItemsScreen> createState() => _PurchasedItemsScreenState();
}

class _PurchasedItemsScreenState extends BaseState<PurchasedItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.appBarTitle)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.push(const AddItemScreen()),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseService.itemQuerySnapshot(widget.docId),
        builder: (context, snapshot) {
          if (snapshot.data == null) return const SizedBox();
          return PurchasedItemsListWidget(docs: snapshot.data!.docs);
        },
      ),
    );
  }
}
