import 'package:cloud_firestore/cloud_firestore.dart';

extension TimestampExtension on Timestamp {
  String _getMonth() =>
      toDate().month < 10 ? '0${toDate().month}' : toDate().month.toString();

  String _getDay() =>
      toDate().day < 10 ? '0${toDate().day}' : toDate().day.toString();

  String _getHour() =>
      toDate().hour < 10 ? '0${toDate().hour}' : toDate().hour.toString();

  String _getMinute() =>
      toDate().minute < 10 ? '0${toDate().minute}' : toDate().minute.toString();

  String toYear() => '${toDate().year}';

  String toYearMonth() => '${toYear()}-${_getMonth()}';

  String toYearMonthDay() => '${toYearMonth()}-${_getDay()}';

  String toHourMinute() => '${_getHour()}:${_getMinute()}';
}
