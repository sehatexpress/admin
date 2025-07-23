import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  final Color? color;
  final double? progress;
  const LoaderWidget({
    super.key,
    this.color,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .6,
      child: CircularProgressIndicator(
        color: color,
        value: progress != null ? progress! / 100 : null,
      ),
    );
  }
}
