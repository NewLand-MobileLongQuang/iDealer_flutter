
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/04_core_modules/user_session/api/base/errors/gateway_authenticate_failed_error.dart';
import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
import 'package:idealer/04_core_modules/user_session/api/core/request/core_api_request.dart';
import 'package:idealer/04_core_modules/user_session/api/requests/user_info/response/user_info_response/user_response.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';

abstract class IdealerApiRequest3 extends CoreApiRequest {
  IdealerApiRequest3(){
    baseUrl = AppConfig.instance().accountMobileUrl;
    // addHeader("networkId", UserSessionController.instance().userInfo?.user?.networkId ?? "");
    addHeader("Authorization", "Bearer ${UserSessionController.instance().token}");
  }

  @override
  BaseOptions getBaseOptions(){
    return AppConfig.instance().apiBaseOptions;
  }

  @protected
  Future<T> baseInvoke<T extends BaseResponse>(
      T Function(Map<String, dynamic> json) fromJsonModel
      ) async {
    var response = await super.coreInvoke(fromJsonModel);
    if (response.errorCode().contains("GatewayAuthenticateFailed")){
      throw const GatewayAuthenticateFailedError();
    }
    return response;
  }
}