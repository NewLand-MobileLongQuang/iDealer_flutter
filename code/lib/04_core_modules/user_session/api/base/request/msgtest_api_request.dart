
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/04_core_modules/user_session/api/base/errors/gateway_authenticate_failed_error.dart';
import 'package:idealer/04_core_modules/user_session/api/core/request/core_api_request2.dart';

abstract class MsgtestApiRequest extends CoreApiRequest2 {
  MsgtestApiRequest(){
    baseUrl = AppConfig.instance().msgtestUrl;
  }

  @override
  BaseOptions getBaseOptions(){
    return AppConfig.instance().apiBaseOptions;
  }

}