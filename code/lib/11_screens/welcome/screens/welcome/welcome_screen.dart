import 'package:flutter/material.dart';
import 'package:idealer/05_main_app/main_app.dart';
import 'package:idealer/11_screens/welcome/screens/componets/background.dart';
import 'package:idealer/11_screens/welcome/screens/error/error_screen.dart';
import 'package:idealer/11_screens/welcome/screens/helper/loading_screen_helper.dart';
import 'package:idealer/11_screens/welcome/screens/welcome/select_org_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LoadingScreenHelper(
      body: const Scaffold(
        body: Background(),
      ),
      goToMain: () {
        MainApp.restartToHome();
      },
      goToLogin: () {
        MainApp.restartToLogin();
      },
      onError: (error) {
        ErrorScreen.show(context);
      },
      minStarterTime: const Duration(milliseconds: 500),
    );
  }
}
