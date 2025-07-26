import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/enums.dart';
import '../../config/extensions.dart';
import '../../config/url_config.dart';
import '../../models/order_model.dart';
import 'order_city_widget.dart';
import 'order_platform_widget.dart';

class OrdersListWidget extends StatelessWidget {
  final OrderStatusEnum status;
  final List<OrderModel> orders;

  const OrdersListWidget({
    super.key,
    required this.status,
    this.orders = const [],
  });

  @override
  Widget build(BuildContext context) {
    final symbol = HelperConstant.priceSymbol;
    final style = context.text.labelMedium?.copyWith(
      height: 1,
      color: ColorConstants.textColor,
    );

    if (orders.isEmpty) return const SizedBox();

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, i) {
        final order = orders[i];
        final commission = order.items.calculateAmount(toRestaurant: false);
        final totalEarning = commission + order.deliveryCharge - order.discount;

        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time, City, Platform
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.orderedDate.formattedTime,
                    style: context.text.labelSmall,
                  ),
                  Row(
                    children: [
                      OrderCityWidget(city: order.restaurantCity),
                      if (order.platform == OrderPlatformEnum.web) ...[
                        const SizedBox(width: 6),
                        OrderPlatformCardWidget(platform: order.platform),
                      ],
                    ],
                  ),
                ],
              ),
              const Divider(),
              // Restaurant Info
              _PersonTile(
                image: order.restaurantImage,
                name: order.restaurantName,
                subtitle: order.restaurantStreet,
                status: order.status,
                phoneNumber: order.restaurantNumber,
              ),
              const SizedBox(height: 8),
              // Customer Info
              _PersonTile(
                icon: Icons.add_home_rounded,
                name: '${order.userName}, ${order.userPhoneNumber}',
                subtitle: order.deliveryAddressStreet,
                status: order.status,
                phoneNumber: order.userPhoneNumber ?? '',
              ),
              if (order.deliveryPersonId != null) ...[
                const SizedBox(height: 8),
                _PersonTile(
                  icon: Icons.pedal_bike_rounded,
                  name: order.deliveryAddressPersonName,
                  subtitle: order.deliveryPersonPhoneNumber!,
                  status: order.status,
                  phoneNumber: order.deliveryPersonPhoneNumber ?? '',
                ),
              ],
              const Divider(),
              // Items List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: order.items.length,
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
              ),
              const Divider(),
              // Summary Rows
              _SummaryRow(
                title: 'Items Total',
                value: order.itemTotal,
                style: style,
              ),
              _SummaryRow(
                title: 'Delivery Charge',
                value: order.deliveryCharge,
                style: style,
              ),
              _SummaryRow(
                title: 'Discount',
                value: order.discount,
                style: style,
              ),
              const Divider(),
              // Grand Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Grand Total', style: _boldPrimaryStyle),
                  Text('$symbol${order.grandTotal}', style: _boldPrimaryStyle),
                ],
              ),
              const Divider(),
              // Restaurant & Platform Earnings
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _MiniSummary(
                    title: 'TO RESTAURANT',
                    value: order.items.calculateAmount(toRestaurant: true),
                    style: style,
                  ),
                  _MiniSummary(
                    isStart: false,
                    title: 'TOEATO EARNINGS',
                    valueDesc:
                        '$symbol$commission + $symbol${order.deliveryCharge} - $symbol${order.discount} = $symbol${totalEarning.toStringAsFixed(2)}',
                    style: style,
                  ),
                ],
              ),
              if (order.cancellationReason != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Cancellation Reason: ${order.cancellationReason}',
                    style: context.text.labelSmall?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  TextStyle get _boldPrimaryStyle => const TextStyle(
    height: 1,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColorConstants.primary,
  );
}

class _PersonTile extends StatelessWidget {
  final String? image;
  final IconData? icon;
  final String name;
  final String subtitle;
  final OrderStatusEnum status;
  final String phoneNumber;

  const _PersonTile({
    this.image,
    this.icon,
    required this.name,
    required this.subtitle,
    required this.status,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = image != null;

    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: hasImage ? NetworkImage(image!) : null,
          child: hasImage ? null : Icon(icon ?? Icons.person),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: context.text.bodySmall?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: context.text.labelSmall?.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        if (![
          OrderStatusEnum.delivered,
          OrderStatusEnum.cancelled,
        ].contains(status))
          IconButton(
            onPressed: () => openCall(phoneNumber),
            icon: const Icon(Icons.call, size: 18),
          ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final num value;
  final TextStyle? style;

  const _SummaryRow({required this.title, required this.value, this.style});

  @override
  Widget build(BuildContext context) {
    final symbol = HelperConstant.priceSymbol;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: style),
          Text('$symbol${value.toStringAsFixed(2)}', style: style),
        ],
      ),
    );
  }
}

class _MiniSummary extends StatelessWidget {
  final String title;
  final num? value;
  final String? valueDesc;
  final TextStyle? style;
  final bool isStart;

  const _MiniSummary({
    required this.title,
    this.value,
    this.valueDesc,
    this.style,
    this.isStart = true,
  });

  @override
  Widget build(BuildContext context) {
    final symbol = HelperConstant.priceSymbol;
    return Column(
      crossAxisAlignment: isStart
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        const SizedBox(height: 2),
        Text(valueDesc ?? '$symbol${value?.toStringAsFixed(2)}', style: style),
      ],
    );
  }
}
