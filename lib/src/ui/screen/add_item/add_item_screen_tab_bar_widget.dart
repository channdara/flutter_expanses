import 'package:flutter/material.dart';

import '../../../common/extension/string_extension.dart';
import '../../../model/enum/item_type.dart';

class AddItemScreenTabBarWidget extends StatelessWidget {
  const AddItemScreenTabBarWidget({super.key, required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: _color(),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade700,
        tabs: ItemType.values
            .map((e) => Tab(text: e.name.toCapitalized()))
            .toList(),
      ),
    );
  }

  Color _color() {
    switch (controller.index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.pinkAccent;
      default:
        return Colors.green;
    }
  }
}
