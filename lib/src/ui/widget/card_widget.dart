import 'package:flutter/material.dart';

import '../../common/extension/double_extension.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    this.margin,
    this.child,
    this.borderRadius,
  });

  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final BorderRadius? borderRadius;

  BorderRadius get _borderRadius => borderRadius ?? 12.0.circular();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: _borderRadius),
      child: child,
    );
  }
}
