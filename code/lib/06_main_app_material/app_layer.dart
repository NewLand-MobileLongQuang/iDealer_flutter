import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';

class AppLayer extends StatefulWidget {
  const AppLayer({Key? key}) : super(key: key);

  @override
  State<AppLayer> createState() => _AppLayerState();
}

class _AppLayerState extends State<AppLayer> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      UserSessionController.instance().checkAndRefreshToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var needRestartBecauseOfTokenExpired = UserSessionController.instance()
          .needRestartBecauseOfTokenExpired
          .value;
      if (needRestartBecauseOfTokenExpired == true) {
        return Container(
          color: Colors.grey.withOpacity(0.5),
          child: Center(
            child: AlertDialog(
              title: const Text("Thông báo"),
              content: const Text(
                  "Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại"),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    UserSessionController.instance()
                        .restartBecauseOfTokenExpired();
                  },
                ),
              ],
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
