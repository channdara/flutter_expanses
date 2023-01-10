import 'package:flutter/material.dart';

import '../../../common/base/base_state.dart';
import '../../../common/extension/context_extension.dart';
import '../../../model/saving_model.dart';
import '../../widget/custom_app_bar.dart';
import '../add_saving_screen/add_saving_screen.dart';
import 'saving_screen_list.dart';

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
        children: [
          FutureBuilder<String>(
            future: savingService.getTotalSaving(),
            builder: (context, snapshot) {
              return CustomAppBar(label: 'My Saving: ${snapshot.data}');
            },
          ),
          Expanded(
            child: FutureBuilder<List<SavingModel>>(
              future: savingService.getPurchasedItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data == null) return const SizedBox();
                return RefreshIndicator(
                  onRefresh: awaitSetState,
                  child: SavingScreenList(docs: snapshot.data!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
