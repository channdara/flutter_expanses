import 'package:expenses/src/service/firestore_service.dart';
import 'package:flutter/widgets.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  @protected
  final FirestoreService firebaseService = FirestoreService();
}
