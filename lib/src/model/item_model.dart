import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../common/base/base_model.dart';
import 'enum/field.dart';
import 'enum/item_type.dart';

class ItemModel extends BaseModel {
  ItemModel({
    required this.id,
    required this.date,
    this.content = '',
    this.type = ItemType.me,
    this.dollarMe = 0.0,
    this.dollarBee = 0.0,
    this.rielMe = 0,
    this.rielBee = 0,
  });

  ItemModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json[Field.id.name]! as int,
          date: json[Field.date.name]! as Timestamp,
          content: json[Field.content.name]! as String,
          type: ItemType.getItemType(json[Field.type.name]! as int),
          dollarMe: json[Field.dollar_me.name]! as double,
          dollarBee: json[Field.dollar_bee.name]! as double,
          rielMe: json[Field.riel_me.name]! as int,
          rielBee: json[Field.riel_bee.name]! as int,
        );

  final int id;
  final Timestamp date;
  final String content;
  final ItemType type;
  final double dollarMe;
  final double dollarBee;
  final int rielMe;
  final int rielBee;

  String getDisplayAmount() {
    switch (type) {
      case ItemType.me:
        return '\$$dollarMe   ·   ${rielMe}r';
      case ItemType.bee:
        return '\$$dollarBee   ·   ${rielBee}r';
      default:
        return '\$$dollarMe   ·   ${rielMe}r     |     \$$dollarBee   ·   ${rielBee}r';
    }
  }

  Icon getDisplayIcon() {
    switch (type) {
      case ItemType.me:
        return const Icon(Icons.person, color: Colors.blue);
      case ItemType.bee:
        return const Icon(Icons.person, color: Colors.pink);
      default:
        return const Icon(Icons.people, color: Colors.green);
    }
  }

  double totalDollar() => dollarMe + dollarBee;

  int totalRiel() => rielMe + rielBee;

  Map<String, Object?> toIncrementJson({bool isIncrement = true}) => {
        Field.total_dollar_me.name: FieldValue.increment(
          isIncrement ? dollarMe : -dollarMe,
        ),
        Field.total_dollar_bee.name: FieldValue.increment(
          isIncrement ? dollarBee : -dollarBee,
        ),
        Field.total_riel_me.name: FieldValue.increment(
          isIncrement ? rielMe : -rielMe,
        ),
        Field.total_riel_bee.name: FieldValue.increment(
          isIncrement ? rielBee : -rielBee,
        ),
      };

  @override
  Map<String, Object?> toJson() => {
        Field.id.name: id,
        Field.date.name: date,
        Field.content.name: content,
        Field.type.name: type.value,
        Field.dollar_me.name: dollarMe,
        Field.dollar_bee.name: dollarBee,
        Field.riel_me.name: rielMe,
        Field.riel_bee.name: rielBee,
      };

  Map<String, Object?> toUpdateJson() => {
        Field.content.name: content,
        Field.type.name: type.value,
        Field.dollar_me.name: dollarMe,
        Field.dollar_bee.name: dollarBee,
        Field.riel_me.name: rielMe,
        Field.riel_bee.name: rielBee,
      };
}
