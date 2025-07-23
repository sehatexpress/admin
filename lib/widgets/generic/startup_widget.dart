import 'package:flutter/material.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/typo_config.dart';

class StartupWidget extends StatelessWidget {
  final Widget widget;
  const StartupWidget({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primary,
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          widget,
          Positioned(
            bottom: 24,
            child: Column(
              children: [
                Text(
                  'SEHAT EXPRESS',
                  style: typoConfig.textStyle.largeBodyBodyBold.copyWith(
                    height: 1,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Khaao Hygienic, Paao Comfort',
                  style: typoConfig.textStyle.smallCaptionSubtitle2.copyWith(
                    height: 1,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
