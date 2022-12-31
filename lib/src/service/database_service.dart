import 'dart:convert';

import 'package:hive/hive.dart';

import '../model/enum/table.dart';
import '../model/item_template.dart';

class DatabaseService {
  factory DatabaseService() => _singleton;

  DatabaseService._internal();

  static final DatabaseService _singleton = DatabaseService._internal();

  Future<Box<E>> _itemTemplate<E>() async {
    return Hive.openBox(Table.item_template.name);
  }

  Future<List<ItemTemplate>> getItemTemplates() async {
    final List<ItemTemplate> items = [];
    final hive = await _itemTemplate();
    final values = hive.values;
    await hive.close();
    if (values != null) {
      for (final element in values) {
        final map = jsonDecode(element.toString()) as Map<String, Object?>;
        final item = ItemTemplate.fromJson(map);
        items.add(item);
      }
    }
    return items;
  }

  Future<void> setItemTemplate(ItemTemplate item) async {
    final hive = await _itemTemplate();
    await hive.put(item.id, jsonEncode(item.toJson()));
    await hive.close();
  }

  Future<void> updateItemTemplate(ItemTemplate item) async {
    final hive = await _itemTemplate();
    await hive.put(item.id, jsonEncode(item.toJson()));
    await hive.close();
  }
}
