import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/city_model.dart';
import '../../services/city_service.dart';
import '../inputs/description_input.dart';
import '../inputs/text_input.dart';

class AddEditCityWidget extends HookConsumerWidget {
  final CityModel? city;
  const AddEditCityWidget({super.key, this.city});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var formKey = useMemoized(() => GlobalKey<FormState>());
    final name = useTextEditingController(text: city?.name ?? '');
    final description = useTextEditingController(text: city?.description ?? '');
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextInputWidget(controller: name, hintText: 'City Name'),
          const SizedBox(height: 12),
          DescriptionInput(controller: description, hintText: 'Description'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                formKey.currentState?.save();
                final image =
                    'https://t4.ftcdn.net/jpg/00/81/38/59/360_F_81385977_wNaDMtgrIj5uU5QEQLcC9UNzkJc57xbu.jpg';
                if (city == null) {
                  ref
                      .read(cityServiceProvider)
                      .addCity(
                        name: name.text.trim(),
                        description: description.text.trim(),
                        image: image,
                      );
                } else {
                  ref
                      .read(cityServiceProvider)
                      .updateCity(
                        id: city!.id,
                        name: name.text.trim(),
                        description: description.text.trim(),
                        image: image,
                      );
                }
              }
            },
            child: Text(city == null ? 'Add City' : 'Edit City'),
          ),
        ],
      ),
    );
  }
}
