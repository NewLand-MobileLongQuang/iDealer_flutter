import 'dart:convert';

import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request.dart';
import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/save_work.dart';

class SaveWorkCreateRequest extends IdealerApiRequest {
  SaveWorkCreateRequest(SaveWork saveWork) {
    endpoint = "Services/Wk_UserSchedule_Create";
    addParam("usercode", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    
    addParam("dealerCode", UserSessionController.instance().userInfo?.user?.dealerCode);
    var json = jsonEncode(saveWork);
    addParam("json", json);
  }

  Future<BaseResponse> invoke() async {
    var response = await super.baseInvoke(BaseResponse.fromJsonModel);
    return response;
  }
}
