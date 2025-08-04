import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/category_model.dart';
import '../services/category_service.dart';

class AddEditCategoryWidget extends HookConsumerWidget {
  final CategoryModel? category;
  const AddEditCategoryWidget({super.key, this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var formKey = useMemoized(() => GlobalKey<FormState>());
    final name = useTextEditingController(text: category?.name ?? '');
    final description = useTextEditingController(
      text: category?.description ?? '',
    );
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: name,
            decoration: const InputDecoration(labelText: 'Category Name'),
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
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                formKey.currentState?.save();
                final image =
                    'https://media.istockphoto.com/id/1356118511/photo/smart-city-and-abstract-dot-point-connect-with-gradient-line.jpg';
                if (category == null) {
                  ref
                      .read(categoryServiceProvider)
                      .addCategory(
                        name: name.text.trim(),
                        description: description.text.trim(),
                        image: image,
                      );
                } else {
                  ref
                      .read(categoryServiceProvider)
                      .updateCategory(
                        id: category!.id,
                        name: name.text.trim(),
                        description: description.text.trim(),
                        image: image,
                      );
                }
              }
            },
            child: Text('${category == null ? 'Add' : 'Edit'} Category'),
          ),
        ],
      ),
    );
  }
}
