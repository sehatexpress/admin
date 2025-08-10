import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/utils.dart';

class DescriptionInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? minLines;
  final int? maxLines;
  final bool required;
  const DescriptionInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.minLines = 1,
    this.maxLines = 10,
    this.required = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      minLines: minLines,
      maxLines: maxLines,
      style: textDecorationTextStyle(ColorConstants.textColor),
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
      ),
      validator: required ? (x) => x == null || x.isEmpty ? '' : null : null,
    );
  }
}
