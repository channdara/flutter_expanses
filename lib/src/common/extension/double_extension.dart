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

  BorderRadius radiusTopLeft() =>
      BorderRadius.only(topLeft: Radius.circular(this));

  BorderRadius radiusTopRight() =>
      BorderRadius.only(topRight: Radius.circular(this));

  BorderRadius radiusBothBottom() => BorderRadius.only(
        bottomLeft: Radius.circular(this),
        bottomRight: Radius.circular(this),
      );
}

extension ListDoubleExtension on List<double> {
  EdgeInsets spacingLTRB() {
    return length < 4
        ? EdgeInsets.zero
        : EdgeInsets.fromLTRB(this[0], this[1], this[2], this[3]);
  }

  EdgeInsets spacingSymmetric() {
    return length < 2
        ? EdgeInsets.zero
        : EdgeInsets.symmetric(vertical: this[0], horizontal: this[1]);
  }

  BorderRadius borderRadius() {
    return length < 4
        ? BorderRadius.zero
        : BorderRadius.only(
            topLeft: Radius.circular(this[0]),
            topRight: Radius.circular(this[1]),
            bottomLeft: Radius.circular(this[2]),
            bottomRight: Radius.circular(this[3]),
          );
  }
}
