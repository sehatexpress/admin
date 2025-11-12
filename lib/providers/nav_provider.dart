import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import '../screens/root/category_screen.dart';
import '../screens/root/city_location_screen.dart';
import '../screens/root/city_screen.dart';
import '../screens/root/customer_quries_screen.dart';
import '../screens/root/dashboard_screen.dart';
import '../screens/root/delivery_partner_location_screen.dart';
import '../screens/root/delivery_partner_screen.dart';
import '../screens/root/menu/menus_screen.dart';
import '../screens/root/order_history_screen.dart';
import '../screens/root/orders_screen.dart';
import '../screens/root/users_screen.dart';
import '../screens/root/voucher_screen.dart';

class NavMenuModel {
  final String title;
  final IconData icon;
  final Widget screen;

  NavMenuModel({required this.title, required this.icon, required this.screen});
}

final currentIndexProvider = StateProvider<int>((ref) => 0);
final screensProvider = Provider<List<NavMenuModel>>((ref) {
  return [
    NavMenuModel(
      title: 'Dashboard',
      icon: Icons.dashboard,
      screen: DashboardScreen(),
    ),
    NavMenuModel(
      title: 'Categories',
      icon: Icons.inventory_2_rounded,
      screen: CategoryScreen(),
    ),
    NavMenuModel(
      title: 'Menus',
      icon: Icons.inventory_2_rounded,
      screen: MenusScreen(),
    ),
    NavMenuModel(
      title: 'Cities',
      icon: Icons.location_city_rounded,
      screen: CityScreen(),
    ),
    NavMenuModel(
      title: 'City Location',
      icon: Icons.location_city_rounded,
      screen: CityLocationScreen(),
    ),
    NavMenuModel(
      title: 'Orders',
      icon: Icons.shopping_cart,
      screen: OrdersScreen(),
    ),

    NavMenuModel(
      title: 'Vouchers',
      icon: Icons.card_giftcard,
      screen: VoucherScreen(),
    ),
    NavMenuModel(
      title: 'Delivery Partners',
      icon: Icons.delivery_dining,
      screen: DeliveryPartnerScreen(),
    ),
    NavMenuModel(title: 'Users', icon: Icons.people, screen: UsersScreen()),
    NavMenuModel(
      title: 'Order History',
      icon: Icons.history,
      screen: OrderHistoryScreen(),
    ),
    NavMenuModel(
      title: 'Delivery Partner Location',
      icon: Icons.location_on,
      screen: DeliveryPartnerLocationScreen(),
    ),
    NavMenuModel(
      title: 'Customer Queries',
      icon: Icons.question_answer,
      screen: CustomerQuriesScreen(),
    ),
  ];
});
