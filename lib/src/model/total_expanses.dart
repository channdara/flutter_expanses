import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/model/enum/collection.dart';
import 'package:expenses/src/model/purchase_item.dart';

class TotalExpenses {
  final int id;
  final double totalDollarMe;
  final double totalDollarBee;
  final int totalRielMe;
  final int totalRielBee;
  final Timestamp? date;
  final Timestamp? lastUpdate;

  TotalExpenses({
    this.id = 0,
    this.totalDollarMe = 0.0,
    this.totalDollarBee = 0.0,
    this.totalRielMe = 0,
    this.totalRielBee = 0,
    this.date,
    this.lastUpdate,
  });

  String getMyExpenses() => 'Me: \$$totalDollarMe --- ${totalRielMe}r';

  String getBeeExpenses() => 'Bee: \$$totalDollarBee --- ${totalRielBee}r';

  String getTotalExpenses() =>
      'Total This Month: \$${totalDollarMe + totalDollarBee} --- ${totalRielMe + totalRielBee}r';

  static String collection = Collection.totalExpenses.value;
  static const String idField = 'id';
  static const String totalDollarMeField = 'total_dollar_me';
  static const String totalDollarBeeField = 'total_dollar_bee';
  static const String totalRielMeField = 'total_riel_me';
  static const String totalRielBeeField = 'total_riel_bee';
  static const String dateField = 'date';
  static const String lastUpdateField = 'last_update';

  static Map<String, Object?> toUpdateJson(PurchaseItem item) => {
        totalDollarMeField: FieldValue.increment(item.dollarMe),
        totalDollarBeeField: FieldValue.increment(item.dollarBee),
        totalRielMeField: FieldValue.increment(item.rielMe),
        totalRielBeeField: FieldValue.increment(item.rielBee),
        lastUpdateField: item.date,
      };

  TotalExpenses.fromJson(Map<String, Object?> json)
      : this(
            id: json[idField] as int,
            totalDollarMe: json[totalDollarMeField] as double,
            totalDollarBee: json[totalDollarBeeField] as double,
            totalRielMe: json[totalRielMeField] as int,
            totalRielBee: json[totalRielBeeField] as int,
            date: json[dateField] as Timestamp);

  Map<String, Object?> toJson() => {
        idField: id,
        totalDollarMeField: totalDollarMe,
        totalDollarBeeField: totalDollarBee,
        totalRielMeField: totalRielMe,
        totalRielBeeField: totalRielBee,
        dateField: date,
        lastUpdateField: lastUpdate,
      };
}
