import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/lists_provider.dart';
import '../generic/data_view_widget.dart';

class SelectCityWidget extends ConsumerWidget {
  final String? value;
  final Function(String?)? onChanged;
  final bool required;
  const SelectCityWidget({
    super.key,
    this.value,
    this.onChanged,
    this.required = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DataViewWidget(
      provider: getCitiesListProvider,
      dataBuilder: (cities) {
        return DropdownButtonFormField<String>(
          isDense: true,
          value: value,
          dropdownColor: Colors.blue,
          focusColor: Colors.amber,
          items: cities.map((city) {
            return DropdownMenuItem<String>(
              value: city.id,
              child: Text(city.name.toUpperCase()),
            );
          }).toList(),
          onChanged: onChanged,
          iconSize: 20,
          decoration: const InputDecoration(labelText: 'Select City'),
          validator: required
              ? (x) => x == null || x.isEmpty ? '' : null
              : null,
        );
      },
    );
  }
}
