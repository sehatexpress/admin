import 'package:flutter/material.dart';

import 'enums.dart';

@immutable
class KeyConstants {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const KeyConstants._();
}

final _baseURL = 'https://asia-south1-toeato0.cloudfunctions.net';

class ApiUrl {
  static Uri createUserAPI = Uri.parse('$_baseURL/createUser');
  static Uri updateUserAPI = Uri.parse('$_baseURL/updateUser');
  static Uri deleteUserAPI = Uri.parse('$_baseURL/deleteUser');
  static Uri listAllUsers = Uri.parse('$_baseURL/getAllUsers');
  static Uri updateProductsStatus =
      Uri.parse('$_baseURL/updateProductAvailability');
  static Uri createAdminUserAPI = Uri.parse('$_baseURL/createAdminUser');
}

@immutable
class HelperConstant {
  static const priceSymbol = 'रु.';
  const HelperConstant._();
}

@immutable
class ColorConstants {
  static const fontFamily = 'Poppins';
  static const textColor = Color(0xFF35485d);
  static const primary = Color(0xFFEF4444);
  static const secondary = Color(0xFFF97316);
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFFFFFFF);
  static const error = Color(0xFF000000);
  static const onPrimary = Color(0xFFFFFFFF);
  static const onSecondary = Color(0xFFFFFFFF);
  static const onError = Color(0xFF2B2E4A);
  static const onBackground = Color(0xFF2B2E4A);
  static const onSurface = Color(0xFF2B2E4A);
  const ColorConstants._();
}

@immutable
class LocationConstant {
  static const url = '127.0.0.1';
  static const corsURL = 'https://proxy.cors.sh/';
  static const openStreetbaseURl = 'https://nominatim.openstreetmap.org';
  static const openStreetSearch = 'search.php?format=jsonv2&q=';
  static const mapWebKEY = 'AIzaSyC6ENE5I2cWZ18oH4SneX2A7qe_Trimbl8';
  static const mapMobileKEY = 'AIzaSyC88axmDe9J3f0scEEOGRl1J4Z0mAwfEl8';
  static const googleMapDistanceURL =
      'https://maps.googleapis.com/maps/api/distancematrix/json';

  static const userAgent = 'toeato1@gmail.com';
  const LocationConstant._();
}

@immutable
class ForceUpdateConstant {
  static const playStoreURL =
      'https://play.google.com/store/apps/details?id=com.toeato.toeato';
  static const privacy = 'https://docs.toeato.com/privacy-policy';
  const ForceUpdateConstant._();
}

@immutable
class SocialURLConstant {
  static const youtube = 'https://www.youtube.com/@toeato';
  static const instagram = 'https://www.instagram.com/to_eato/';
  static const facebook =
      'https://www.facebook.com/people/Toeato/100086690146612/?mibextid=ZbWKwL';
  static const twitter = 'https://twitter.com/To_Eato';
  const SocialURLConstant._();
}

@immutable
class ImageConstant {
  static const noInternet = 'assets/images/no_internet.jpg';
  static const restaurant = 'assets/images/restaurant.png';
  static const user = 'assets/images/user.png';
  static const delivery = 'assets/images/delivery.png';
  static const logo = 'assets/images/logo.png';
  static const logoAdaptive = 'assets/images/logo_adaptive.png';
  const ImageConstant._();
}

@immutable
class EnumConstant {
  static final Map<String, OrderStatusEnum> orderStatus = {
    'ordered': OrderStatusEnum.ordered,
    'accepted': OrderStatusEnum.accepted,
    'confirmed': OrderStatusEnum.confirmed,
    'picked': OrderStatusEnum.picked,
    'delivered': OrderStatusEnum.delivered,
  };
  static const Map<OrderStatusEnum, Color> statusColors = {
    OrderStatusEnum.ordered: Colors.blue,
    OrderStatusEnum.accepted: Colors.green,
    OrderStatusEnum.confirmed: Colors.orange,
    OrderStatusEnum.picked: Colors.purple,
    OrderStatusEnum.delivered: Colors.teal,
    OrderStatusEnum.cancelled: Colors.red,
  };
  static const Map<FilterEnum, String> filterValues = {
    FilterEnum.all: 'All',
    FilterEnum.veg: 'Veg',
    FilterEnum.nonVeg: 'Non Veg',
    FilterEnum.both: 'Both',
    FilterEnum.bestSeller: 'Best Seller',
  };
  static const Map<FilterEnum, String> filterTypes = {
    FilterEnum.all: 'all',
    FilterEnum.veg: 'veg',
    FilterEnum.nonVeg: 'non veg',
    FilterEnum.both: 'both',
    FilterEnum.bestSeller: 'best seller',
  };
  static const Map<String, FilterEnum> filterMap = {
    'all': FilterEnum.all,
    'best seller': FilterEnum.bestSeller,
    'veg': FilterEnum.veg,
    'both': FilterEnum.both,
  };
  static const Map<String, TicketStatusEnum> ticketStatusMap = {
    'pending': TicketStatusEnum.pending,
    'in-process': TicketStatusEnum.inProcess,
    'closed': TicketStatusEnum.closed,
  };
  static const Map<TicketStatusEnum, String> ticketStatusValues = {
    TicketStatusEnum.pending: 'Pending',
    TicketStatusEnum.inProcess: 'In Process',
    TicketStatusEnum.closed: 'Closed',
  };
  const EnumConstant._();
}
