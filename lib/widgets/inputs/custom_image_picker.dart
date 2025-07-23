import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/constants.dart';
import '../generic/custom_image_provider.dart';

class CustomImagePicker extends HookWidget {
  final Function(String) onChange;
  final String? img;
  const CustomImagePicker({
    super.key,
    required this.onChange,
    this.img,
  });

  @override
  Widget build(BuildContext context) {
    var image = useState<File?>(null);
    return GestureDetector(
      onTap: () async {
        final picker = ImagePicker();
        final XFile? file = await picker.pickImage(
          source: ImageSource.gallery,
        );
        if (file != null) {
          image.value = File(file.path);
          onChange(file.path);
        }
      },
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          child: image.value != null
              ? Image.file(image.value!, fit: BoxFit.cover)
              : img != null
                  ? CustomImageProvider(image: img)
                  : const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: ColorConstants.textColor,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Select Image',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
