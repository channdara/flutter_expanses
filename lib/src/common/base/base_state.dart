import 'package:flutter/widgets.dart';

import '../../service/firestore_service.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  @protected
  final FirestoreService firestoreService = FirestoreService();

  Future<void> awaitSetState() async =>
      Future<void>.delayed(const Duration(seconds: 1), () {
        setState(() {});
      });
}
