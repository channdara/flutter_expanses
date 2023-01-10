import 'package:flutter/cupertino.dart';

import '../../../model/saving_model.dart';
import 'saving_screen_list_item.dart';

class SavingScreenList extends StatelessWidget {
  const SavingScreenList({super.key, required this.docs});

  final List<SavingModel> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16.0, bottom: 70.0),
      itemCount: docs.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = docs[index];
        if (item == null) return const SizedBox();
        return SavingScreenListItem(item: item);
      },
    );
  }
}
