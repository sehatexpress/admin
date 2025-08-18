import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config/extensions.dart';
import '../../../providers/lists_provider.dart';
import '../../../services/menu_service.dart';
import '../../../widgets/forms/add_edit_menu_widget.dart';
import '../../../widgets/generic/data_view_widget.dart';

class MenusScreen extends ConsumerWidget {
  const MenusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: DataViewWidget(
        provider: getMenusListProvider,
        dataBuilder: (menus) {
          return menus.isNotEmpty
              ? ListView.builder(
                  itemCount: menus.length,
                  itemBuilder: (context, index) {
                    final menu = menus[index];
                    return ListTile(
                      title: Text(menu.name),
                      subtitle: Text(menu.description),
                      trailing: SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_rounded),
                              onPressed: () => context.showAppBottomSheet(
                                child: AddEditMenuWidget(menu: menu),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_rounded),
                              onPressed: () => context
                                  .showGenericDialog(
                                    title: 'Delete',
                                    content:
                                        'Are you sure, you want to delete the menu?',
                                  )
                                  .then((res) {
                                    if (res == true) {
                                      ref
                                          .read(menuServiceProvider)
                                          .deleteMenu(menu.id);
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text('No menus available.'));
        },
      ),
      floatingActionButton: context.fabTo(
        () => context.showAppBottomSheet(
          isScrollControlled: true,
          child: AddEditMenuWidget(),
        ),
      ),
    );
  }
}
