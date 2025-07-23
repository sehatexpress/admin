import 'package:flutter/material.dart';
import '../../config/extensions.dart';

class OrderCityWidget extends StatelessWidget {
  final String city;
  const OrderCityWidget({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      child: Text(
        city.toUpperCase(),
        style: context.text.labelSmall?.copyWith(
          height: 1,
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
