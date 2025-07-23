import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../config/typo_config.dart';
import '../../models/category_model.dart';
import '../../services/category_service.dart';
import '../inputs/choose_city.dart';
import '../inputs/custom_image_picker.dart';
import '../inputs/text_input.dart';

class AddUpdateCategoryWidget extends HookConsumerWidget {
  final CategoryModel? category;
  const AddUpdateCategoryWidget({super.key, this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = useTextEditingController(text: category?.name ?? '');
    var image = useState<String?>(null);
    var cities = useState<List<String>>([]);

    final formKey = useMemoized(() => GlobalKey<FormState>());

    useEffect(() {
      if (category != null) {
        cities.value = category!.cities;
      }
      return null;
    }, []);

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInput(
            required: true,
            controller: name,
            hintText: 'Category Name*',
          ),
          const SizedBox(height: 12),
          ChooseCity(cities: cities),
          const SizedBox(height: 12),
          CustomImagePicker(
            img: category?.image,
            onChange: (x) => image.value = x,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: ColorConstants.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                if (formKey.currentState?.validate() != true) return;
                FocusScope.of(context).unfocus();

                try {
                  final svc = ref.read(categoryServiceProvider);

                  if (category == null) {
                    await svc.newCategory(
                      name: name.text.trim(),
                      image: File(image.value!),
                      cities: cities.value,
                    );
                  } else {
                    await svc.updateCategory(
                      docID: category!.id,
                      name: name.text.trim(),
                      image: image.value == null ? null : File(image.value!),
                      cities: cities.value,
                    );
                  }

                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Something went wrong: $e')),
                  );
                }
              },
              child: Text(
                'Submit',
                style: typoConfig.textStyle.largeCaptionLabel3Bold
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
