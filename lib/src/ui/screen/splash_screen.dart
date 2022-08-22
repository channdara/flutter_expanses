import 'package:expenses/src/common/extension/context_extension.dart';
import 'package:expenses/src/service/firestore_service.dart';
import 'package:expenses/src/ui/screen/daily_expenses_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirestoreService _service = FirestoreService();

  @override
  void initState() {
    _service
        .checkCurrentDate()
        .whenComplete(() => context.pushClearTop(const DailyExpensesScreen()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
