import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/common/extension/timestamp_extension.dart';
import 'package:expenses/src/model/total_expanses.dart';
import 'package:expenses/src/ui/screen/daily_expenses_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _getCurrentMonthTotalExpenses();
    super.initState();
  }

  void _getCurrentMonthTotalExpenses() {
    final timestamp = Timestamp.now();
    FirebaseFirestore.instance
        .collection(TotalExpenses.collectionMonthly)
        .doc(timestamp.toYearMonth())
        .get()
        .then((value) {
      if (!value.exists) {
        final expanses = TotalExpenses(
          id: timestamp.toYearMonth(),
          date: timestamp,
          lastUpdate: timestamp,
        );
        FirebaseFirestore.instance
            .collection(TotalExpenses.collectionMonthly)
            .doc(timestamp.toYearMonth())
            .set(expanses.toJson());
      }
      _getCurrentDayExpenses();
    });
  }

  void _getCurrentDayExpenses() {
    final timestamp = Timestamp.now();
    FirebaseFirestore.instance
        .collection(TotalExpenses.collectionDaily)
        .doc(timestamp.toYearMonthDay())
        .get()
        .then((value) {
      if (!value.exists) {
        final expanses = TotalExpenses(
          id: timestamp.toYearMonthDay(),
          date: timestamp,
          lastUpdate: timestamp,
        );
        FirebaseFirestore.instance
            .collection(TotalExpenses.collectionDaily)
            .doc(timestamp.toYearMonthDay())
            .set(expanses.toJson())
            .whenComplete(() => _pushToMainScreen());
        return;
      }
      _pushToMainScreen();
    });
  }

  void _pushToMainScreen() {
    context.pushClearTop(const DailyExpensesScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
