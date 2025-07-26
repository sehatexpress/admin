import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/delivery_partner_model.dart';
import '../models/order_model.dart';
import '../models/query_model.dart';
import '../models/voucher_model.dart';
import '../services/customer_queries_service.dart';
import '../services/delivery_partner_service.dart';
import '../services/order_service.dart';
import '../services/voucher_service.dart';

final deliveryPartnerListProvider = StreamProvider<List<DeliveryPartnerModel>>(
  (ref) => ref.read(deliveryPartnerServiceProvider).getDeliveryPartners(null),
);

final customerQueriesListProvider = StreamProvider<List<QueryModel>>(
  (ref) => ref.read(customerQueriesServiceProvider).getAllQueries(),
);

final vouchersListProvider = StreamProvider<List<VoucherModel>>(
  (ref) => ref.read(voucherServiceProvider).getVouchers(null),
);

// orders
final getOrdersListByDateProvider =
    StreamProvider.family<List<OrderModel>, String>((ref, date) {
      return ref.read(orderServiceProvider).getOrdersByDate(date);
    });

final getTodayOrdersListProvider =
    StreamProvider.family<List<OrderModel>, String?>((ref, city) {
      return ref.read(orderServiceProvider).getTodayOrders(city);
    });
