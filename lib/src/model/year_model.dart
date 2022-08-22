import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/base/base_model.dart';
import 'enum/field.dart';

class YearModel extends BaseModel {
  YearModel({
    required this.id,
    required this.date,
  });

  final int id;
  final Timestamp date;

  @override
  Map<String, Object?> toJson() => {
        Field.id.name: id,
        Field.date.name: date,
      };
}
