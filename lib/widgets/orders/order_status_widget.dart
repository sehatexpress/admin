import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/enums.dart';
import '../../config/extensions.dart';

class OrderStatusWidget extends StatelessWidget {
  final OrderStatusEnum status;

  const OrderStatusWidget({super.key, required this.status});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: EnumConstant.statusColors[status],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: context.text.labelSmall?.copyWith(
          height: 1,
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
