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
  factory FirestoreService() {
    return _singleton;
  }

  FirestoreService._internal();

  static final FirestoreService _singleton = FirestoreService._internal();

  Timestamp get _timestamp => Timestamp.now();

  /// getting DocumentReference for current year, month and day
  DocumentReference _year(Timestamp timestamp) => FirebaseFirestore.instance
      .collection(Collection.owner.value)
      .doc(timestamp.getYear());

  DocumentReference _month(Timestamp timestamp) => _year(timestamp)
      .collection(Collection.owner.value)
      .doc(timestamp.getMonth());

  DocumentReference _day(Timestamp timestamp) => _month(timestamp)
      .collection(Collection.owner.value)
      .doc(timestamp.getDay());

  /// getting stream of DocumentSnapshot
  Stream<DocumentSnapshot> monthDocumentSnapshot(Timestamp timestamp) =>
      _month(timestamp).snapshots().distinct();

  /// getting stream of QuerySnapshot
  Stream<QuerySnapshot> monthQuerySnapshot(Timestamp timestamp) =>
      _year(timestamp)
          .collection(Collection.owner.value)
          .orderBy(Field.id.name, descending: true)
          .snapshots()
          .distinct();

  Stream<QuerySnapshot> dayQuerySnapshot(Timestamp timestamp) =>
      _month(timestamp)
          .collection(Collection.owner.value)
          .orderBy(Field.id.name, descending: true)
          .snapshots()
          .distinct();

  Stream<QuerySnapshot> itemQuerySnapshot(Timestamp timestamp) =>
      _day(timestamp)
          .collection(Collection.owner.value)
          .orderBy(Field.id.name, descending: true)
          .snapshots()
          .distinct();

  /// Firestore functionality
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

  Future<Timestamp> checkCurrentDate() async {
    await _checkYear();
    await _checkMonth();
    await _checkDay();
    return _timestamp;
  }

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

  Future<List<MonthlySummary>> getMonthlySummary(Timestamp date) async {
    final List<MonthlySummary> monthlySummaries = [];
    final dailies = await _month(date).collection(Collection.owner.value).get();
    for (final daily in dailies.docs) {
      final List<ItemModel> items = [];
      final day = DayModel.fromJson(daily.data());
      final purchasedItems = await _month(date)
          .collection(Collection.owner.value)
          .doc(daily.id)
          .collection(Collection.owner.value)
          .get();
      for (final item in purchasedItems.docs) {
        final itemModel = ItemModel.fromJson(item.data());
        items.add(itemModel);
      }
      monthlySummaries.add(MonthlySummary(day: day, items: items));
    }
    return monthlySummaries;
  }
}
