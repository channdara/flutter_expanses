import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/double_extension.dart';
import 'package:expenses/src/model/item_model.dart';
import 'package:expenses/src/ui/widget/purchase_items/purchase_items_list_item_widget.dart';
import 'package:flutter/material.dart';

class PurchaseItemsListWidget extends StatelessWidget {
  const PurchaseItemsListWidget({
    Key? key,
    required this.docs,
  }) : super(key: key);

  final List<QueryDocumentSnapshot> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: 70.0.spacingBottom(),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final data = docs[index].data();
        final item = ItemModel.fromJson(data as Map<String, dynamic>);
        return PurchaseItemListItemWidget(item: item);
      },
    );
  }
}
