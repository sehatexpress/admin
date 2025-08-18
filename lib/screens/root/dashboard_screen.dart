import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/inputs/select_category_widget.dart';
import '../../widgets/inputs/select_city_location_widget.dart';
import '../../widgets/inputs/select_city_widget.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectCategoryWidget(onChanged: (x) {}),
          const SizedBox(height: 8),
          SelectCityWidget(onChanged: (x) {}),
          const SizedBox(height: 8),
          SelectCityLocationWidget(onChanged: (x) {}),
        ],
      ),
    );
  }
}
