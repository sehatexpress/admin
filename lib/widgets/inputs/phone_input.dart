import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/constants.dart';
import '../../config/utils.dart';

class PhoneInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool enabled;
  const PhoneInput({
    super.key,
    required this.controller,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      maxLength: 10,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))],
      style: textDecorationTextStyle(ColorConstants.textColor),
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Phone Number*',
        counterText: '',
        prefixIcon: Container(
          margin: const EdgeInsets.only(left: 16, right: 10),
          child: const Icon(Icons.phone_android_rounded),
        ),
        prefixIconConstraints: const BoxConstraints(maxHeight: 40),
      ),
      validator: (val) {
        if (val != null) {
          if (RegExp(r"[0-9]{10}?").hasMatch(val)) {
            if (val.length == 10) return null;
          }
        }
        return 'Please enter 10 digit mobile number';
      },
      onChanged: onChanged,
    );
  }
}
