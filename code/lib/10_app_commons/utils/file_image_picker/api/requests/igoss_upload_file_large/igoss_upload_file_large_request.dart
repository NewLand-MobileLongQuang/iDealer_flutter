import 'dart:io';

import 'package:dio/dio.dart';
import 'package:idealer/04_core_modules/user_session/api/base/errors/unknown_error.dart';
import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request.dart';
// import 'package:igoss/commons/api/base/errors/invalid_out_size_error.dart';
// import 'package:igoss/commons/api/base/errors/invalid_param_error.dart';
// import 'package:igoss/commons/api/base/errors/unknown_error.dart';
// import 'package:igoss/commons/api/base/request/network_org_token_api_request.dart';

import 'response/igoss_upload_file_large_response.dart';

class IGossUploadFileLargeRequest extends IdealerApiRequest {
  //
  IGossUploadFileLargeRequest(
      {required String fileName, required MultipartFile file}) {
    endpoint = "iGoss/iGoss_UploadFile_Large";
    addParam("FileName", fileName);
    addParam("File0", file);
  }

  Future<IGossUploadFileLargeResponse> invoke() async {
    var response =
        await super.baseInvoke(IGossUploadFileLargeResponse.fromJsonModel);
    if (response.data == null) {
      throw UnknownError.fromResponse(response);
    }
    return response;
  }
}
