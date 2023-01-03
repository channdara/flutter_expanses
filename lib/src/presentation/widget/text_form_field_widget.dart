import 'package:flutter/material.dart';

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
    this.onEditingComplete,
  });

  final String? labelText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final TextCapitalization? textCapitalization;
  final bool? enabled;
  final VoidCallback? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        labelText: labelText,
        prefixIcon: prefixIcon,
      ),
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      validator: validator,
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      enabled: enabled,
      onEditingComplete: onEditingComplete,
    );
  }
}
