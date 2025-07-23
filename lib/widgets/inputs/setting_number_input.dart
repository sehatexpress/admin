import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/utils.dart';

class SettingNumberInput extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final String hintText;
  final int maxLength;
  const SettingNumberInput({
    super.key,
    required this.controller,
    this.enabled = true,
    required this.hintText,
    this.maxLength = 10,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      maxLength: maxLength,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
      ],
      style: textDecorationTextStyle(
        Colors.black,
        fontSize: 11,
      ),
      decoration: InputDecoration(
        isDense: true,
        counterText: '',
        hintText: hintText,
        labelText: hintText,
      ),
      validator: (x) => x != null && x.isNotEmpty ? null : '',
    );
  }
}
