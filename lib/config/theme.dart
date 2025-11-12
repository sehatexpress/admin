import 'package:flutter/material.dart';

import 'constants.dart' show ColorConstants;
import 'utils.dart';

ThemeData get theme => ThemeData(
  fontFamily: ColorConstants.fontFamily,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey.shade50,
  colorScheme: const ColorScheme(
    primary: ColorConstants.primary,
    secondary: ColorConstants.secondary,
    surface: ColorConstants.surface,
    error: ColorConstants.error,
    brightness: Brightness.light,
    onPrimary: ColorConstants.onPrimary,
    onSecondary: ColorConstants.onSecondary,
    onError: ColorConstants.onError,
    onSurface: ColorConstants.onSurface,
  ),
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: AppBarTheme(
    elevation: 0,
    titleSpacing: 0,
    centerTitle: false,
    iconTheme: const IconThemeData(color: Colors.white, size: 20),
    titleTextStyle: textDecorationTextStyle(
      Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    actionsIconTheme: const IconThemeData(size: 20),
    backgroundColor: ColorConstants.primary,
  ),
  dividerTheme: DividerThemeData(thickness: .75, color: Colors.grey.shade200),
  iconTheme: const IconThemeData(size: 20),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    isDense: true,
    errorMaxLines: 1,
    helperMaxLines: 0,
    fillColor: Colors.white,
    alignLabelWithHint: true,
    errorStyle: const TextStyle(height: 1, fontSize: 0),
    hintStyle: textDecorationTextStyle(ColorConstants.textColor.withAlpha(127)),
    labelStyle: textDecorationTextStyle(Colors.grey),
    prefixStyle: textDecorationTextStyle(Colors.yellow),
    helperStyle: textDecorationTextStyle(Colors.blue),
    counterStyle: textDecorationTextStyle(Colors.purple),
    floatingLabelStyle: textDecorationTextStyle(Colors.green),
    suffixStyle: textDecorationTextStyle(Colors.grey),
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    border: outlineInputBorder(Colors.grey),
    enabledBorder: outlineInputBorder(Colors.white),
    focusedBorder: outlineInputBorder(Colors.white),
    focusedErrorBorder: outlineInputBorder(Colors.red),
    disabledBorder: outlineInputBorder(Colors.white),
    errorBorder: outlineInputBorder(Colors.red.shade500),
  ),
  dialogTheme: DialogThemeData(
    backgroundColor: Colors.grey.shade50,
    titleTextStyle: textDecorationTextStyle(
      ColorConstants.textColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle: textDecorationTextStyle(ColorConstants.textColor),
    actionsPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    clipBehavior: Clip.antiAlias,
    backgroundColor: Color(0xFFF5F5F5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  ),
  tabBarTheme: TabBarThemeData(
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(width: 2.0, color: ColorConstants.primary),
    ),
    labelColor: ColorConstants.primary,
    labelStyle: textDecorationTextStyle(
      ColorConstants.primary,
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelColor: ColorConstants.textColor,
    unselectedLabelStyle: textDecorationTextStyle(
      ColorConstants.textColor,
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: ColorConstants.primary,
    selectedIconTheme: const IconThemeData(
      size: 20,
      color: ColorConstants.primary,
    ),
    unselectedItemColor: ColorConstants.textColor,
    unselectedIconTheme: const IconThemeData(
      size: 20,
      color: ColorConstants.textColor,
    ),
    selectedLabelStyle: textDecorationTextStyle(
      ColorConstants.primary,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: textDecorationTextStyle(
      ColorConstants.textColor,
      fontWeight: FontWeight.w500,
    ),
  ),
  snackBarTheme: const SnackBarThemeData(
    elevation: 0,
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: TextButton.styleFrom(iconSize: 20),
  ),
  popupMenuTheme: PopupMenuThemeData(
    iconSize: 16,
    iconColor: ColorConstants.textColor,
    menuPadding: EdgeInsets.zero,
  ),
);
