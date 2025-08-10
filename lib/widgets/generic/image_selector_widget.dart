import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../providers/global_providers.dart';

class ImageSelectorWidget extends HookConsumerWidget {
  final String? initialImageUrl;
  final double height;
  final double width;
  final BoxFit fit;
  final IconData placeholderIcon;

  const ImageSelectorWidget({
    super.key,
    this.initialImageUrl,
    this.height = 120,
    this.width = 120,
    this.fit = BoxFit.cover,
    this.placeholderIcon = Icons.add_a_photo_rounded,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageFile = ref.watch(imageSelectorProvider);
    final picker = useMemoized(() => ImagePicker());

    Future<void> pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        ref.read(imageSelectorProvider.notifier).state = File(pickedFile.path);
      }
    }

    Widget imageWidget;
    if (imageFile != null) {
      imageWidget = Image.file(
        imageFile,
        fit: fit,
        width: width,
        height: height,
      );
    } else if (initialImageUrl != null && initialImageUrl!.isNotEmpty) {
      imageWidget = Image.network(
        initialImageUrl!,
        fit: fit,
        width: width,
        height: height,
      );
    } else {
      imageWidget = Icon(
        placeholderIcon,
        size: width * 0.4,
        color: Colors.grey,
      );
    }

    return GestureDetector(
      onTap: pickImage,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: width,
          height: height,
          color: Colors.grey.shade200,
          child: imageWidget,
        ),
      ),
    );
  }
}
