import 'package:flutter/material.dart';

import '../../../common/base/base_state.dart';
import '../../../common/extension/context_extension.dart';
import '../../widget/custom_app_bar.dart';
import '../add_saving_screen/add_saving_screen.dart';

class SavingScreen extends StatefulWidget {
  const SavingScreen({super.key});

  @override
  State<SavingScreen> createState() => _SavingScreenState();
}

class _SavingScreenState extends BaseState<SavingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 2,
        child: const Icon(Icons.add),
        onPressed: () => context.push(const AddSavingScreen()),
      ),
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
