import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../common/extension/double_extension.dart';
import '../../../model/item_model.dart';
import 'purchased_items_list_item_widget.dart';

class PurchasedItemsListWidget extends StatelessWidget {
  const PurchasedItemsListWidget({super.key, required this.docs});

  final List<QueryDocumentSnapshot> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: 8.0.spacingVertical(),
      itemCount: docs.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final data = docs[index].data();
        if (data == null) return const SizedBox();
        final item = ItemModel.fromJson(data as Map<String, dynamic>);
        return PurchasedItemListItemWidget(item: item);
      },
    );
  }
}
