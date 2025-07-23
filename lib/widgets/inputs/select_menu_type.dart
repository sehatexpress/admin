import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/enums.dart';
import '../../config/utils.dart';

class SelectMenuType extends StatelessWidget {
  final MenuTypeEnum? value;
  final Function(MenuTypeEnum?)? onChanged;
  const SelectMenuType({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isDense: true,
      value: value,
      hint: const Text('Menu Type*'),
      style: textDecorationTextStyle(ColorConstants.textColor),
      iconSize: 18,
      items: MenuTypeEnum.values
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.name.toUpperCase()),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText: 'Select...',
        labelText: 'Select Menu Type*',
        prefixIconConstraints: BoxConstraints(
          maxHeight: 40,
        ),
        suffixIconConstraints: BoxConstraints(
          maxHeight: 40,
        ),
      ),
    );
  }
}
