import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/extensions.dart';
import '../../providers/lists_provider.dart';
import '../../services/city_location_service.dart';
import '../../widgets/forms/add_edit_city_location_widget.dart';
import '../../widgets/generic/data_view_widget.dart';

class CityLocationScreen extends ConsumerWidget {
  const CityLocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: DataViewWidget(
        provider: getCityLocationListProvider,
        dataBuilder: (locations) {
          return locations.isNotEmpty
              ? ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    final location = locations[index];
                    return ListTile(
                      title: Text(location.name),
                      subtitle: Text(location.description),
                      trailing: SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_rounded),
                              onPressed: () => context.showAppBottomSheet(
                                child: AddEditCityLocationWidget(
                                  location: location,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_rounded),
                              onPressed: () {
                                ref
                                    .read(cityLocationServiceProvider)
                                    .deleteCityLocation(location.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text('No cities available.'));
        },
      ),
      floatingActionButton: context.fabTo(
        () => context.showAppBottomSheet(child: AddEditCityLocationWidget()),
      ),
    );
  }
}
