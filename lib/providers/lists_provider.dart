import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/admin_model.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/delivery_partner_model.dart';
import '../models/order_model.dart';
import '../models/query_model.dart';
import '../models/setting_model.dart';
import '../models/voucher_model.dart';
import '../services/admin_service.dart';
import '../services/banner_service.dart';
import '../services/category_service.dart';
import '../services/customer_queries_service.dart';
import '../services/delivery_partner_service.dart';
import '../services/order_service.dart';
import '../services/setting_service.dart';
import '../services/voucher_service.dart';


final citySettingListProvider = StreamProvider<List<SettingModel>>(
    (ref) => ref.read(settingServiceProvider).getAllSettings());

final categoriesListProvider = StreamProvider<List<CategoryModel>>(
    (ref) => ref.read(categoryServiceProvider).getCategories(null));

final adminsListProvider = StreamProvider<List<AdminModel>>(
    (ref) => ref.read(adminServiceProvider).getAllAdminList());

final bannersListProvider = StreamProvider<List<BannerModel>>(
    (ref) => ref.read(bannerServiceProvider).getBannerImages(null));

final deliveryPartnerListProvider = StreamProvider<List<DeliveryPartnerModel>>(
    (ref) =>
        ref.read(deliveryPartnerServiceProvider).getDeliveryPartners(null));

final customerQueriesListProvider = StreamProvider<List<QueryModel>>(
    (ref) => ref.read(customerQueriesServiceProvider).getAllQueries());

final vouchersListProvider = StreamProvider<List<VoucherModel>>(
    (ref) => ref.read(voucherServiceProvider).getVouchers(null));

// orders
final getOrdersListByDateProvider =
    StreamProvider.family<List<OrderModel>, String>((ref, date) {
  return ref.read(orderServiceProvider).getOrdersByDate(date);
});

final getTodayOrdersListProvider =
    StreamProvider.family<List<OrderModel>, String?>((ref, city) {
  return ref.read(orderServiceProvider).getTodayOrders(city);
});
