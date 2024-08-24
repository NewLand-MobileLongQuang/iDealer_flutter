import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/04_core_modules/user_session/api/base/errors/base_api_error.dart';
import 'package:idealer/04_core_modules/user_session/api/base/errors/gateway_authenticate_failed_error.dart';
import 'package:idealer/04_core_modules/user_session/api/core/request/core_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';

abstract class IdealerApiRequest2 extends CoreApiRequest2 {
  IdealerApiRequest2() {
    baseUrl = AppConfig.instance().accountMobileUrl;
    addHeader("networkId",
        UserSessionController.instance().org?.id ?? "");
    addHeader(
        "Authorization", "Bearer ${UserSessionController.instance().token}");
  }

  @override
  BaseOptions getBaseOptions() {
    return AppConfig.instance().apiBaseOptions;
  }

  Future<dynamic> baseInvoke() async {
    var response = await super.coreInvoke();
    BaseApiError.checkAndThrow(response);
    return response;
  }
}
