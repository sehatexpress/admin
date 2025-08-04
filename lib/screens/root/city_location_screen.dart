import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/city_location_model.dart';
import '../../providers/lists_provider.dart';
import '../../services/city_location_service.dart';
import '../../widgets/add_edit_city_location_widget.dart';

class CityLocationScreen extends ConsumerWidget {
  const CityLocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(getCityLocationListProvider);

    void showForm(CityLocationModel? location) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 24,
            ),
            child: AddEditCityLocationWidget(location: location),
          );
        },
      );
    }

    return Scaffold(
      body: lists.when(
        data: (locations) {
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
                              onPressed: () => showForm(location),
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
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showForm(null),
      ),
    );
  }
}
