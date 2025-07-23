import 'package:flutter/material.dart';

import '../../config/enums.dart';
import '../../config/utils.dart';

class SelectCommission extends StatelessWidget {
  final CommissionTypeEnum? value;
  final Function(CommissionTypeEnum?)? onChanged;
  const SelectCommission({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: value,
      isDense: true,
      isExpanded: true,
      hint: const Text('Commission Type*'),
      decoration: const InputDecoration(
        hintText: 'Commission Type*',
        labelText: 'Commission Type*',
      ),
      style: textDecorationTextStyle(Colors.black),
      items: CommissionTypeEnum.values
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.name.toUpperCase()),
              ))
          .toList(),
      onChanged: onChanged,
      validator: (x) => x != null ? null : '',
    );
  }
}
