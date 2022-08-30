import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

extension TimestampExtension on Timestamp {
  String getYear() => year.toString();

  String getMonth() => month < 10 ? '0$month' : month.toString();

  String getDay() => day < 10 ? '0$day' : day.toString();

  String getHour() => hour < 10 ? '0$hour' : hour.toString();

  String getMinute() => minute < 10 ? '0$minute' : minute.toString();

  String toYearMonth() => '$year-${getMonth()}';

  String toYearMonthDay() => '${toYearMonth()}-${getDay()}';

  String toMonthDay() => '${getMonth()}-${getDay()}';

  String toHourMinute() => '${getHour()}:${getMinute()}';

  int get year => toDate().year;

  int get month => toDate().month;

  int get day => toDate().day;

  int get hour => toDate().hour;

  int get minute => toDate().minute;

  bool get isToday => toMonthDay() == Timestamp.now().toMonthDay();

  MaterialColor getDayOfWeekColor() {
    switch (toDate().weekday) {
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.pink;
      case 3:
        return Colors.green;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.blue;
      case 6:
        return Colors.purple;
      case 7:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
