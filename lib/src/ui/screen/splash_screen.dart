import 'package:expenses/src/common/base/base_state.dart';
import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/ui/screen/daily_expenses_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
