import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/base/base_model.dart';
import 'enum/field.dart';

class YearSavingModel extends BaseModel {
  YearSavingModel({
    required this.id,
    required this.date,
    this.amountDollar = 0.0,
    this.amountRiel = 0,
  });

  YearSavingModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json[Field.id.name]! as int,
          date: json[Field.date.name] as Timestamp,
          amountDollar: json[Field.amount_dollar.name] as double,
          amountRiel: json[Field.amount_riel.name] as int,
        );

  final int id;
  final Timestamp date;
  final double amountDollar;
  final int amountRiel;

  @override
  Map<String, Object?> toJson() => {
        Field.id.name: id,
        Field.date.name: date,
        Field.amount_dollar.name: amountDollar,
        Field.amount_riel.name: amountRiel,
      };
}
