import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/extensions.dart';

class SelectionDropdown<T> extends StatelessWidget {
  final String label;
  final String? value;
  final List<T> items;
  final String Function(T) getLabel;
  final String Function(T) getValue;
  final void Function(String?)? onChanged;

  const SelectionDropdown({
    super.key,
    required this.label,
    this.value,
    required this.items,
    required this.getLabel,
    required this.getValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isDense: true,
      value: value,
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: getValue(item),
              child: Text(
                getLabel(item).toUpperCase(),
                style: context.text.labelMedium?.copyWith(
                  color: ColorConstants.textColor,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      style: context.text.labelMedium?.copyWith(
        color: ColorConstants.textColor,
      ),
      padding: EdgeInsets.zero,
      decoration: InputDecoration(
        labelText: label,
        hintText: 'Select $label',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select $label';
        }
        return null;
      },
    );
  }
}
