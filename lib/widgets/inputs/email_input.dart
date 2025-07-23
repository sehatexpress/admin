import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/extensions.dart';
import '../../config/utils.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool enabled;
  const EmailInput({
    super.key,
    required this.controller,
    this.enabled = true,
    this.labelText = 'Email Address*',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: textDecorationTextStyle(ColorConstants.textColor),
      decoration: InputDecoration(
        isDense: true,
        hintText: 'user@toeato.com',
        labelText: labelText,
      ),
      validator: (val) => val?.validateEmail,
    );
  }
}
