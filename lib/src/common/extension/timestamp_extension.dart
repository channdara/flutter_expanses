import 'package:cloud_firestore/cloud_firestore.dart';

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
}
