import 'package:flutter/material.dart';

import '../../../common/color_constant.dart';

class SavingScreen extends StatefulWidget {
  const SavingScreen({super.key});

  @override
  State<SavingScreen> createState() => _SavingScreenState();
}

class _SavingScreenState extends State<SavingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 3;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(height: size, color: ColorConstant.colorPrimary),
            ],
          ),
          const Expanded(
            child: Center(
              child: Text('To be implement soon!'),
            ),
          ),
        ],
      ),
    );
  }
}