import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../common/base/base_state.dart';
import '../../../common/extension/timestamp_extension.dart';
import '../../../model/item_model.dart';
import 'purchased_items_list_widget.dart';

class PurchasedItemsScreen extends StatefulWidget {
  const PurchasedItemsScreen({super.key, required this.date});

  final Timestamp date;

  String get appBarTitle => 'Expenses on: ${date.toYearMonthDay()}';

  @override
  State<PurchasedItemsScreen> createState() => _PurchasedItemsScreenState();
}

class _PurchasedItemsScreenState extends BaseState<PurchasedItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.appBarTitle)),
      body: FutureBuilder<List<ItemModel>>(
        future: firestoreService.getPurchasedItems(widget.date),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) return const SizedBox();
          return RefreshIndicator(
            onRefresh: awaitSetState,
            child: PurchasedItemsListWidget(docs: snapshot.data!),
          );
        },
      ),
    );
  }
}
