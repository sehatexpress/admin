import 'package:flutter/material.dart';

import '../../config/extensions.dart';
import '../../config/utils.dart';

class NameInput extends StatelessWidget {
  final bool required;
  final TextEditingController? controller;
  final bool enabled;
  final String hintText;
  final Function(String)? onFieldSubmitted;
  const NameInput({
    super.key,
    this.required = true,
    this.controller,
    this.enabled = true,
    this.hintText = 'Full Name*',
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      style: textDecorationTextStyle(Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        errorStyle: const TextStyle(height: 0),
      ),
      validator: required ? (x) => x?.validateName : null,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
