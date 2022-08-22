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
    firebaseService
        .checkCurrentDate()
        .whenComplete(() => context.pushClearTop(const DailyExpensesScreen()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
