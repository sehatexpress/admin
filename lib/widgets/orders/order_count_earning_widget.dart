import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../config/constants.dart';
import '../../config/enums.dart';
import '../../config/extensions.dart';
import '../../models/order_model.dart';
import 'history_table_widget.dart';

class OrderCountEarningWidget extends StatelessWidget {
  final List<OrderModel> ordersList;
  final bool margin;
  const OrderCountEarningWidget({
    super.key,
    this.ordersList = const [],
    this.margin = true,
  });

  @override
  Widget build(BuildContext context) {
    List<String> titles = ['Total ', 'Restaurant ', 'toeato'];
    List<String> countTitle = ['Orders', 'Delivered', 'cancelled'];

    List<OrderModel> ordered =
        ordersList.where((e) => e.status == OrderStatusEnum.delivered).toList();
    List<OrderModel> cancelled =
        ordersList.where((e) => e.status == OrderStatusEnum.cancelled).toList();
    var ordersByDeliveryID = groupBy(
        ordersList.where((e) => e.deliveryPersonId != null).toList(),
        (OrderModel doc) => doc.deliveryPersonId).entries.toList();
    List<int> counts = [ordersList.length, ordered.length, cancelled.length];
    List<double> sums = [
      ordersList.fold(0, (x, e) => x + e.grandTotal),
      ordersList.fold(0, (x, e) => x + (e.restaurantBalance ?? 0)),
      ordersList.fold(0, (x, e) => x + (e.commission! + e.deliveryCharge)),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      margin: margin
          ? const EdgeInsets.symmetric(
              horizontal: 16,
            )
          : null,
      child: Column(
        children: [
          StaggeredGrid.count(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              ...List.generate(
                3,
                (i) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      counts[i].toString(),
                      style: context.text.titleMedium?.copyWith(height: 1),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      countTitle[i].toUpperCase(),
                      style: context.text.labelSmall?.copyWith(height: 1),
                    ),
                  ],
                ),
              ),
              ...List.generate(
                3,
                (i) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${HelperConstant.priceSymbol}${sums[i].toStringAsFixed(2)}',
                      style: context.text.titleMedium?.copyWith(height: 1),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      titles[i].toUpperCase(),
                      style: context.text.labelSmall?.copyWith(height: 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // date wise
          const SizedBox(height: 12),
          HistoryTableWidget(
            ordersByDeliveryID: ordersByDeliveryID,
          ),
        ],
      ),
    );
  }
}
