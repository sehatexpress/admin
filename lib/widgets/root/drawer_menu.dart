import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../config/extensions.dart';
import '../../config/strings.dart';
import '../../providers/auth_provider.dart';
import '../../providers/nav_provider.dart';

class DrawerMenu extends HookConsumerWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final screens = ref.watch(screensProvider);
    final user = ref.watch(authProvider);
    return SafeArea(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(radius: 25),
            title: Text(user?.displayName ?? 'User Name'),
            subtitle: Text(user?.email ?? ''),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: screens.length,
              padding: EdgeInsets.zero,
              itemBuilder: (_, i) => ListTile(
                dense: true,
                leading: Icon(screens[i].icon, size: 18),
                title: Text(screens[i].title),
                selected: currentIndex == i,
                onTap: () {
                  ref.read(currentIndexProvider.notifier).state = i;
                  if (context.isMobile) {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ),
          const Divider(height: 0),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextButton.icon(
              onPressed: () => context
                  .showGenericDialog(
                    title: Strings.logout,
                    content:
                        '${Strings.genericAlertDescription}${Strings.logout.toLowerCase()}',
                  )
                  .then((res) {
                    if (res == true) {
                      ref.read(authProvider.notifier).logout();
                    }
                  }),
              label: Text('Logout', style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                backgroundColor: ColorConstants.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(Icons.logout_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
