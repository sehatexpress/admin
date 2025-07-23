import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/extensions.dart';
import '../../config/typo_config.dart';
import '../../models/category_model.dart';
import '../../providers/lists_provider.dart';
import '../../services/category_service.dart';
import '../../widgets/category/add_update_category_widget.dart';
import '../../widgets/generic/custom_image_provider.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesListProvider);

    return Scaffold(
      body: categoriesAsync.when(
        data: (categories) => GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (_, index) => _CategoryTile(
            category: categories[index],
            ref: ref,
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCategoryForm(context),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}

void _showCategoryForm(BuildContext context, {CategoryModel? category}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: AddUpdateCategoryWidget(category: category),
    ),
  );
}

class _CategoryTile extends StatelessWidget {
  final CategoryModel category;
  final WidgetRef ref;

  const _CategoryTile({required this.category, required this.ref});

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [Colors.black, Colors.black.withAlpha(0)],
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomImageProvider(image: category.image),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: SizedBox(
              width: 30,
              height: 30,
              child: PopupMenuButton<int>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                padding: EdgeInsets.zero,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.black54),
                ),
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 0, child: Text('Edit')),
                  PopupMenuItem(value: 1, child: Text('Delete')),
                ],
                onSelected: (value) => _handleAction(context, value),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              decoration: BoxDecoration(gradient: gradient),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name.capitalize,
                    style: typoConfig.textStyle.smallCaptionSubtitle1.copyWith(
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    category.cities.map((e) => e.toUpperCase()).join(', '),
                    style: typoConfig.textStyle.smallSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAction(BuildContext context, int value) {
    switch (value) {
      case 0:
        _showCategoryForm(context, category: category);
        break;
      case 1:
        context
            .showGenericDialog(
          title: 'Delete Category',
          content: 'Are you sure you want to delete this category?',
        )
            .then((confirmed) {
          if (confirmed == true) {
            ref.read(categoryServiceProvider).deleteCategory(
                  image: category.image,
                  doc: category.id,
                );
          }
        });
        break;
    }
  }
}
