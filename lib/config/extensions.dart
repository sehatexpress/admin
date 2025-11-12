import 'dart:math' show Random;

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../models/basket_item_model.dart';
import 'constants.dart';
import 'enums.dart';

// screen size
extension ScreenTypeExtension on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 600;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= 600 &&
      MediaQuery.of(this).size.width < 1200;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1200;
  bool get isLarge => MediaQuery.of(this).size.width >= 1920;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Push to a new screen and return the future
  Future<T?> push<T>(Widget screen) =>
      Navigator.push<T>(this, MaterialPageRoute(builder: (_) => screen));

  /// Push and replace current screen and return the future
  Future<T?> pushReplacement<T, TO>(Widget screen) =>
      Navigator.pushReplacement<T, TO>(
        this,
        MaterialPageRoute(builder: (_) => screen),
      );

  /// Push and clear all previous screens and return the future
  Future<T?> pushAndRemoveUntil<T>(Widget screen) =>
      Navigator.pushAndRemoveUntil<T>(
        this,
        MaterialPageRoute(builder: (_) => screen),
        (route) => false,
      );

  void pop() => Navigator.pop(this);

  /// Shorthand for Theme.of(context)
  ThemeData get theme => Theme.of(this);

  /// Shorthand for Theme.of(context).textTheme
  TextTheme get text => theme.textTheme;

  /// Shorthand for Theme.of(context).colorScheme
  ColorScheme get color => theme.colorScheme;

  Future<bool?> showGenericDialog({
    required String title,
    required String content,
  }) => showDialog<bool>(
    context: this,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: const Text('No'),
          onPressed: () => Navigator.of(this).pop(false),
        ),
        ElevatedButton(
          child: const Text('Yes'),
          onPressed: () => Navigator.of(this).pop(true),
        ),
      ],
    ),
  );

  /// Show a bottom sheet with the given child widget
  void showAppBottomSheet({
    required Widget child,
    bool isScrollControlled = false,
    double borderRadius = 16,
  }) {
    showModalBottomSheet(
      context: this,
      isScrollControlled: isScrollControlled,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 24,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SafeArea(child: child),
        );
      },
    );
  }

  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration,
          backgroundColor: Theme.of(this).colorScheme.primary,
        ),
      );
  }

  /// Builds a PopupMenuButton with provided items and onSelected callback.
  /// Returns the widget so you can place it anywhere in the UI.
  Widget popupMenuButton<T>({
    required Map<T, String> items,
    required ValueChanged<T> onSelected,
    Color? popupBackgroundColor,
    Color? buttonBackgroundColor,
    double menuItemHeight = 32,
    Widget? icon,
  }) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: popupBackgroundColor ?? Colors.transparent,
      ),
      child: PopupMenuButton<T>(
        icon: icon ?? const Icon(Icons.more_vert),
        onSelected: onSelected,
        color: buttonBackgroundColor,
        padding: EdgeInsetsGeometry.all(6),
        menuPadding: EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context) {
          return items.entries
              .map(
                (e) => PopupMenuItem<T>(
                  value: e.key,
                  height: menuItemHeight,
                  child: Text(
                    e.value,
                    style: text.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.textColor,
                    ),
                  ),
                ),
              )
              .toList();
        },
      ),
    );
  }

  Widget fabTo(Function()? onPressed) => FloatingActionButton(
    onPressed: onPressed,
    child: const Icon(Icons.add, color: Colors.white, size: 30),
  );
}

extension FormValidationExtensions on String {
  String? get validateEmail {
    if (isEmpty) return '';
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this) ? null : '';
  }

  String? get validateName {
    if (isEmpty || length < 3) return '';
    return null;
  }

  String? get validatePassword {
    if (isEmpty || length < 6) return '';
    return null;
  }

  String? get validatePhone {
    if (isEmpty) return '';
    final phoneRegExp = RegExp(r"^9?[0-9]{10}$");
    return phoneRegExp.hasMatch(this) ? null : '';
  }

  String? get validateAddress {
    if (isEmpty || length < 6) return '';
    return null;
  }
}

extension OrderStatusEnumExtension on OrderStatusEnum {
  static OrderStatusEnum fromString(String val) {
    return EnumConstant.orderStatus[val.toLowerCase()] ??
        OrderStatusEnum.cancelled;
  }
}

extension OrderStatusValue on OrderStatusEnum {
  String get value => toString().split('.').last;
  Color get color => EnumConstant.statusColors[this] ?? Colors.red;
}

//
extension StringExtensions on String {
  String get initialLetters => isNotEmpty
      ? trim()
            .split(' ')
            .where((e) => e.isNotEmpty)
            .map((l) => l[0])
            .take(2)
            .join()
            .toUpperCase()
      : '';

  String get capitalize => isNotEmpty
      ? trim()
            .split(' ')
            .map(
              (e) =>
                  e.isNotEmpty ? '${e[0].toUpperCase()}${e.substring(1)}' : '',
            )
            .join(' ')
      : '';

  bool get isEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  bool get isPhoneNumber => RegExp(r'^\d{10}$').hasMatch(this);

  String get translatedCity {
    if (endsWith('ज')) return 'birgunj';
    if (endsWith('या')) return 'kalaiya';
    return toLowerCase();
  }
}

extension FilterEnumValue on FilterEnum {
  String get value => EnumConstant.filterValues[this] ?? 'Veg';
  String get type => EnumConstant.filterTypes[this] ?? 'veg';
}

extension TicketStatusEnumX on TicketStatusEnum {
  String get value {
    switch (this) {
      case TicketStatusEnum.pending:
        return 'pending';
      case TicketStatusEnum.inProcess:
        return 'in process';
      case TicketStatusEnum.closed:
        return 'closed';
    }
  }

  static TicketStatusEnum fromString(String val) {
    switch (val.trim().toLowerCase()) {
      case 'pending':
        return TicketStatusEnum.pending;
      case 'in process':
        return TicketStatusEnum.inProcess;
      case 'closed':
        return TicketStatusEnum.closed;
      default:
        return TicketStatusEnum.pending;
    }
  }
}

extension DateTimeExtensions on int {
  DateTime get _toDateTime => DateTime.fromMillisecondsSinceEpoch(this);

  String get formattedDate => DateFormat('yyyy-MM-dd').format(_toDateTime);
  String get formattedTime => DateFormat('hh:mm a').format(_toDateTime);
  String get formatDateTime =>
      DateFormat('dd MMM, hh:mm a').format(_toDateTime);

  int differenceInMinutes(int otherMillis) => _toDateTime
      .difference(DateTime.fromMillisecondsSinceEpoch(otherMillis))
      .inMinutes
      .abs();
}

extension StringTimeExtensions on String? {
  String get formattedTimeFromString {
    if (this == null || this!.isEmpty) return '--:--';

    final res = this!.split('.').first.split(':').map(int.parse).toList();
    if (res.length < 2) return '--:--';

    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, res[0], res[1]);

    return DateFormat('hh:mm a').format(dateTime);
  }

  bool get isVoucherExpired {
    if (this != null && this!.length > 1) {
      final now = DateTime.now();
      final expiry = DateFormat("yyyy-MM-dd HH:mm:ss").parse(this!);
      return expiry.isBefore(now);
    }
    return false;
  }
}

extension RestaurantTimeStatus on String {
  String getRestaurantStatus(String closingTime) {
    final openingTimeParts = split(
      '.',
    ).first.split(':').map(int.parse).toList();
    final closingTimeParts = closingTime
        .split('.')
        .first
        .split(':')
        .map(int.parse)
        .toList();

    if (openingTimeParts.length < 2 || closingTimeParts.length < 2) {
      return 'CLOSED';
    }

    final now = DateTime.now();
    final openingDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      openingTimeParts[0],
      openingTimeParts[1],
    );
    final closingDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      closingTimeParts[0],
      closingTimeParts[1],
    );

    if (now.isBefore(openingDateTime)) return 'OPENING SOON';
    if (now.isAfter(closingDateTime)) return 'CLOSED';
    return 'OPEN';
  }
}

extension RestaurantTimeStatusBool on String {
  bool isRestaurantOpen(String closingTime) {
    try {
      final openParts = split('.').first.split(':').map(int.parse).toList();
      final closeParts = closingTime
          .split('.')
          .first
          .split(':')
          .map(int.parse)
          .toList();

      if (openParts.length < 2 || closeParts.length < 2) return false;

      final now = DateTime.now();
      final openTime = DateTime(
        now.year,
        now.month,
        now.day,
        openParts[0],
        openParts[1],
      );
      final closeTime = DateTime(
        now.year,
        now.month,
        now.day,
        closeParts[0],
        closeParts[1],
      );

      return now.isAfter(openTime) && now.isBefore(closeTime);
    } catch (_) {
      return false;
    }
  }
}

extension DateTimeExtension on DateTime {
  int differenceInMinutes(DateTime other) => difference(other).inMinutes;
}

extension GlobalDateHelper on Object {
  /// Today in `yyyy-MM-dd`
  String get today => DateTime.now().toIso8601String().substring(0, 10);

  String get isoDateTimeString => DateTime.now().toIso8601String();

  /// N days ago in `yyyy-MM-dd`
  String daysAgo(int n) => DateTime.now()
      .subtract(Duration(days: n))
      .toIso8601String()
      .substring(0, 10);

  /// N days from now in `yyyy-MM-dd`
  String daysFromNow(int n) =>
      DateTime.now().add(Duration(days: n)).toIso8601String().substring(0, 10);

  /// Convert from millisecondsSinceEpoch to `yyyy-MM-dd`
  String fromEpoch(int ms) => DateTime.fromMillisecondsSinceEpoch(
    ms,
  ).toIso8601String().substring(0, 10);

  /// Generates a random light color for backgrounds
  Color get randomLightColor {
    final random = Random();
    return Color.fromARGB(
      255,
      200 + random.nextInt(56),
      200 + random.nextInt(56),
      200 + random.nextInt(56),
    );
  }

  /// Returns a fresh random placeholder image from Picsum
  String get randomImage {
    final randomId = Random().nextInt(1000);
    return 'https://picsum.photos/seed/$randomId/800/600';
  }
}

extension DateDifferenceInDays on String {
  String getDifferenceInDays() {
    if (isEmpty || length <= 5) return '--:--';

    final expiryDate = DateTime.tryParse(this);
    if (expiryDate == null) return '--:--';

    final diff = expiryDate.difference(DateTime.now());
    if (diff.isNegative) return 'Expired';
    if (diff.inDays == 0) return 'Expires Today';
    return 'Expires in ${diff.inDays} days';
  }
}

extension DateHistoryFormat on DateTime {
  String getHistoryDate() {
    final now = DateTime.now();
    final differenceInDays = now.difference(this).inDays;

    if (differenceInDays == 0) return 'Today';
    if (differenceInDays == 1) return 'Yesterday';

    return DateFormat('yyyy-MM-dd').format(this);
  }
}

extension ExpiryCheck on String {
  bool isExpired() {
    if (isEmpty || length <= 5) return false;

    final expiryDate = DateTime.tryParse(this);
    return expiryDate?.isBefore(DateTime.now()) ?? false;
  }
}

/// 🔹 **Extension to Handle Firebase Errors Gracefully**
extension FirebaseErrorHandler on dynamic {
  String get firebaseErrorMessage {
    if (this is FirebaseAuthException) {
      return (this as FirebaseAuthException).message ??
          "An unknown authentication error occurred.";
    } else if (this is FirebaseException) {
      return (this as FirebaseException).message ??
          "Something went wrong with Firebase!";
    } else {
      return "Unexpected error: ${toString()}";
    }
  }
}

extension CommissionTypeX on CommissionTypeEnum {
  String get symbol => this == CommissionTypeEnum.flat ? '-' : '%';

  String get label => this == CommissionTypeEnum.flat ? 'FLAT' : 'PERCENTAGE';

  static CommissionTypeEnum fromSymbol(String val) {
    return val == '-' ? CommissionTypeEnum.flat : CommissionTypeEnum.percentage;
  }
}

extension MenuTypeX on MenuTypeEnum {
  String get value {
    switch (this) {
      case MenuTypeEnum.veg:
        return 'veg';
      case MenuTypeEnum.non_veg:
        return 'non veg';
      case MenuTypeEnum.both:
        return 'both';
    }
  }

  static MenuTypeEnum fromString(String val) {
    final normalized = val.trim().toLowerCase();
    switch (normalized) {
      case 'veg':
        return MenuTypeEnum.veg;
      case 'non veg':
        return MenuTypeEnum.non_veg;
      case 'both':
      default:
        return MenuTypeEnum.both;
    }
  }
}

extension RoleEnumX on RoleEnum {
  String get value => name;

  static RoleEnum fromString(String val) {
    switch (val.toLowerCase().trim()) {
      case 'super_admin':
        return RoleEnum.super_admin;
      case 'admin':
        return RoleEnum.admin;
      case 'sub_admin':
        return RoleEnum.sub_admin;
      case 'accountant':
      default:
        return RoleEnum.accountant;
    }
  }
}

extension VerificationStatusEnumX on VerificationStatusEnum {
  String get value => name;

  static VerificationStatusEnum fromString(String val) {
    switch (val.toLowerCase().trim()) {
      case 'verified':
        return VerificationStatusEnum.verified;
      case 'pending':
        return VerificationStatusEnum.pending;
      default:
        return VerificationStatusEnum.pending;
    }
  }
}

extension OrderPlatformEnumX on OrderPlatformEnum {
  String get value => name;

  static OrderPlatformEnum fromString(String val) {
    return val.toLowerCase() == 'web'
        ? OrderPlatformEnum.web
        : OrderPlatformEnum.mobile;
  }
}

extension BasketItemListExtension on List<BasketItemModel> {
  /// Returns either the amount payable to restaurant or total commission
  double calculateAmount({bool toRestaurant = true}) {
    num total = 0;
    num commission = 0;

    for (var item in this) {
      final itemTotal = item.price * item.quantity;
      final commissionAmount =
          item.commissionType == CommissionTypeEnum.percentage
          ? itemTotal * (item.commission / 100)
          : item.commission * item.quantity;

      total += (itemTotal - commissionAmount);
      commission += commissionAmount;
    }

    return double.parse((toRestaurant ? total : commission).toStringAsFixed(2));
  }

  /// Returns total extra commission amount on all items
  double get extraCommission {
    return fold(
      0,
      (prev, item) => prev + ((item.sellingPrice - item.price) * item.quantity),
    );
  }
}
