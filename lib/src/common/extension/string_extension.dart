extension StringExtension on String {
  double toDouble() => double.tryParse(this) ?? 0.0;

  int toInt() => int.tryParse(this) ?? 0;
}
