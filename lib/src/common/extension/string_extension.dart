extension StringExtension on String {
  double toDouble() => double.tryParse(this) ?? 0.0;

  int toInt() => int.tryParse(this) ?? 0;

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
