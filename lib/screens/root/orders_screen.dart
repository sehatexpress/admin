import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/enums.dart';
import '../../config/extensions.dart';
import '../../providers/lists_provider.dart';
import '../../widgets/generic/tab_bar_widget.dart';
import '../../widgets/orders/orders_list_widget.dart';
import 'place_order_screen.dart';

class OrdersScreen extends HookConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTabController(
      initialLength: OrderStatusEnum.values.length,
    );
    final orders = ref.watch(getTodayOrdersListProvider(null));
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          TabBarWidget(
            controller: controller,
            tabs: OrderStatusEnum.values.map((e) => e.name).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: OrderStatusEnum.values
                  .map(
                    (e) => OrdersListWidget(
                      status: e,
                      orders: (orders.value ?? [])
                          .where((x) => x.status == e)
                          .toList(),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(const PlaceOrderScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
