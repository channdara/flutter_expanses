import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/base/base_model.dart';
import 'day_model.dart';
import 'item_model.dart';

class MonthlySummary extends BaseModel {
  MonthlySummary({
    required this.day,
    required this.items,
  });

  final DayModel day;
  final List<ItemModel> items;

  List<ItemModel> getItems() {
    return items.isEmpty
        ? [
            ItemModel(
              id: 0,
              date: Timestamp.now(),
              content: 'No item purchased this day',
            )
          ]
        : items;
  }

  @override
  Map<String, Object> toJson() => {};
}
