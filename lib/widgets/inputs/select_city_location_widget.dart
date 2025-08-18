import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/city_location_model.dart';
import '../../providers/lists_provider.dart';
import '../generic/data_view_widget.dart';
import 'selection_dropdown.dart';

class SelectCityLocationWidget extends ConsumerWidget {
  final String? value;
  final Function(String?)? onChanged;
  const SelectCityLocationWidget({super.key, this.value, this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DataViewWidget(
      provider: getCityLocationListProvider,
      dataBuilder: (lists) {
        return SelectionDropdown<CityLocationModel>(
          label: "City Location",
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
