import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/extensions.dart';
import '../../config/utils.dart';

class MobileInput extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final String hintText;
  const MobileInput({
    super.key,
    required this.controller,
    this.enabled = true,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 10,
      enabled: enabled,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
        FilteringTextInputFormatter.digitsOnly,
      ],
      style: textDecorationTextStyle(Colors.black),
      decoration: InputDecoration(
        counterText: '',
        hintText: hintText,
        labelText: hintText,
        errorStyle: const TextStyle(height: 0),
      ),
      validator: (x) => x?.validatePhone,
    );
  }
}
