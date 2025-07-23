import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' show launchUrl;

import '../../config/constants.dart' show ForceUpdateConstant;
import '../../config/strings.dart' show Strings;
import '../../config/typo_config.dart' show typoConfig;
import '../../helper/controllers.dart';
import '../../widgets/generic/overlay_widget.dart';

class ForceUpdateScreen {
  ForceUpdateScreen._sharedInstance();
  static final ForceUpdateScreen _shared = ForceUpdateScreen._sharedInstance();
  factory ForceUpdateScreen.instance() => _shared;

  GenericController? _controller;

  void show({required BuildContext context}) {
    _controller = showOverlay(context: context);
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  GenericController? showOverlay({required BuildContext context}) {
    final state = Overlay.of(context);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final overlay = OverlayEntry(
      builder: (context) {
        return OverlayWidget(
          size: size,
          center: true,
          children: [
            Text(
              Strings.updateAvailableTitle,
              style: typoConfig.textStyle.largeCaptionLabel2Bold,
            ),
            const SizedBox(height: 6),
            Text(
              Strings.updateAvailableMessage,
              style: typoConfig.textStyle.smallCaptionSubtitle2,
            ),
            const SizedBox(height: 10),
            Text(
              Strings.updateAvailableAction,
              style: typoConfig.textStyle.largeCaptionLabel3Bold,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  final uri = Uri.parse(ForceUpdateConstant.playStoreURL);
                  launchUrl(uri);
                },
                icon: Icon(Icons.update_outlined),
                label: const Text('Update Now'),
              ),
            ),
          ],
        );
      },
    );

    state.insert(overlay);

    return GenericController(
      close: () {
        overlay.remove();
        return true;
      },
      update: (text) {
        return true;
      },
    );
  }
}
