import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/constants.dart';
import '../../config/typo_config.dart';
import '../../services/banner_service.dart';
import '../inputs/select_city.dart';
import 'images_loading_widget.dart';

class AddUpdateBannerWidget extends HookConsumerWidget {
  const AddUpdateBannerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantId = useState<String?>(null);
    final city = useState<String?>(null);
    final files = useState<List<File>>([]);

    Future<void> pickImages() async {
      final picker = ImagePicker();
      final images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        files.value = [...files.value, ...images.map((x) => File(x.path))];
      }
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectCity(city: city.value, onChanged: (x) => city.value = x),
          const SizedBox(height: 12),
          ImagesListWidget(
            files: files.value,
            onDelete: (file) {
              files.value = files.value.where((f) => f != file).toList();
            },
            addWidget: GestureDetector(
              onTap: pickImages,
              child: AspectRatio(
                aspectRatio: 16 / 12,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.add_photo_alternate_rounded),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => ref
                  .read(bannerServiceProvider)
                  .uploadBannerImages(
                    restaurantId.value,
                    files.value,
                    city.value,
                  ),
              child: Text(
                'Submit',
                style: typoConfig.textStyle.largeCaptionLabel3Bold.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
