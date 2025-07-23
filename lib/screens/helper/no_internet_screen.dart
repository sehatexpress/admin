import 'package:flutter/material.dart';

import '../../config/constants.dart' show ColorConstants, ImageConstant;
import '../../widgets/generic/overlay_widget.dart';
import '../../helper/controllers.dart';

class NoInternetScreen {
  NoInternetScreen._sharedInstance();
  static final NoInternetScreen _shared = NoInternetScreen._sharedInstance();
  factory NoInternetScreen.instance() => _shared;

  GenericController? _controller;

  void show({required BuildContext context}) {
    _controller = showOverlay(context);
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  GenericController? showOverlay(BuildContext context) {
    final state = Overlay.of(context);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final overlay = OverlayEntry(
      builder: (context) {
        return OverlayWidget(
          size: size,
          center: true,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: 80,
              color: ColorConstants.textColor,
            ),
            const SizedBox(height: 8),
            const Text('No internet connection!'),
            const Text('Please check your network connection'),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: AssetImage(ImageConstant.noInternet),
                    fit: BoxFit.cover,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
              ),
            )
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
