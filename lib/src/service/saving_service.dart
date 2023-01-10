import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/extension/timestamp_extension.dart';
import '../model/enum/collection.dart';
import '../model/enum/field.dart';
import '../model/saving_model.dart';
import '../model/year_saving_model.dart';

class SavingService {
  factory SavingService() => _singleton;

  SavingService._internal();

  static final SavingService _singleton = SavingService._internal();

  Timestamp get _timestamp => Timestamp.now();

  DocumentReference _year(Timestamp timestamp) => FirebaseFirestore.instance
      .collection(Collection.owner_saving.value)
      .doc(timestamp.getYear());

  Future<void> _checkYear() async {
    final value = await _year(_timestamp).get();
    if (value.exists) return;
    final data = YearSavingModel(id: _timestamp.year, date: _timestamp);
    await _year(_timestamp).set(data.toJson());
  }

  Future<void> checkCurrentDate() async {
    await _checkYear();
  }

  Future<void> addSaving(SavingModel saving) async {
    await _year(saving.date)
        .collection(Collection.owner_saving.value)
        .doc(saving.id.toString())
        .set(saving.toJson());
  }

  Future<void> increaseYear(
    Timestamp timestamp,
    SavingModel item, [
    bool isIncrement = true,
  ]) async {
    await _year(timestamp).update(item.toIncrementJson(isIncrement));
  }

  Future<void> updateItem(SavingModel oldItem, SavingModel newItem) async {
    await _year(oldItem.date)
        .collection(Collection.owner_saving.value)
        .doc(oldItem.id.toString())
        .update(newItem.toUpdateJson());
  }

  Future<List<SavingModel>> getPurchasedItems() async {
    final List<SavingModel> items = [];
    final yearSnapshot = await FirebaseFirestore.instance
        .collection(Collection.owner_saving.value)
        .orderBy(Field.id.name, descending: true)
        .get();
    for (final doc in yearSnapshot.docs) {
      final timestamp = Timestamp.fromDate(DateTime.parse('${doc.id}-01-01'));
      final savingSnapshot = await _year(timestamp)
          .collection(Collection.owner_saving.value)
          .orderBy(Field.id.name, descending: true)
          .get();
      for (final saving in savingSnapshot.docs) {
        final item = SavingModel.fromJson(saving.data());
        items.add(item);
      }
    }
    return items;
  }

  Future<String> getTotalSaving() async {
    double totalDollar = 0.0;
    int totalRiel = 0;
    final yearSnapshot = await FirebaseFirestore.instance
        .collection(Collection.owner_saving.value)
        .get();
    for (final year in yearSnapshot.docs) {
      final saving = YearSavingModel.fromJson(year.data());
      totalDollar += saving.amountDollar;
      totalRiel += saving.amountRiel;
    }
    return '\$${totalDollar.toStringAsFixed(2)} - ${totalRiel}r';
  }
}
