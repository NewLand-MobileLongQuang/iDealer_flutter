import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/04_core_modules/api_libs/errors/api_error.dart';
import 'package:idealer/04_core_modules/api_libs/errors/cancel_error.dart';
import 'package:idealer/04_core_modules/api_libs/errors/endpoint_not_found_error.dart';
import 'package:idealer/04_core_modules/api_libs/errors/network_error.dart';
import 'package:idealer/04_core_modules/api_libs/errors/no_network_connection_error.dart';
import 'package:idealer/04_core_modules/api_libs/errors/server_error.dart';
import 'package:flutter/foundation.dart';
import '../response/core_api_response.dart';

enum RequestMethod { post, get }

abstract class CoreApiRequest {
  String baseUrl = "";
  String endpoint = "";
  RequestMethod method = RequestMethod.post;
  final Map<String, dynamic> _headers = {};
  final Map<String, dynamic> _params = {};

  CoreApiRequest();

  void addParam(String key, dynamic value) {
    _params[key] = value;
  }

  Map<String, dynamic> getParams() {
    return _params;
  }

  void addHeader(String key, dynamic value) {
    _headers[key] = value;
  }

  Map<String, dynamic> getHeaders() {
    return _headers;
  }

  @protected
  Future<T> coreInvoke<T extends CoreApiResponse>(
      T Function(Map<String, dynamic> json) fromJsonModel) async {
    if (AppConfig.instance().isLogApiRequest) {
      debugPrint("REQUEST:");
      debugPrint("BaseUrl: $baseUrl");
      debugPrint("Endpoint: $endpoint");
      debugPrint("Url: $baseUrl$endpoint");
      var headers = getHeaders();
      headers.forEach((key, value) {
        debugPrint("Header: $key => $value");
      });
      var params = getParams();
      params.forEach((key, value) {
        log("Params: $key => $value");
      });
    }

    Dio dio = Dio(getBaseOptions());
    dio.options.baseUrl = baseUrl;
    dio.options.headers.addAll(getHeaders());
    var formData = FormData.fromMap(getParams());
    try {
      var response = await dio.post(endpoint, data: formData);
      if (AppConfig.instance().isLogApiRequest) {
        log("response : ${jsonEncode(fromJsonModel(response.data))}");
      }
      return fromJsonModel(response.data);
    } on DioError catch (e) {
      if (AppConfig.instance().isLogApiRequest) {
        log("Error : ${e.error}");
      }
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          {
            throw NetworkError();
          }
        case DioErrorType.response:
          {
            if (e.response != null && e.response!.statusCode == 404) {
              throw EndpointNotFoundError();
            }
            throw ServerError();
          }
        case DioErrorType.cancel:
          {
            throw CancelError();
          }
        case DioErrorType.other:
          {
            if (e.error != null) {
              if (e.error is SocketException) throw NoNetworkConnectionError();
            } else {
              throw ApiError.fromException(e.error);
            }
          }
          break;
      }
      throw ApiError.fromException(e.error);
    }
  }

  BaseOptions getBaseOptions();
}
