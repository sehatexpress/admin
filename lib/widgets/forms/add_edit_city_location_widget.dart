import 'package:admin/config/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/city_location_model.dart';
import '../../services/city_location_service.dart';
import '../generic/submit_button.dart';
import '../inputs/description_input.dart';
import '../inputs/number_input.dart';
import '../inputs/select_city_widget.dart';
import '../inputs/text_input.dart';

class AddEditCityLocationWidget extends HookConsumerWidget {
  final CityLocationModel? location;
  const AddEditCityLocationWidget({super.key, this.location});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var formKey = useMemoized(() => GlobalKey<FormState>());
    final cityId = useState<String?>(location?.cityId);
    final name = useTextEditingController(text: location?.name ?? '');
    final description = useTextEditingController(
      text: location?.description ?? '',
    );
    final deliveryCharge = useTextEditingController(
      text: location?.deliveryCharge.toString() ?? '0',
    );
    return Form(
      key: formKey,
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectCityWidget(
            value: cityId.value,
            onChanged: (value) {
              cityId.value = value;
            },
          ),
          TextInputWidget(controller: name, hintText: 'City Name'),
          DescriptionInput(controller: description, hintText: 'Description'),
          NumberInput(controller: deliveryCharge, hintText: 'Delivery Charge'),
          SubmitButton(
            title: location == null ? 'Add City' : 'Edit City',
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                ref.withLoading(() async {
                  formKey.currentState?.save();
                  if (location == null) {
                    await ref
                        .read(cityLocationServiceProvider)
                        .addCityLocation(
                          name: name.text.trim(),
                          description: description.text.trim(),
                          cityId: cityId.value!,
                          deliveryCharge:
                              double.tryParse(deliveryCharge.text.trim()) ??
                              0.0,
                        );
                  } else {
                    await ref
                        .read(cityLocationServiceProvider)
                        .updateCityLocation(
                          id: location!.id,
                          name: name.text.trim(),
                          description: description.text.trim(),
                          cityId: cityId.value!,
                          deliveryCharge:
                              double.tryParse(deliveryCharge.text.trim()) ??
                              0.0,
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
