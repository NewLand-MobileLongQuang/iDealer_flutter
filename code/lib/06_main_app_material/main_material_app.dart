import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/01_env/env.dart';
import 'package:idealer/05_main_app/main_app.dart';
import 'package:idealer/06_main_app_material/app_layer.dart';

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({Key? key, required this.themeData}) : super(key: key);
  final ThemeData themeData;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppEnv.APP_NAME,
      theme: themeData,
      home: MainApp.instance().welcomeScreen.call(),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            const AppLayer(),
          ],
        );
      },
    );
  }
}
