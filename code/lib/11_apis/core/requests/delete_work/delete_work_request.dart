
import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request.dart';
import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';

class DeleteWorkRequest extends IdealerApiRequest {
  DeleteWorkRequest(String schCode) {
    endpoint = "Services/Wk_UserSchedule_Delete";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("schCode", schCode);
  }

  Future<BaseResponse> invoke() async {
    var response = await super.baseInvoke(BaseResponse.fromJsonModel);
    return response;
  }
}