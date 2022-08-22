import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/model/item_model.dart';
import 'package:expenses/src/ui/screen/add_item_screen.dart';
import 'package:flutter/material.dart';

class PurchaseItemListItemWidget extends StatelessWidget {
  const PurchaseItemListItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

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
