import 'package:flutter/material.dart';
import 'package:idealer/05_main_app/main_app.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';
import 'package:idealer/11_screens/welcome/screens/componets/background.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  static Future<bool?> show(BuildContext context) {
    return MainGet.offAll<bool>(const ErrorScreen());
  }

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 2,
              ),
              const Text(
                "Có lỗi xảy ra. Vui lòng thử lại",
                style:
                    TextStyle(color: Colors.white, fontSize: 16, height: 1.8),
                textAlign: TextAlign.center,
              ),
              const Spacer(
                flex: 1,
              ),
              ElevatedButton(
                onPressed: () {
                  MainApp.restartToWelcome();
                },
                child: const Text("Tải lại"),
              )
            ],
          ),
        )
      ],
    );
  }
}
