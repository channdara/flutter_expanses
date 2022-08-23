import 'package:flutter/material.dart';

import '../../common/extension/double_extension.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.onPressed,
    required this.label,
    this.margin,
  });

  final String label;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            16.0.spacingVertical(),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: 12.0.circular()),
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
