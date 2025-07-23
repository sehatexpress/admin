import 'package:flutter/material.dart';

import 'custom_checkbox.dart';

class ChooseAdditionalFeatureWidget extends StatelessWidget {
  final bool isNew;
  final Function() onTapNew;
  final bool featured;
  final Function() onTapFeatured;
  final bool recommended;
  final Function() onTapRecommended;
  final bool bestSeller;
  final Function() onTapBestSeller;
  const ChooseAdditionalFeatureWidget({
    super.key,
    required this.isNew,
    required this.onTapNew,
    required this.featured,
    required this.onTapFeatured,
    required this.recommended,
    required this.onTapRecommended,
    required this.bestSeller,
    required this.onTapBestSeller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomCheckbox(
          title: 'Is New?',
          value: isNew,
          onTap: onTapNew,
        ),
        CustomCheckbox(
          title: 'Is Featured?',
          value: featured,
          onTap: onTapFeatured,
        ),
        CustomCheckbox(
          title: 'Is Recommended?',
          value: recommended,
          onTap: onTapRecommended,
        ),
        CustomCheckbox(
          title: 'Best Seller',
          value: bestSeller,
          onTap: onTapBestSeller,
        ),
          
      ],
    );
  }
}
