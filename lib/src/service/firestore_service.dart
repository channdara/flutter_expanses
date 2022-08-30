import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/extension/timestamp_extension.dart';
import '../model/day_model.dart';
import '../model/enum/collection.dart';
import '../model/enum/field.dart';
import '../model/item_model.dart';
import '../model/month_model.dart';
import '../model/year_model.dart';

class FirestoreService {
  factory FirestoreService() {
    return _singleton;
  }

  FirestoreService._internal();

  static final FirestoreService _singleton = FirestoreService._internal();

  Timestamp get _timestamp => Timestamp.now();

  /// getting DocumentReference for current year, month and day
  DocumentReference get _currentYear => FirebaseFirestore.instance
      .collection(Collection.owner.value)
      .doc(_timestamp.getYear());

  DocumentReference get _currentMonth => _currentYear
      .collection(Collection.owner.value)
      .doc(_timestamp.getMonth());

  DocumentReference _currentDay({String? id}) => _currentMonth
      .collection(Collection.owner.value)
      .doc(id ?? _timestamp.getDay());

  /// getting stream of DocumentSnapshot
  Stream<DocumentSnapshot> get monthDocumentSnapshot =>
      _currentMonth.snapshots().distinct();

  /// getting stream of QuerySnapshot
  Stream<QuerySnapshot> get monthQuerySnapshot => _currentYear
      .collection(Collection.owner.value)
      .orderBy(Field.id.name, descending: true)
      .snapshots().distinct();

  Stream<QuerySnapshot> get dayQuerySnapshot => _currentMonth
      .collection(Collection.owner.value)
      .orderBy(Field.id.name, descending: true)
      .snapshots().distinct();

  Stream<QuerySnapshot> itemQuerySnapshot(String id) => _currentDay(id: id)
      .collection(Collection.owner.value)
      .orderBy(Field.id.name, descending: true)
      .snapshots().distinct();

  /// Firestore functionality
  Future<void> addItem(ItemModel item) async {
    _currentDay()
        .collection(Collection.owner.value)
        .doc(_timestamp.seconds.toString())
        .set(item.toJson());
  }

  Future<void> updateItem(int id, ItemModel item) async {
    _currentDay()
        .collection(Collection.owner.value)
        .doc(id.toString())
        .update(item.toUpdateJson());
  }

  Future<void> increaseMonth(ItemModel item, {bool isIncrement = true}) async {
    _currentMonth.update(item.toIncrementJson(isIncrement: isIncrement));
  }

  Future<void> increaseDay(ItemModel item, {bool isIncrement = true}) async {
    _currentDay().update(item.toIncrementJson(isIncrement: isIncrement));
  }

  Future<void> checkCurrentDate() async {
    await _checkYear();
    await _checkMonth();
    await _checkDay();
  }

  Future<void> _checkYear() async {
    final value = await _currentYear.get();
    if (value.exists) return;
    final data = YearModel(id: _timestamp.year, date: _timestamp);
    _currentYear.set(data.toJson());
  }

  Future<void> _checkMonth() async {
    final value = await _currentMonth.get();
    if (value.exists) return;
    final data = MonthModel(id: _timestamp.month, date: _timestamp);
    _currentMonth.set(data.toJson());
  }

  Future<void> _checkDay() async {
    final value = await _currentDay().get();
    if (value.exists) return;
    final data = DayModel(id: _timestamp.day, date: _timestamp);
    _currentDay().set(data.toJson());
  }
}
