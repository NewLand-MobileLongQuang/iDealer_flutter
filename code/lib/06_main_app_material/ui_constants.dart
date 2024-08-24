import 'package:flutter/material.dart';

//Color(0xff0b4c82)
const kPrimaryColor = Colors.blue;
const kDefaultPadding = 20.0;
const Color blackColor = Color(0xff0E223D);
const Color titleBlackColor = Color(0xff5F7D95);
const kTextFieldErrorColor = Colors.orangeAccent;
const starColor = Colors.redAccent;
const kSelectOrgColor = Color(0xFFD7ECE3);


MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
