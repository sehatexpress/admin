import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/lists_provider.dart';
import '../generic/loader_widget.dart';

class ChooseCity extends ConsumerWidget {
  final ValueNotifier<List<String>> cities;
  const ChooseCity({super.key, required this.cities});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citiesListener = ref.watch(citySettingListProvider);
    return citiesListener.when(
      data: (data) => StaggeredGrid.count(
        crossAxisCount: 3,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        children: List.generate(
          data.length,
          (i) {
            final city = data[i].id;
            return Row(
              children: [
                Container(
                  width: 24,
                  height: 20,
                  margin: const EdgeInsets.only(right: 12),
                  child: Checkbox(
                    value: cities.value.contains(city),
                    onChanged: (x) {
                      if (cities.value.contains(city)) {
                        cities.value = [...cities.value..remove(city)];
                      } else {
                        cities.value = [...cities.value..add(city)];
                      }
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                Text(city.toUpperCase()),
              ],
            );
          },
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Text(
          'Error loading cities: $error',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      loading: () => const Center(
        child: LoaderWidget(),
      ),
    );
  }
}
