import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/menu_model.dart';
import '../services/menu_service.dart';
import '../widgets/inputs/select_category_widget.dart';
import './inputs/select_city_location_widget.dart';
import './inputs/select_city_widget.dart';

class AddEditMenuWidget extends HookConsumerWidget {
  final MenuModel? menu;
  const AddEditMenuWidget({super.key, this.menu});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final name = useTextEditingController(text: menu?.name ?? '');
    final description = useTextEditingController(text: menu?.description ?? '');
    final categoryId = useState(menu?.categoryId);
    final cityId = useState(menu?.cityId);
    final locationId = useState(menu?.locationId);
    final price = useTextEditingController(
      text: menu?.price.toString() ?? '0.0',
    );
    final quantity = useTextEditingController(
      text: menu?.quantity.toString() ?? '0',
    );
    return Form(
      key: formKey,
      child: Column(
        children: [
          SelectCategoryWidget(
            value: categoryId.value,
            onChanged: (x) {
              categoryId.value = x;
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SelectCityWidget(
                  value: cityId.value,
                  onChanged: (x) {
                    cityId.value = x;
                    locationId.value = null;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SelectCityLocationWidget(
                  value: locationId.value,
                  onChanged: (x) {
                    locationId.value = x;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: name,
            decoration: const InputDecoration(labelText: 'Menu Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a city name';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: description,
            decoration: const InputDecoration(labelText: 'Description'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: price,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Enter Price',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: quantity,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Enter Quantity',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                formKey.currentState?.save();
                final image =
                    'https://media.istockphoto.com/id/1356118511/photo/smart-city-and-abstract-dot-point-connect-with-gradient-line.jpg';
                if (menu == null) {
                  ref
                      .read(menuServiceProvider)
                      .addMenu(
                        name: name.text.trim(),
                        description: description.text.trim(),
                        image: image,
                        categoryId: categoryId.value!,
                        price: double.tryParse(price.text.trim()) ?? 0.0,
                        cityId: cityId.value!,
                        locationId: locationId.value!,
                        quantity: int.tryParse(quantity.text.trim()) ?? 0,
                        nutritions: {},
                      );
                } else {
                  ref
                      .read(menuServiceProvider)
                      .updateMenu(
                        id: menu!.id,
                        name: name.text.trim(),
                        description: description.text.trim(),
                        image: image,
                        categoryId: categoryId.value!,
                        price: double.tryParse(price.text.trim()) ?? 0.0,
                        cityId: cityId.value!,
                        locationId: locationId.value!,
                        quantity: int.tryParse(quantity.text.trim()) ?? 0,
                        nutritions: {},
                      );
                }
              }
            },
            child: Text('${menu == null ? 'Add' : 'Edit'} Menu'),
          ),
        ],
      ),
    );
  }
}
