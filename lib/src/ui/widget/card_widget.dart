import 'package:flutter/material.dart';

import '../../common/extension/double_extension.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    this.margin,
    this.child,
  });

  final EdgeInsetsGeometry? margin;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: 12.0.circular()),
      child: child,
    );
  }
}
