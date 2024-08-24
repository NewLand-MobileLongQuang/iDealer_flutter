import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:idealer/05_main_app/main_app.dart';
import 'package:idealer/05_main_app/main_app_loading_result.dart';

import '../welcome/select_org_screen.dart';

class LoadingScreenHelper extends StatefulWidget {
  const LoadingScreenHelper({
    Key? key,
    required this.body,
    required this.goToMain,
    required this.goToLogin,
    required this.onError,
    required this.minStarterTime,
  }) : super(key: key);

  final Widget body;
  final void Function() goToMain;
  final void Function() goToLogin;
  final void Function(Exception error) onError;
  final Duration minStarterTime;

  @override
  State<LoadingScreenHelper> createState() => _LoadingScreenHelperState();
}

class _LoadingScreenHelperState extends State<LoadingScreenHelper> {
  late Future starterFuture;
  late Future minTimeFuture;

  Future<void> starter() async {
    try {
      var futures = <Future>[];
      futures.add(Future.delayed(widget.minStarterTime));
      futures.add(MainApp.instance().reload());

      var results = await Future.wait(futures);
      MainAppLoadingResult result = results[1];

      if (result == MainAppLoadingResult.error) {
        // --> error
        widget.onError.call(Exception());
      } else if (result == MainAppLoadingResult.unauthorized) {
        // --> login
        widget.goToLogin.call();
      } else if (result == MainAppLoadingResult.authorized) {
        // --> select org
        await SelectOrgScreen.show();
      } else {
        widget.goToMain.call();
      }
    } on Exception catch (exception) {
      widget.onError.call(exception);
    }
  }

  @override
  void initState() {
    super.initState();
    starter();
  }

  @override
  Widget build(BuildContext context) {
    return widget.body;
  }
}
