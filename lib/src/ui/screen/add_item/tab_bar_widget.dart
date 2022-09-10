import 'package:flutter/material.dart';

import '../../../common/extension/double_extension.dart';
import '../../../common/extension/string_extension.dart';
import '../../../model/enum/item_type.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key, required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 16.0.spacingVertical(),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: 12.0.circular(),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          borderRadius: 12.0.circular(),
          color: _color(),
        ),
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
        return Colors.pink;
      default:
        return Colors.green;
    }
  }
}
