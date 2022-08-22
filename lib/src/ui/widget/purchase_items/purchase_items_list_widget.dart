import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../common/extension/double_extension.dart';
import '../../../model/item_model.dart';
import 'purchase_items_list_item_widget.dart';

class PurchaseItemsListWidget extends StatelessWidget {
  const PurchaseItemsListWidget({
    super.key,
    required this.docs,
  });

  final List<QueryDocumentSnapshot> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: 70.0.spacingBottom(),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final data = docs[index].data();
        final item = ItemModel.fromJson(data! as Map<String, Object>);
        return PurchaseItemListItemWidget(item: item);
      },
    );
  }
}
