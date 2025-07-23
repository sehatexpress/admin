import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../config/enums.dart';
import '../../config/extensions.dart';
import '../../providers/lists_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final categories = ref.watch(categoriesListProvider);
    // final deliveryPartner = ref.watch(deliveryPartnerListProvider);
    // final orders = ref.watch(getTodayOrdersListProvider(null));
    // final vouchers = ref.watch(vouchersListProvider);
    // final List<String> titles = [
    //   'restaurants',
    //   'vouchers',
    //   'categories',
    //   'Delivery Partner',
    // ];
    // List<num> counts = [
    //   0,
    //   (vouchers.value ?? []).length,
    //   (categories.value ?? []).length,
    //   (deliveryPartner.value ?? []).length,
    // ];
    // return ListView(
    //   shrinkWrap: true,
    //   padding: EdgeInsets.all(16),
    //   children: [
    //     Container(
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.circular(8),
    //       ),
    //       padding: EdgeInsets.all(12),
    //       child: StaggeredGrid.count(
    //         crossAxisCount: 3,
    //         mainAxisSpacing: 12,
    //         crossAxisSpacing: 12,
    //         children: OrderStatusEnum.values.map((e) {
    //           final list =
    //               orders.value?.where((x) => x.status == e).toList() ?? [];
    //           final total =
    //               list.fold<num>(0, (prev, item) => prev + item.grandTotal);

    //           return Column(
    //             mainAxisSize: MainAxisSize.min,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text(
    //                 '${HelperConstant.priceSymbol} $total',
    //                 style: context.text.labelSmall,
    //               ),
    //               Text(
    //                 '${list.length} ${e.name.toUpperCase()}',
    //                 style: context.text.labelMedium,
    //               ),
    //             ],
    //           );
    //         }).toList(),
    //       ),
    //     ),
    //     const SizedBox(height: 12),
    //     StaggeredGrid.count(
    //       crossAxisCount: 2,
    //       mainAxisSpacing: 12,
    //       crossAxisSpacing: 12,
    //       children: List.generate(
    //         titles.length,
    //         (i) => Container(
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(8),
    //           ),
    //           padding: EdgeInsets.symmetric(vertical: 20),
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text(
    //                 '${counts[i]}',
    //                 style: context.text.bodyLarge?.copyWith(
    //                   fontWeight: FontWeight.w600,
    //                   color: ColorConstants.textColor,
    //                 ),
    //               ),
    //               Text(
    //                 titles[i].toUpperCase(),
    //                 style: context.text.bodySmall?.copyWith(
    //                   color: ColorConstants.textColor,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
    return Container();
  }
}
