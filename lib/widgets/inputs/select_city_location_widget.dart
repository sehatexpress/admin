import 'package:admin/widgets/generic/data_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/lists_provider.dart';

class SelectCityLocationWidget extends ConsumerWidget {
  final String? value;
  final Function(String?)? onChanged;
  const SelectCityLocationWidget({super.key, this.value, this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DataViewWidget(
      provider: getCityLocationListProvider,
      dataBuilder: (cities) {
        return DropdownButtonFormField<String>(
          value: value,
          items: cities.map((city) {
            return DropdownMenuItem<String>(
              value: city.id,
              child: Text(city.name.toUpperCase()),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(labelText: 'Select City Location'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a city location';
            }
            return null;
          },
        );
      },
    );
  }
}
