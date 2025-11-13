import 'package:admin/config/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/city_model.dart';
import '../../services/city_service.dart';
import '../generic/submit_button.dart';
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
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInputWidget(controller: name, hintText: 'City Name'),
          DescriptionInput(controller: description, hintText: 'Description'),
          SubmitButton(
            title: city == null ? 'Add City' : 'Edit City',
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                ref.withLoading(() async {
                  formKey.currentState?.save();
                  final image =
                      'https://t4.ftcdn.net/jpg/00/81/38/59/360_F_81385977_wNaDMtgrIj5uU5QEQLcC9UNzkJc57xbu.jpg';
                  if (city == null) {
                    await ref
                        .read(cityServiceProvider)
                        .addCity(
                          name: name.text.trim(),
                          description: description.text.trim(),
                          image: image,
                        );
                  } else {
                    await ref
                        .read(cityServiceProvider)
                        .updateCity(
                          id: city!.id,
                          name: name.text.trim(),
                          description: description.text.trim(),
                          image: image,
                        );
                  }
                  context.pop();
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
