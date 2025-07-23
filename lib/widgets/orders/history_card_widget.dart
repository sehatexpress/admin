import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/enums.dart';
import '../../config/extensions.dart';
import '../../models/order_model.dart';
import 'order_city_widget.dart';
import 'order_platform_widget.dart';
import 'order_status_widget.dart';

class HistoryCardWidget extends StatelessWidget {
  final OrderModel order;
  const HistoryCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final symbol = HelperConstant.priceSymbol;
    final style = context.text.labelMedium?.copyWith(height: 1);
    final smallStyle = context.text.labelSmall?.copyWith(
      height: 1,
      color: ColorConstants.primary,
    );

    final totalEarning = order.items.calculateAmount(toRestaurant: false) +
        order.items.extraCommission +
        order.deliveryCharge;

    return Container(
      decoration: BoxDecoration(
        color: EnumConstant.statusColors[order.status]!.withAlpha(25),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const Divider(height: 8),
          _buildItemList(context, style!, symbol),
          const Divider(height: 8),
          ..._buildAmountDetails(symbol, style),
          const Divider(height: 8),
          ..._buildEarnings(context, totalEarning, symbol),
          const Divider(height: 8),
          _buildPeopleInfo(smallStyle!),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            order.orderedDate.formattedTime,
            style: context.text.labelSmall?.copyWith(
              height: 1,
              color: ColorConstants.secondary,
            ),
          ),
        ),
        const SizedBox(width: 6),
        OrderCityWidget(city: order.restaurantCity),
        const SizedBox(width: 6),
        OrderStatusWidget(status: order.status),
        if (order.platform == OrderPlatformEnum.web) ...[
          const SizedBox(width: 6),
          OrderPlatformCardWidget(platform: order.platform),
        ],
      ],
    );
  }

  Widget _buildItemList(BuildContext context, TextStyle style, String symbol) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: order.items.length,
      padding: EdgeInsets.zero,
      itemBuilder: (_, i) {
        final item = order.items[i];
        final price = item.sellingPrice * item.quantity;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${i + 1}. ${item.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style,
                ),
              ),
              Text(
                '$symbol${item.sellingPrice} x ${item.quantity} = $symbol${price.toStringAsFixed(2)}',
                style: style,
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildAmountDetails(String symbol, TextStyle style) {
    return [
      _amountRow('Item Total', order.itemTotal, symbol, style),
      if (order.discount > 0)
        _amountRow('Discount', order.discount, symbol, style),
      if (order.deliveryCharge > 0)
        _amountRow('Delivery Charge', order.deliveryCharge, symbol, style),
      if (order.tip != null && order.tip! > 0)
        _amountRow('Delivery Partner TIP', order.tip!, symbol, style),
      _amountRow('Grand Total', order.grandTotal, symbol, style),
    ];
  }

  List<Widget> _buildEarnings(
      BuildContext context, num totalEarning, String symbol) {
    final style = context.text.labelSmall?.copyWith(height: 1);
    return [
      _amountRow(
          'Restaurant Earnings', order.restaurantBalance ?? 0, symbol, style!),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('My Earning', style: style),
          Text('$symbol${totalEarning.toStringAsFixed(2)}', style: style),
        ],
      ),
    ];
  }

  Widget _amountRow(String title, num amount, String symbol, TextStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: style),
        Text('$symbol${amount.toStringAsFixed(2)}', style: style),
      ],
    );
  }

  Widget _buildPeopleInfo(TextStyle smallStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (order.deliveryPersonId != null)
          Text('Delivered by: ${order.deliveryPersonName}', style: smallStyle),
        Text('Ordered by: ${order.userName}', style: smallStyle),
        Text('Ordered From: ${order.restaurantName}', style: smallStyle),
        if (order.cancellationReason != null)
          Text(
            'Cancellation Reason: ${order.cancellationReason}',
            style: smallStyle,
          ),
      ],
    );
  }
}
