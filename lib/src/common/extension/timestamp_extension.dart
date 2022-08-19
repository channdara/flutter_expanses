import 'package:cloud_firestore/cloud_firestore.dart';

extension TimestampExtension on Timestamp {
  String toYM() => '${toDate().year}-${toDate().month}';
}
