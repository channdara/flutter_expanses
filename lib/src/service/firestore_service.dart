import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/model/day_model.dart';
import 'package:expenses/src/model/enum/collection.dart';
import 'package:expenses/src/model/enum/field.dart';
import 'package:expenses/src/model/item_model.dart';
import 'package:expenses/src/model/month_model.dart';
import 'package:expenses/src/model/year_model.dart';

class FirestoreService {
  static final FirestoreService _singleton = FirestoreService._internal();

  factory FirestoreService() {
    return _singleton;
  }

  FirestoreService._internal();

  Timestamp get _timestamp => Timestamp.now();

  /// getting DocumentReference for current year, month and day
  DocumentReference get _currentYear => FirebaseFirestore.instance
      .collection(Collection.owner.value)
      .doc(_timestamp.getYear());

  DocumentReference get _currentMonth => _currentYear
      .collection(Collection.owner.value)
      .doc(_timestamp.getMonth());

  DocumentReference get _currentDay =>
      _currentMonth.collection(Collection.owner.value).doc(_timestamp.getDay());

  /// getting stream of DocumentSnapshot
  Stream<DocumentSnapshot> get monthDocumentSnapshot =>
      _currentMonth.snapshots();

  /// getting stream of QuerySnapshot
  Stream<QuerySnapshot> get monthQuerySnapshot => _currentYear
      .collection(Collection.owner.value)
      .orderBy(Field.id.name, descending: true)
      .snapshots();

  Stream<QuerySnapshot> get dayQuerySnapshot => _currentMonth
      .collection(Collection.owner.value)
      .orderBy(Field.id.name, descending: true)
      .snapshots();

  Stream<QuerySnapshot> get itemQuerySnapshot => _currentDay
      .collection(Collection.owner.value)
      .orderBy(Field.id.name, descending: true)
      .snapshots();

  /// Firestore functionality
  Future<void> addItem(ItemModel item) async {
    _currentDay
        .collection(Collection.owner.value)
        .doc(_timestamp.seconds.toString())
        .set(item.toJson());
  }

  Future<void> updateItem(int id, ItemModel item) async {
    _currentDay
        .collection(Collection.owner.value)
        .doc(id.toString())
        .update(item.toUpdateJson());
  }

  Future<void> increaseMonth(ItemModel item, {bool isIncrement = true}) async {
    _currentMonth.update(item.toIncrementJson(isIncrement: isIncrement));
  }

  Future<void> increaseDay(ItemModel item, {bool isIncrement = true}) async {
    _currentDay.update(item.toIncrementJson(isIncrement: isIncrement));
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
    final value = await _currentDay.get();
    if (value.exists) return;
    final data = DayModel(id: _timestamp.day, date: _timestamp);
    _currentDay.set(data.toJson());
  }
}
