import 'package:flutter/material.dart';

import '../../../common/extension/context_extension.dart';
import '../../../common/extension/timestamp_extension.dart';
import '../../../model/item_model.dart';
import '../add_item/add_item_screen.dart';

class PurchasedItemListItemWidget extends StatelessWidget {
  const PurchasedItemListItemWidget({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: item.getDisplayIcon(),
      title: Text(
        item.content,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        item.getDisplayAmount(),
        style: const TextStyle(fontSize: 12.0),
      ),
      trailing: Text(
        item.date.toHourMinute(),
        style: const TextStyle(fontSize: 12.0),
      ),
      onTap: () => context.push(AddItemScreen(item: item)),
    );
  }
}
