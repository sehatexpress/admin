import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../config/extensions.dart';
import '../../config/utils.dart';
import '../../models/setting_model.dart';
import '../../providers/lists_provider.dart';
import '../generic/loader_widget.dart';

class SelectCity extends ConsumerWidget {
  final String? city;
  final Function(String?)? onChanged;
  final bool disabled;
  final bool required;

  const SelectCity({
    super.key,
    this.city,
    this.onChanged,
    this.disabled = false,
    this.required = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(citySettingListProvider);
    return notifier.when(
      data: (data) => DropdownButtonFormField<String>(
        isExpanded: true,
        value: city,
        hint: const Text('City'),
        style: textDecorationTextStyle(ColorConstants.textColor),
        decoration: const InputDecoration(
          hintText: 'Select City*',
          labelText: 'Select City*',
        ),
        items: _buildDropdownItems(data),
        selectedItemBuilder: (_) =>
            data.map((r) => Text(r.id.capitalize)).toList(),
        onChanged: disabled ? null : onChanged,
        validator: required ? (x) => x != null ? null : 'Required' : null,
      ),
      error: (err, _) => Center(
        child: Text('Error: ${err.toString()}'),
      ),
      loading: () => Center(
        child: LoaderWidget(),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(List<SettingModel> list) {
    return list.map((item) {
      return DropdownMenuItem<String>(
        value: item.id,
        child: ListTile(
          dense: true,
          title: Text(item.id.capitalize),
        ),
      );
    }).toList();
  }
}
