import 'package:flutter/material.dart';
import 'package:idealer/05_main_app/main_app.dart';
import 'package:idealer/06_main_app_material/main_material_app.dart';
import 'package:idealer/09_base_modules/app_theme/app_theme.dart';
import 'package:idealer/11_screens/home/home_page.dart';
import 'package:idealer/11_screens/login/login_screen.dart';
import 'package:idealer/11_screens/welcome/screens/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainApp.initialize(
    welcomeScreen: () => const WelcomeScreen(),
    loginScreen: () => const LoginScreen(),
    homeScreen: () => const HomeScreen(),
    onInitialize: () async {},
    onInitialized: () async {},
    onReload: () async {},
    onAuthorizedLoaded: () async {},
    onReloaded: () async {},
  );
  runApp(
    MainMaterialApp(
      themeData: AppTheme.getMainThemeData(),
    ),
  );
}
