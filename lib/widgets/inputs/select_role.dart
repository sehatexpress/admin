import 'package:flutter/material.dart';

import '../../config/enums.dart';
import '../../config/utils.dart';

class SelectRole extends StatelessWidget {
  final RoleEnum role;
  final Function(RoleEnum?) onChanged;
  const SelectRole({
    super.key,
    required this.role,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<RoleEnum>(
      value: role,
      isDense: true,
      isExpanded: true,
      hint: const Text('ROLE*'),
      style: textDecorationTextStyle(Colors.black),
      items: [RoleEnum.admin, RoleEnum.sub_admin, RoleEnum.accountant]
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.name.toUpperCase()),
              ))
          .toList(),
      onChanged: onChanged,
      validator: (x) => x != null ? null : 'Select committion type!',
    );
  }
}
