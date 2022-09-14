extension IntExtension on int {
  String padLeft([int width = 2, String padding = '0']) =>
      toString().padLeft(width, padding);
}
