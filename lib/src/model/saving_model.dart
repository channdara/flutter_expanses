import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/base/base_model.dart';
import 'enum/field.dart';

class SavingModel extends BaseModel {
  SavingModel({
    required this.id,
    required this.date,
    this.amountDollar = 0.0,
    this.amountRiel = 0,
    this.remark = '',
  });

  SavingModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json[Field.id.name]! as int,
          date: json[Field.date.name] as Timestamp,
          amountDollar: json[Field.amount_dollar.name] as double,
          amountRiel: json[Field.amount_riel.name] as int,
          remark: json[Field.remark.name] as String,
        );

  final int id;
  final Timestamp date;
  final double amountDollar;
  final int amountRiel;
  final String remark;

  String get getRemark => remark.isEmpty ? 'No remark' : remark;

  String get getDisplayAmount {
    if (amountDollar > 0.0 && amountRiel == 0) {
      return '\$${amountDollar.toStringAsFixed(2)}';
    }
    if (amountDollar == 0.0 && amountRiel > 0) {
      return '${amountRiel}r';
    }
    if (amountDollar > 0.0 && amountRiel > 0) {
      return '\$${amountDollar.toStringAsFixed(2)}   ·   ${amountRiel}r';
    }
    return 'No';
  }

  @override
  Map<String, Object?> toJson() => {
        Field.id.name: id,
        Field.date.name: date,
        Field.amount_dollar.name: amountDollar,
        Field.amount_riel.name: amountRiel,
        Field.remark.name: remark,
      };

  Map<String, Object?> toUpdateJson() => {
        Field.amount_dollar.name: amountDollar,
        Field.amount_riel.name: amountRiel,
        Field.remark.name: remark,
      };

  Map<String, Object?> toIncrementJson(bool isIncrement) => {
        Field.amount_dollar.name: FieldValue.increment(
          isIncrement ? amountDollar : -amountDollar,
        ),
        Field.amount_riel.name: FieldValue.increment(
          isIncrement ? amountRiel : -amountRiel,
        ),
      };
}
