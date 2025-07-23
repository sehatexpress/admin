import 'package:flutter/material.dart';

import '../../config/utils.dart';

class TextInput extends StatelessWidget {
  final bool required;
  final TextEditingController controller;
  final bool enabled;
  final String hintText;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmit;
  final Widget? suffixIcon;
  const TextInput({
    super.key,
    this.required = false,
    required this.controller,
    this.enabled = true,
    this.hintText = 'Full Name*',
    this.onChanged,
    this.onSubmit,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: TextInputType.text,
      style: textDecorationTextStyle(Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        suffixIcon: suffixIcon,
      ),
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      validator: required ? (x) => x == null || x.isEmpty ? '' : null : null,
    );
  }
}
