import 'package:flutter/material.dart';

mixin ColorConstant {
  static const Color colorBlack = Color(0xFF0E102D);
  static const Color colorDarkGray = Color(0xFF56586B);
  static const Color colorGray = Color(0xFFB7B7C0);
  static const Color colorLightGray = Color(0xFFE7E7EA);
  static const Color colorPrimary = Color(0xFFF2BE3E);
  static const Color colorSuccess = Color(0xFF4BB543);
  static const Color colorFailed = Color(0xFFFA113D);
  static const Color colorWarning = Color(0xFFFFCC00);
  static const MaterialColor materialColor = MaterialColor(0xFFF2BE3E, {
    50: Color(0xFFFFFCF6),
    100: Color(0xFFFEF9EC),
    200: Color(0xFFFCEFCF),
    300: Color(0xFFFAE5B0),
    400: Color(0xFFF6D278),
    500: Color(0xFFF2BE3E),
    600: Color(0xFFD8AA38),
    700: Color(0xFF927226),
    800: Color(0xFF6D561C),
    900: Color(0xFF473812),
  });
}
