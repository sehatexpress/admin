import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/constants.dart';
import '../../config/utils.dart';

class NumberInput extends StatelessWidget {
  final bool required;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String hintText;
  const NumberInput({
    super.key,
    this.required = true,
    required this.controller,
    this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
        FilteringTextInputFormatter.digitsOnly,
      ],
      validator: required ? (x) => x == null || x.isEmpty ? '' : null : null,
      onChanged: onChanged,
      style: textDecorationTextStyle(ColorConstants.textColor),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        errorStyle: const TextStyle(height: 0),
      ),
    );
  }
}
