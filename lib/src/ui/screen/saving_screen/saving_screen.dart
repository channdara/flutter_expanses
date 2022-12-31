import 'package:flutter/material.dart';

import '../../widget/custom_app_bar.dart';

class SavingScreen extends StatefulWidget {
  const SavingScreen({super.key});

  @override
  State<SavingScreen> createState() => _SavingScreenState();
}

class _SavingScreenState extends State<SavingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CustomAppBar(),
          Expanded(
            child: Center(
              child: Text('To be implement soon!'),
            ),
          ),
        ],
      ),
    );
  }
}
