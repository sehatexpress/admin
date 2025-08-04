import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/menu_model.dart';
import '../../../providers/lists_provider.dart';
import '../../../services/menu_service.dart';
import '../../../widgets/add_edit_menu_widget.dart';

class MenusScreen extends ConsumerWidget {
  const MenusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(getMenusListProvider);

    void showForm(MenuModel? menu) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 24,
            ),
            child: AddEditMenuWidget(menu: menu),
          );
        },
      );
    }

    return Scaffold(
      body: lists.when(
        data: (menus) {
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
                              onPressed: () => showForm(menu),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_rounded),
                              onPressed: () {
                                ref
                                    .read(menuServiceProvider)
                                    .deleteMenu(menu.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text('No menus available.'));
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showForm(null),
        child: Icon(Icons.add_rounded),
      ),
    );
  }
}
