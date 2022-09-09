import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../common/base/base_state.dart';
import '../../common/extension/context_extension.dart';
import 'daily_expenses_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  @override
  void initState() {
    firebaseService.checkCurrentDate().whenComplete(() {
      final Timestamp date = Timestamp.now();
      context.pushClearTop(DailyExpensesScreen(date: date));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).primaryColor);
  }
}
