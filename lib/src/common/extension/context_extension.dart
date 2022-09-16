import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void push(StatefulWidget screen) {
    Navigator.of(this).push(MaterialPageRoute(builder: (_) => screen));
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
      backgroundColor: Colors.red,
      content: Text('ERROR: $content'),
    ));
  }

  void showSuccessSnackBar(String content) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text('SUCCESS: $content'),
    ));
  }
}
