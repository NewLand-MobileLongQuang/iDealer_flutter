import 'package:idealer/04_core_modules/user_session/api/base/errors/unknown_error.dart';
import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request_3.dart';
import 'package:idealer/04_core_modules/user_session/api/requests/user_info/response/select_org_response/select_org_response.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';

class SelectOrgRequest extends IdealerApiRequest3 {
  SelectOrgRequest() {
    endpoint = "Services/OS_Inos_Org_GetMyOrgList";
    addParam("wausercode", UserSessionController.instance().userInfo?.username ?? "");
    addParam("AccessToken", UserSessionController.instance().token);
  }

  Future<SelectOrgResponse> invoke() async {
    var response = await super.baseInvoke(SelectOrgResponse.fromJson);
    if (response.hasError()) {
      throw UnknownError.fromResponse(response);
    }
    return response;
  }
}
