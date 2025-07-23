import 'dart:math' show Random;

import 'package:flutter/material.dart'
    show
        BorderRadius,
        BorderSide,
        Color,
        FontWeight,
        OutlineInputBorder,
        TextStyle;

TextStyle textDecorationTextStyle(
  Color color, {
  FontWeight fontWeight = FontWeight.w400,
  double fontSize = 13,
}) =>
    TextStyle(
      color: color,
      letterSpacing: .5,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );

OutlineInputBorder outlineInputBorder(Color color) => OutlineInputBorder(
      borderSide: BorderSide(
        width: .5,
        color: color,
      ),
      borderRadius: BorderRadius.circular(8),
    );

String generateRandomString(int len) {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}
