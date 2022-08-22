import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/base/base_model.dart';
import 'enum/field.dart';

class MonthModel extends BaseModel {
  MonthModel({
    required this.id,
    required this.date,
    this.totalDollarMe = 0.0,
    this.totalDollarBee = 0.0,
    this.totalRielMe = 0,
    this.totalRielBee = 0,
  });

  MonthModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json[Field.id.name]! as int,
          date: json[Field.date.name]! as Timestamp,
          totalDollarMe: json[Field.total_dollar_me.name]! as double,
          totalDollarBee: json[Field.total_dollar_bee.name]! as double,
          totalRielMe: json[Field.total_riel_me.name]! as int,
          totalRielBee: json[Field.total_riel_bee.name]! as int,
        );

  final int id;
  final Timestamp date;
  final double totalDollarMe;
  final double totalDollarBee;
  final int totalRielMe;
  final int totalRielBee;

  String get getMyExpenses => 'Me: \$$totalDollarMe   ·   ${totalRielMe}r';

  String get getBeeExpenses => 'Bee: \$$totalDollarBee   ·   ${totalRielBee}r';

  String get getTotalMonthlyExpenses =>
      'Total This Month: \$${totalDollarMe + totalDollarBee}   ·   ${totalRielMe + totalRielBee}r';

  @override
  Map<String, Object?> toJson() => {
        Field.id.name: id,
        Field.date.name: date,
        Field.total_dollar_me.name: totalDollarMe,
        Field.total_dollar_bee.name: totalDollarBee,
        Field.total_riel_me.name: totalRielMe,
        Field.total_riel_bee.name: totalRielBee,
      };
}
