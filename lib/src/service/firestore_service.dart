import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/extension/timestamp_extension.dart';
import '../model/day_model.dart';
import '../model/enum/collection.dart';
import '../model/enum/field.dart';
import '../model/item_model.dart';
import '../model/month_model.dart';
import '../model/monthly_summary.dart';
import '../model/year_model.dart';

class FirestoreService {
  factory FirestoreService() => _singleton;

  FirestoreService._internal();

  static final FirestoreService _singleton = FirestoreService._internal();

  Timestamp get _timestamp => Timestamp.now();

  DocumentReference _year(Timestamp timestamp) => FirebaseFirestore.instance
      .collection(Collection.owner.value)
      .doc(timestamp.getYear());

  DocumentReference _month(Timestamp timestamp) => _year(timestamp)
      .collection(Collection.owner.value)
      .doc(timestamp.getMonth());

  DocumentReference _day(Timestamp timestamp) => _month(timestamp)
      .collection(Collection.owner.value)
      .doc(timestamp.getDay());

  Future<void> _checkYear() async {
    final value = await _year(_timestamp).get();
    if (value.exists) return;
    final data = YearModel(id: _timestamp.year, date: _timestamp);
    await _year(_timestamp).set(data.toJson());
  }

  Future<void> _checkMonth() async {
    final value = await _month(_timestamp).get();
    if (value.exists) return;
    final data = MonthModel(id: _timestamp.month, date: _timestamp);
    await _month(_timestamp).set(data.toJson());
  }

  Future<void> _checkDay() async {
    final value = await _day(_timestamp).get();
    if (value.exists) return;
    final data = DayModel(id: _timestamp.day, date: _timestamp);
    await _day(_timestamp).set(data.toJson());
  }

  Future<void> addItem(ItemModel item) async {
    _day(item.date)
        .collection(Collection.owner.value)
        .doc(item.date.seconds.toString())
        .set(item.toJson());
  }

  Future<void> updateItem(ItemModel oldItem, ItemModel newItem) async {
    _day(oldItem.date)
        .collection(Collection.owner.value)
        .doc(oldItem.id.toString())
        .update(newItem.toUpdateJson());
  }

  Future<void> increaseMonth(
    Timestamp timestamp,
    ItemModel item, {
    bool isIncrement = true,
  }) async {
    _month(timestamp).update(item.toIncrementJson(isIncrement: isIncrement));
  }

  Future<void> increaseDay(
    Timestamp timestamp,
    ItemModel item, {
    bool isIncrement = true,
  }) async {
    _day(timestamp).update(item.toIncrementJson(isIncrement: isIncrement));
  }

  Future<void> checkCurrentDate() async {
    await _checkYear();
    await _checkMonth();
    await _checkDay();
  }

  Future<List<MonthlySummary>> getMonthlySummary(Timestamp timestamp) async {
    final List<MonthlySummary> monthlySummaryItems = [];
    final allDaily =
        await _month(timestamp).collection(Collection.owner.value).get();
    for (final daily in allDaily.docs) {
      final List<ItemModel> itemModelItems = [];
      final dayModel = DayModel.fromJson(daily.data());
      final allItems = await _month(timestamp)
          .collection(Collection.owner.value)
          .doc(daily.id)
          .collection(Collection.owner.value)
          .get();
      for (final item in allItems.docs) {
        final itemModel = ItemModel.fromJson(item.data());
        itemModelItems.add(itemModel);
      }
      monthlySummaryItems.add(
        MonthlySummary(day: dayModel, items: itemModelItems),
      );
    }
    return monthlySummaryItems;
  }

  Future<List<MonthModel>> getMonthlyExpenses(Timestamp timestamp) async {
    final List<MonthModel> monthModelItems = [];
    final allMonthly = await _year(timestamp)
        .collection(Collection.owner.value)
        .orderBy(Field.id.name, descending: true)
        .get();
    for (final monthly in allMonthly.docs) {
      final monthModel = MonthModel.fromJson(monthly.data());
      monthModelItems.add(monthModel);
    }
    return monthModelItems;
  }

  Future<List<ItemModel>> getPurchasedItems(Timestamp timestamp) async {
    final List<ItemModel> itemModelItems = [];
    final allItems = await _day(timestamp)
        .collection(Collection.owner.value)
        .orderBy(Field.id.name, descending: true)
        .get();
    for (final item in allItems.docs) {
      final itemModel = ItemModel.fromJson(item.data());
      itemModelItems.add(itemModel);
    }
    return itemModelItems;
  }

  Future<List<DayModel>> getDailyExpenses(Timestamp timestamp) async {
    final List<DayModel> dayModelItems = [];
    final getDaily = await _month(timestamp)
        .collection(Collection.owner.value)
        .orderBy(Field.id.name, descending: true)
        .get();
    for (final daily in getDaily.docs) {
      final dayModel = DayModel.fromJson(daily.data());
      dayModelItems.add(dayModel);
    }
    return dayModelItems;
  }

  Future<MonthModel> getCurrentMonthSummary(Timestamp timestamp) async {
    final currentMonth = await _month(timestamp).get();
    final data = currentMonth.data()! as Map<String, dynamic>;
    return MonthModel.fromJson(data);
  }
}
