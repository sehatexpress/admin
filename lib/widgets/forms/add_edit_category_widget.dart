import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/extensions.dart';
import '../../models/category_model.dart';
import '../../services/category_service.dart';
import '../generic/image_selector_widget.dart';
import '../generic/submit_button.dart';
import '../inputs/description_input.dart';
import '../inputs/text_input.dart';

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
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageSelectorWidget(initialImageUrl: category?.image),
          TextInputWidget(controller: name, hintText: 'Category Name'),
          DescriptionInput(controller: description, hintText: 'Description*'),
          SubmitButton(
            title: '${category == null ? 'Add' : 'Edit'} Category',
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                ref.withLoading(() async {
                  formKey.currentState?.save();
                  final image =
                      'https://t4.ftcdn.net/jpg/00/81/38/59/360_F_81385977_wNaDMtgrIj5uU5QEQLcC9UNzkJc57xbu.jpg';
                  if (category == null) {
                    await ref
                        .read(categoryServiceProvider)
                        .addCategory(
                          name: name.text.trim(),
                          description: description.text.trim(),
                          image: image,
                        );
                  } else {
                    await ref
                        .read(categoryServiceProvider)
                        .updateCategory(
                          id: category!.id,
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
