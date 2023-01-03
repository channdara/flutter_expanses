import 'package:cloud_firestore/cloud_firestore.dart';

class SavingService {
  factory SavingService() => _singleton;

  SavingService._internal();

  static final SavingService _singleton = SavingService._internal();

  Timestamp get _timestamp => Timestamp.now();
}
