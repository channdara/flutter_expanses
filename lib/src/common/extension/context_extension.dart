import 'package:flutter/material.dart';

import '../color_constant.dart';

extension ContextExtension on BuildContext {
  Future<void> push(StatefulWidget screen) async {
    await Navigator.of(this).push(MaterialPageRoute(builder: (_) => screen));
  }

  void pop() {
    Navigator.of(this).pop();
  }

  void pushReplacement(StatefulWidget screen) {
    Navigator.of(this)
        .pushReplacement(MaterialPageRoute(builder: (_) => screen));
  }

  void pushClearTop(StatefulWidget screen) {
    Navigator.of(this).popUntil((route) => route.isFirst);
    pushReplacement(screen);
  }

  void showErrorSnackBar(String content) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      backgroundColor: ColorConstant.colorFailed,
      content: Text(content),
    ));
  }

  void showSuccessSnackBar(String content) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      backgroundColor: ColorConstant.colorSuccess,
      content: Text(content),
    ));
  }
}
