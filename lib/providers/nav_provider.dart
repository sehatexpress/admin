import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../screens/root/city_screen.dart';
import '../screens/root/customer_quries_screen.dart';
import '../screens/root/dashboard_screen.dart';
import '../screens/root/delivery_partner_location_screen.dart';
import '../screens/root/delivery_partner_screen.dart';
import '../screens/root/order_history_screen.dart';
import '../screens/root/orders_screen.dart';
import '../screens/root/product/products_screen.dart';
import '../screens/root/users_screen.dart';
import '../screens/root/voucher_screen.dart';

class MenuModel {
  final String title;
  final IconData icon;
  final Widget screen;

  MenuModel({required this.title, required this.icon, required this.screen});
}

final currentIndexProvider = StateProvider<int>((ref) => 0);
final screensProvider = Provider<List<MenuModel>>((ref) {
  return [
    MenuModel(
      title: 'Dashboard',
      icon: Icons.dashboard,
      screen: DashboardScreen(),
    ),
    MenuModel(
      title: 'Products',
      icon: Icons.inventory_2_rounded,
      screen: ProductsScreen(),
    ),
    MenuModel(
      title: 'Cities',
      icon: Icons.location_city_rounded,
      screen: CityScreen(),
    ),
    MenuModel(
      title: 'Orders',
      icon: Icons.shopping_cart,
      screen: OrdersScreen(),
    ),

    MenuModel(
      title: 'Vouchers',
      icon: Icons.card_giftcard,
      screen: VoucherScreen(),
    ),
    // MenuModel(
    //   title: 'Category',
    //   icon: Icons.category,
    //   screen: CategoryScreen(),
    // ),
    MenuModel(
      title: 'Delivery Partners',
      icon: Icons.delivery_dining,
      screen: DeliveryPartnerScreen(),
    ),
    MenuModel(title: 'Users', icon: Icons.people, screen: UsersScreen()),
    // MenuModel(
    //   title: 'Admin',
    //   icon: Icons.admin_panel_settings,
    //   screen: AdminScreen(),
    // ),
    MenuModel(
      title: 'Order History',
      icon: Icons.history,
      screen: OrderHistoryScreen(),
    ),
    // MenuModel(
    //   title: 'Slider Banners',
    //   icon: Icons.browse_gallery,
    //   screen: BannerScreen(),
    // ),
    MenuModel(
      title: 'Delivery Partner Location',
      icon: Icons.location_on,
      screen: DeliveryPartnerLocationScreen(),
    ),
    MenuModel(
      title: 'Customer Queries',
      icon: Icons.question_answer,
      screen: CustomerQuriesScreen(),
    ),
  ];
});
