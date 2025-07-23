import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/global_providers.dart';

class ImagesListWidget extends ConsumerWidget {
  final List<File> files;
  final Widget addWidget;
  final Function(File) onDelete;

  const ImagesListWidget({
    super.key,
    required this.files,
    required this.addWidget,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(globalProvider.select((s) => s.loading));

    return StaggeredGrid.count(
      crossAxisCount: files.isNotEmpty ? 2 : 1,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        ...files.map(
          (file) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.file(file, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: loading ? null : () => onDelete(file),
                  ),
                ),
              ],
            ),
          ),
        ),
        addWidget,
      ],
    );
  }
}
