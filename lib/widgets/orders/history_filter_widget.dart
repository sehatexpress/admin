import 'package:flutter/material.dart';

import '../inputs/date_input.dart';

class HistoryFilterWidget extends StatelessWidget {
  final Function(String?) onDateSelect;
  final String? restaurantId;
  final Function(String?)? onRestaurantSelect;
  const HistoryFilterWidget({
    super.key,
    required this.onDateSelect,
    this.restaurantId,
    this.onRestaurantSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DateInput(
            onTap: onDateSelect,
          ),
        ),
        // const SizedBox(width: 12),
        // Expanded(
        //   child: SelectRestaurant(
        //     restaurantId: restaurantId,
        //     onChanged: onRestaurantSelect,
        //   ),
        // ),
      ],
    );
  }
}
