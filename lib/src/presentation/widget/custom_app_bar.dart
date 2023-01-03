import 'package:flutter/material.dart';

import '../../common/color_constant.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.child,
    this.overrideChildMargin,
    this.label,
  });

  final Widget? child;
  final EdgeInsetsGeometry? overrideChildMargin;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 3;
    return Stack(
      children: [
        Container(height: size, color: ColorConstant.colorPrimary),
        if ((label ?? '').isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: size - 30.0, left: 16.0),
            child: Text(label!, style: const TextStyle(fontSize: 20.0)),
          ),
        Container(
          margin: overrideChildMargin ?? EdgeInsets.only(top: size / 2),
          child: child,
        ),
      ],
    );
  }
}
