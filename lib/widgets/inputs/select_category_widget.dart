import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/lists_provider.dart';
import '../generic/data_view_widget.dart';

class SelectCategoryWidget extends ConsumerWidget {
  final String? value;
  final Function(String?)? onChanged;
  const SelectCategoryWidget({super.key, this.value, this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DataViewWidget(
      provider: getCategoriesListProvider,
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
          decoration: InputDecoration(labelText: 'Select Category'),
          validator: (x) => x == null || x.isEmpty ? '' : null,
        );
      },
    );
  }
}
