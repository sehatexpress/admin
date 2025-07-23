import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../config/constants.dart';
import '../../config/utils.dart';

class PasswordInput extends HookWidget {
  final TextEditingController controller;
  final String hintText;
  const PasswordInput({
    super.key,
    required this.controller,
    this.hintText = 'Enter Password*',
  });

  @override
  Widget build(BuildContext context) {
    final hide = useState(true);
    return TextFormField(
      obscureText: hide.value,
      autocorrect: false,
      enableSuggestions: false,
      style: textDecorationTextStyle(ColorConstants.textColor),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 40,
        ),
        suffixIcon: Container(
          margin: const EdgeInsets.only(left: 10, right: 16),
          child: GestureDetector(
            onTap: () => hide.value = !hide.value,
            child: Icon(
              !hide.value ? Icons.visibility_off : Icons.visibility,
              size: 20,
              color: ColorConstants.primary,
            ),
          ),
        ),
      ),
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      validator: (val) =>
          val!.length < 6 ? 'Please enter 6 digit password' : null,
    );
  }
}
