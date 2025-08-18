import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/city_model.dart';
import '../../providers/lists_provider.dart';
import '../generic/data_view_widget.dart';
import 'selection_dropdown.dart';

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
      dataBuilder: (lists) {
        return SelectionDropdown<CityModel>(
          label: "City*",
          value: value,
          items: lists,
          getLabel: (x) => x.name,
          getValue: (x) => x.id,
          onChanged: onChanged,
        );
      },
    );
  }
}
