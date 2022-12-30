import 'package:flutter/material.dart';

import '../../../common/extension/double_extension.dart';
import '../../../model/item_model.dart';
import 'purchased_items_screen_list_item_widget.dart';

class PurchasedItemsScreenListWidget extends StatelessWidget {
  const PurchasedItemsScreenListWidget({super.key, required this.docs});

  final List<ItemModel> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: 8.0.spacingVertical(),
      itemCount: docs.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = docs[index];
        if (item == null) return const SizedBox();
        return PurchasedItemScreenListItemWidget(item: item);
      },
    );
  }
}
