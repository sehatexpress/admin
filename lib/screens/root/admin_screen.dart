import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/extensions.dart';
import '../../config/typo_config.dart';
import '../../models/admin_model.dart';
import '../../providers/lists_provider.dart';
import '../../services/cloud_functions.service.dart';
import '../../widgets/admin/add_update_admin_widget.dart';
import '../../widgets/generic/loader_widget.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminList = ref.watch(adminsListProvider);
    return Scaffold(
      body: adminList.when(
        data: (list) => ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          separatorBuilder: (_, i) => const SizedBox(height: 10),
          itemBuilder: (_, i) {
            var user = list[i];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.name}, ${user.mobile}',
                          style: typoConfig.textStyle.smallCaptionSubtitle1,
                        ),
                        const SizedBox(height: 3),
                        RichText(
                          text: TextSpan(
                            text: '${user.email}, ',
                            style: typoConfig.textStyle.smallSmall,
                            children: [
                              TextSpan(
                                text: user.city.toUpperCase(),
                                style: typoConfig.textStyle.smallSmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<int>(
                    onSelected: (val) {
                      switch (val) {
                        case 0:
                          // _showAdminForm(context, user: user);
                          break;
                        case 1:
                          context
                              .showGenericDialog(
                                  title: 'Disable User',
                                  content: 'Do you want to disable user?')
                              .then((res) {
                            if (res == true) {
                              ref
                                  .read(cloudFunctionsServiceProvider)
                                  .disableUser(user.uid);
                            }
                          });
                          break;
                      }
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: 0,
                        child: Text('Update Password'),
                      ),
                      const PopupMenuItem(
                        value: 1,
                        child: Text('Disable User'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: list.length,
        ),
        error: (_, __) => Center(
          child: Text('Error loading admin list'),
        ),
        loading: () => Center(child: LoaderWidget()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAdminForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAdminForm(
    BuildContext context, {
    AdminModel? user,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: AddUpdateAdminWidget(admin: user),
      ),
    );
  }
}
