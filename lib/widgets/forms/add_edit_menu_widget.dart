import 'package:admin/config/extensions.dart';
import 'package:admin/widgets/generic/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/menu_model.dart';
import '../../services/menu_service.dart';
import '../inputs/description_input.dart';
import '../inputs/number_input.dart';
import '../inputs/select_category_widget.dart';
import '../inputs/select_city_location_widget.dart';
import '../inputs/select_city_widget.dart';
import '../inputs/text_input.dart';
import 'add_nutrition_widget.dart';

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
    final nutritions = useState<Map<String, String>>(menu?.nutritions ?? {});
    return Form(
      key: formKey,
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectCategoryWidget(
            value: categoryId.value,
            onChanged: (x) {
              categoryId.value = x;
            },
          ),
          Row(
            spacing: 8,
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
          TextInputWidget(controller: name, hintText: 'Menu Name'),
          DescriptionInput(controller: description, hintText: 'Description'),
          Row(
            children: [
              Expanded(
                child: NumberInput(
                  controller: price,
                  hintText: 'Enter Quantity',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: NumberInput(
                  controller: quantity,
                  hintText: 'Enter Quantity',
                ),
              ),
            ],
          ),
          AddNutritionWidget(nutritions: nutritions),
          SizedBox(
            width: double.infinity,
            child: SubmitButton(
              title: '${menu == null ? 'Add' : 'Edit'} Menu',
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  ref.withLoading(() async {
                    formKey.currentState?.save();
                    final image =
                        'https://t4.ftcdn.net/jpg/00/81/38/59/360_F_81385977_wNaDMtgrIj5uU5QEQLcC9UNzkJc57xbu.jpg';
                    if (menu == null) {
                      await ref
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
                            nutritions: nutritions.value,
                          );
                    } else {
                      await ref
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
                            nutritions: nutritions.value,
                          );
                    }
                    context.pop();
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
