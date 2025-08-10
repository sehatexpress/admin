import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/lists_provider.dart';
import '../../widgets/generic/data_view_widget.dart';
import '../../widgets/orders/history_card_widget.dart';
import '../../widgets/orders/history_filter_widget.dart';
import '../../widgets/orders/order_count_earning_widget.dart';

class OrderHistoryScreen extends HookConsumerWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = useState<String?>(null);
    // final restaurantId = useState<String?>(null);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 10),
          child: HistoryFilterWidget(onDateSelect: (x) => date.value = x),
        ),
        if (date.value != null) ...[
          const SizedBox(height: 12),
          Expanded(
            child: DataViewWidget(
              provider: getOrdersListByDateProvider(date.value!),
              dataBuilder: (data) {
                return ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16).copyWith(top: 0),
                  children: [
                    OrderCountEarningWidget(margin: false, ordersList: data),
                    const SizedBox(height: 12),
                    ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) => HistoryCardWidget(order: data[i]),
                      separatorBuilder: (_, i) => const SizedBox(height: 10),
                      itemCount: data.length,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
