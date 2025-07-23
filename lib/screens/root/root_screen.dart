import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/nav_provider.dart';
import '../../widgets/root/drawer_menu.dart';

class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(currentIndexProvider);
    final screens = ref.watch(screensProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(screens[index].title),
      ),
      drawer: const Drawer(
        child: DrawerMenu(),
      ),
      body: screens[index].screen,
    );
  }
}
