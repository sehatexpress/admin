import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../config/constants.dart';
import '../../config/utils.dart';

class DateInput extends HookWidget {
  final bool required;
  final String? initialValue;
  final Function(String?) onTap;
  final String hintText;
  const DateInput({
    super.key,
    this.required = true,
    this.initialValue,
    this.hintText = 'Select Date*',
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var now = useState<DateTime>(DateTime.now());
    return TextFormField(
      readOnly: true,
      initialValue: initialValue,
      keyboardType: TextInputType.text,
      style: textDecorationTextStyle(ColorConstants.textColor),
      onTap: () => showDatePicker(
        context: context,
        // firstDate: now.value,
        // lastDate: DateTime(2100),
        firstDate: DateTime(2000),
        lastDate: now.value,
      ).then((x) => x != null ? onTap(x.toString().split(' ').first) : null),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
      ),
      validator: (x) => required && (x == null || x.isEmpty) ? '' : null,
    );
  }
}
