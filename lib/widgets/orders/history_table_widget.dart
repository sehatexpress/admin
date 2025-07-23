import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/extensions.dart';
import '../../models/order_model.dart';

class HistoryTableWidget extends StatelessWidget {
  final List<MapEntry<String?, List<OrderModel>>> ordersByDeliveryID;

  const HistoryTableWidget({
    super.key,
    required this.ordersByDeliveryID,
  });

  @override
  Widget build(BuildContext context) {
    final totalDeliveries = _calculateTotalDeliveries();
    final totalRestaurantIncome = _calculateTotalIncome();
    final totalDeliveryCharge = _calculateTotalDeliveryCharge();

    return Table(
      border: TableBorder.all(
        width: 0.5,
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2),
      ),
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(40),
        2: FlexColumnWidth(85),
        3: FlexColumnWidth(85),
        4: FlexColumnWidth(85),
      },
      children: [
        TableRow(
          children: _titles
              .map(
                (e) => _TableText(
                  title: e,
                  isBold: true,
                  alignRight: _titles.indexOf(e) != 0,
                ),
              )
              .toList(),
        ),
        ...ordersByDeliveryID.map((entry) {
          final orders = entry.value;
          final name = orders.first.deliveryPersonName ?? '';
          final td = orders.length;
          final ri = _calculateIncome(orders);
          final dc = _calculateDeliveryCharge(orders);
          final total = ri + dc;

          return TableRow(
            children: [
              _TableText(title: name, alignRight: false),
              _TableText(title: td.toString()),
              _TableText(title: _formatPrice(ri)),
              _TableText(title: _formatPrice(dc)),
              _TableText(title: _formatPrice(total)),
            ],
          );
        }),
        TableRow(
          children: [
            const _TableText(title: 'TOTAL', alignRight: false, isBold: true),
            _TableText(title: totalDeliveries.toString(), isBold: true),
            _TableText(
              title: _formatPrice(totalRestaurantIncome),
              isBold: true,
            ),
            _TableText(title: _formatPrice(totalDeliveryCharge), isBold: true),
            _TableText(
              isBold: true,
              title: _formatPrice(totalRestaurantIncome + totalDeliveryCharge),
            ),
          ],
        ),
      ],
    );
  }

  static final List<String> _titles = ['NAME', 'TD', 'RI', 'DC', 'TOTAL'];

  // Helpers
  num _calculateDeliveryCharge(List<OrderModel> orders) =>
      orders.fold(0, (sum, order) => sum + order.deliveryCharge);

  num _calculateIncome(List<OrderModel> orders) => orders.fold(0,
      (sum, order) => sum + order.items.calculateAmount(toRestaurant: false));

  int _calculateTotalDeliveries() =>
      ordersByDeliveryID.fold(0, (sum, entry) => sum + entry.value.length);

  num _calculateTotalIncome() => ordersByDeliveryID.fold(
      0, (sum, entry) => sum + _calculateIncome(entry.value));

  num _calculateTotalDeliveryCharge() => ordersByDeliveryID.fold(
      0, (sum, entry) => sum + _calculateDeliveryCharge(entry.value));

  String _formatPrice(num amount) =>
      '${HelperConstant.priceSymbol}${amount.toStringAsFixed(2)}';
}

class _TableText extends StatelessWidget {
  final String title;
  final bool alignRight;
  final bool isBold;

  const _TableText({
    required this.title,
    this.alignRight = true,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      child: Text(
        title,
        textAlign: alignRight ? TextAlign.right : TextAlign.left,
        style: context.text.labelSmall?.copyWith(
          height: 1,
          fontSize: 10,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}
