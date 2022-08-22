import 'package:flutter/material.dart';

extension DoubleExtension on double {
  EdgeInsets spacingAll() => EdgeInsets.all(this);

  EdgeInsets spacingLeft() => EdgeInsets.only(left: this);

  EdgeInsets spacingTop() => EdgeInsets.only(top: this);

  EdgeInsets spacingRight() => EdgeInsets.only(right: this);

  EdgeInsets spacingBottom() => EdgeInsets.only(bottom: this);

  EdgeInsets spacingHorizontal() => EdgeInsets.symmetric(horizontal: this);

  EdgeInsets spacingVertical() => EdgeInsets.symmetric(vertical: this);

  BorderRadius circular() => BorderRadius.circular(this);
}

extension ListDoubleExtension on List<double> {
  EdgeInsets spacingLTRB() {
    if (length < 4) throw Exception('List size must be equal 4');
    return EdgeInsets.fromLTRB(this[0], this[1], this[2], this[3]);
  }
}
