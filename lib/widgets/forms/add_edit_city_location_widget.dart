import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/city_location_model.dart';
import '../../services/city_location_service.dart';
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
        children: [
          SelectCityWidget(
            value: cityId.value,
            onChanged: (value) {
              cityId.value = value;
            },
          ),
          const SizedBox(height: 12),
          TextInputWidget(controller: name, hintText: 'City Name'),
          const SizedBox(height: 12),
          DescriptionInput(controller: description, hintText: 'Description'),
          const SizedBox(height: 12),
          NumberInput(controller: deliveryCharge, hintText: 'Delivery Charge'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                formKey.currentState?.save();
                if (location == null) {
                  ref
                      .read(cityLocationServiceProvider)
                      .addCityLocation(
                        name: name.text.trim(),
                        description: description.text.trim(),
                        cityId: cityId.value!,
                        deliveryCharge:
                            double.tryParse(deliveryCharge.text.trim()) ?? 0.0,
                      );
                } else {
                  ref
                      .read(cityLocationServiceProvider)
                      .updateCityLocation(
                        id: location!.id,
                        name: name.text.trim(),
                        description: description.text.trim(),
                        cityId: cityId.value!,
                        deliveryCharge:
                            double.tryParse(deliveryCharge.text.trim()) ?? 0.0,
                      );
                }
              }
            },
            child: Text(location == null ? 'Add City' : 'Edit City'),
          ),
        ],
      ),
    );
  }
}
