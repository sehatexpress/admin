import 'package:flutter/material.dart';

import '../../config/enums.dart';
import '../../config/extensions.dart';

class OrderPlatformCardWidget extends StatelessWidget {
  final OrderPlatformEnum platform;
  const OrderPlatformCardWidget({
    super.key,
    required this.platform,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        platform.name.toUpperCase(),
        style: context.text.labelSmall?.copyWith(
          height: 1,
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
