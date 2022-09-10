import 'package:flutter/material.dart';

import '../../common/base/base_state.dart';
import '../../common/extension/context_extension.dart';
import 'daily_expanses/daily_expenses_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  @override
  void initState() {
    firebaseService.checkCurrentDate().then((date) {
      context.pushClearTop(DailyExpensesScreen(date: date));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).primaryColor);
  }
}
