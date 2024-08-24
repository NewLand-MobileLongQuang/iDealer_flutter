import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/requests/check_phone_no/response/check_phone_no_response.dart';

class CheckPhoneNoRequest extends IdealerApiRequest {
  CheckPhoneNoRequest(
      {required String? customerCode, required String? phoneNo}) {
    endpoint = "Services/CheckPhoneNo";
    addParam(
        "userCodeOwner", UserSessionController.instance().userInfo?.user?.userCode);
    addParam("customerCode", customerCode);
    addParam("phoneNo", phoneNo);
  }

  Future<CheckPhoneNoResponse> invoke() async {
    var response = await super.baseInvoke(CheckPhoneNoResponse.fromJsonModel);
    return response;
  }
}
