import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/model/total_expanses.dart';
import 'package:expenses/src/ui/screen/main_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final timestamp = Timestamp.now();
    FirebaseFirestore.instance
        .collection(TotalExpenses.collection)
        .doc(timestamp.toYM())
        .get()
        .then((value) {
      if (!value.exists) {
        final expanses = TotalExpenses(
          id: timestamp.seconds,
          date: timestamp,
          lastUpdate: timestamp,
        );
        FirebaseFirestore.instance
            .collection(TotalExpenses.collection)
            .doc(timestamp.toYM())
            .set(expanses.toJson())
            .whenComplete(() => _pushToMainScreen());
        return;
      }
      _pushToMainScreen();
    });
    super.initState();
  }

  void _pushToMainScreen() {
    context.pushClearTop(const MainScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
