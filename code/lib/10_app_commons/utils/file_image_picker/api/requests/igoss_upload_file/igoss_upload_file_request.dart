// import 'package:igoss/commons/api/base/errors/invalid_out_size_error.dart';
// import 'package:igoss/commons/api/base/errors/invalid_param_error.dart';
// import 'package:igoss/commons/api/base/errors/unknown_error.dart';
// import 'package:igoss/commons/api/base/request/network_org_token_api_request.dart';
// import 'package:igoss/modules/ecore_modules/inventory2/commons_base/utils/file_image_picker/api/requests/igoss_upload_file/response/igoss_upload_file_response.dart';

import 'package:idealer/04_core_modules/user_session/api/base/errors/unknown_error.dart';
import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request.dart';
import 'package:idealer/10_app_commons/utils/file_image_picker/api/requests/igoss_upload_file/response/igoss_upload_file_data.dart';

class IGossUploadFileRequest extends IdealerApiRequest {
  //
  IGossUploadFileRequest(
      {required String fileName, required String fileBase64}) {
    endpoint = "Services/UploadFileFromMobile";
    addParam("fileName", fileName);
    addParam("uploadFileAsBase64String", fileBase64);
  }

  Future<IGossUploadFileData> invoke() async {
    var response = await super.baseInvoke(IGossUploadFileData.fromJsonModel);
    if (response.hasError()) {
      throw UnknownError.fromResponse(response);
    }
    return response;
  }
}
