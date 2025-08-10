import 'package:flutter/material.dart';

import '../../widgets/generic/loader_widget.dart';
import '../../widgets/generic/overlay_widget.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  OverlayEntry? _overlay;

  void show(BuildContext context) {
    if (_overlay != null) return;

    final overlayState = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox?;
    final size = renderBox?.size ?? MediaQuery.of(context).size;

    _overlay = OverlayEntry(
      builder: (context) {
        return OverlayWidget(size: size, children: const [LoaderWidget()]);
      },
    );

    overlayState.insert(_overlay!);
  }

  void hide() {
    _overlay?.remove();
    _overlay = null;
  }
}
