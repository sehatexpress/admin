import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../config/extensions.dart';
import '../../providers/lists_provider.dart';
import '../../services/category_service.dart';
import '../../widgets/forms/add_edit_category_widget.dart';
import '../../widgets/generic/custom_image_provider.dart';
import '../../widgets/generic/data_view_widget.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: DataViewWidget(
        provider: getCategoriesListProvider,
        dataBuilder: (categories) {
          return categories.isNotEmpty
              ? SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: List.generate(categories.length, (i) {
                      final category = categories[i];
                      return Container(
                        decoration: BoxDecoration(
                          color: randomLightColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CustomImageProvider(
                                  image: randomImage,
                                  width: double.infinity,
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: context.popupMenuButton(
                                    popupBackgroundColor: Colors.white,
                                    buttonBackgroundColor: Colors.white,
                                    items: {
                                      'edit': 'Edit',
                                      'delete': 'Delete',
                                      'details': 'View Details',
                                    },
                                    onSelected: (value) {
                                      switch (value) {
                                        case 'edit':
                                          context.showAppBottomSheet(
                                            child: AddEditCategoryWidget(
                                              category: category,
                                            ),
                                          );
                                          break;
                                        case 'delete':
                                          context
                                              .showGenericDialog(
                                                title: 'Delete',
                                                content:
                                                    'Are you sure, you want to delete this category?',
                                              )
                                              .then((res) {
                                                if (res == true) {
                                                  ref
                                                      .read(
                                                        categoryServiceProvider,
                                                      )
                                                      .deleteCategory(
                                                        category.id,
                                                      );
                                                }
                                              });
                                          break;
                                        case 'details':
                                          print('Details tapped');
                                          break;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category.name.capitalize,
                                    maxLines: 1,
                                    style: context.text.labelMedium?.copyWith(
                                      height: 1.1,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    category.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.text.labelSmall?.copyWith(
                                      height: 1.2,
                                      fontSize: 10,
                                      color: ColorConstants.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                )
              : const Center(child: Text('No categories available.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.showAppBottomSheet(
          child: AddEditCategoryWidget(category: null),
        ),
        child: Icon(Icons.add_rounded),
      ),
    );
  }
}
