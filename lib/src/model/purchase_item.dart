import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/model/enum/collection.dart';
import 'package:expenses/src/model/enum/item_type.dart';
import 'package:flutter/material.dart';

class PurchaseItem {
  PurchaseItem({
    this.id = 0,
    this.name = '',
    this.type = ItemType.me,
    this.dollarMe = 0.0,
    this.dollarBee = 0.0,
    this.rielMe = 0,
    this.rielBee = 0,
    this.date,
  });

  final int id;
  final String name;
  final ItemType type;
  final double dollarMe;
  final double dollarBee;
  final int rielMe;
  final int rielBee;
  final Timestamp? date;

  String getDisplayAmount() {
    switch (type) {
      case ItemType.me:
        return '\$$dollarMe     |     ${rielMe}r';
      case ItemType.bee:
        return '\$$dollarBee     |     ${rielBee}r';
      default:
        return '\$$dollarMe   ·   ${rielMe}r     |     \$$dollarBee   ·   ${rielBee}r';
    }
  }

  Icon getDisplayIcon() {
    switch (type) {
      case ItemType.me:
        return const Icon(Icons.person, color: Colors.blue);
      case ItemType.bee:
        return const Icon(Icons.person, color: Colors.pinkAccent);
      default:
        return const Icon(Icons.people, color: Colors.green);
    }
  }

  static String collection = Collection.purchaseItems.value;
  static const String idField = 'id';
  static const String nameField = 'name';
  static const String typeField = 'type';
  static const String dollarMeField = 'dollar_me';
  static const String dollarBeeField = 'dollar_bee';
  static const String rielMeField = 'riel_me';
  static const String rielBeeField = 'riel_bee';
  static const String dateField = 'date';

  PurchaseItem.fromJson(Map<String, Object?> json)
      : this(
          id: json[idField] as int,
          name: json[nameField] as String,
          type: ItemType.getItemType(json[typeField] as int),
          dollarMe: json[dollarMeField] as double,
          dollarBee: json[dollarBeeField] as double,
          rielMe: json[rielMeField] as int,
          rielBee: json[rielBeeField] as int,
          date: json[dateField] as Timestamp,
        );

  Map<String, Object?> toJson() => {
        idField: id,
        nameField: name,
        typeField: type.value,
        dollarMeField: dollarMe,
        dollarBeeField: dollarBee,
        rielMeField: rielMe,
        rielBeeField: rielBee,
        dateField: date,
      };

  Map<String, Object?> toUpdateJson() => {
        nameField: name,
        typeField: type.value,
        dollarMeField: dollarMe,
        dollarBeeField: dollarBee,
        rielMeField: rielMe,
        rielBeeField: rielBee,
      };
}
