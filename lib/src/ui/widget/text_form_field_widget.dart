import 'package:flutter/material.dart';

import '../../common/extension/double_extension.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.validator,
    this.textCapitalization,
    this.enabled,
  });

  final String? labelText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final TextCapitalization? textCapitalization;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: 16.0.spacingHorizontal(),
        border: OutlineInputBorder(borderRadius: 12.0.circular()),
        labelText: labelText,
        prefixIcon: prefixIcon,
      ),
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      validator: validator,
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      enabled: enabled,
    );
  }
}
