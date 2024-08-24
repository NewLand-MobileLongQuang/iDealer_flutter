import 'package:flutter/material.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';

class AppTheme {
  static ThemeData getMainThemeData() {
    return ThemeData(
        primaryColor: const Color(0xff0b4c82),
        primarySwatch: createMaterialColor(kPrimaryColor));
  }
}
