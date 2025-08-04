import 'package:flutter/material.dart';

import '../../../config/extensions.dart';
import 'add_update_menu_screen.dart';

class MenusScreen extends StatelessWidget {
  const MenusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        itemBuilder: (_, i) => Container(height: 100, color: Colors.blue),
        separatorBuilder: (_, i) => const SizedBox(height: 12),
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(const AddUpdateMenuScreen()),
        child: Icon(Icons.add_rounded),
      ),
    );
  }
}
