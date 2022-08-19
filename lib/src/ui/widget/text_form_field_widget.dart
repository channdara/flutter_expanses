import 'package:expenses/src/common/extension/double_extension.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    this.labelText,
    this.prefixIcon,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.validator,
    this.textCapitalization,
  }) : super(key: key);

  final String? labelText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final TextCapitalization? textCapitalization;

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
    );
  }
}
