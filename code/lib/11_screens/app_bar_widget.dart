import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/05_main_app/main_app.dart';

class AppBarWidget extends AppBar{
  AppBarWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.text,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
            onPressed: () {
              MainApp.restartToHome();
            },
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ))
      ],
    );
  }
}
