import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/base/base_model.dart';
import 'enum/field.dart';

class SavingModel extends BaseModel {
  SavingModel({
    required this.id,
    required this.date,
    required this.amount,
    required this.remark,
  });

  SavingModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json[Field.id.name]! as int,
          date: json[Field.date.name] as Timestamp,
          amount: json[Field.amount.name] as double,
          remark: json[Field.remark.name] as String,
        );

  final int id;
  final Timestamp date;
  final double amount;
  final String remark;

  @override
  Map<String, Object?> toJson() => {
        Field.id.name: id,
        Field.date.name: date,
        Field.amount.name: amount,
        Field.remark.name: remark,
      };
}
