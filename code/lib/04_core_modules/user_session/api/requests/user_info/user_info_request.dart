import 'package:idealer/04_core_modules/user_session/api/base/errors/unknown_error.dart';
import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request_login.dart';
import 'package:idealer/04_core_modules/user_session/api/requests/user_info/response/user_info_response/user_response.dart';

class UserInfoRequest extends IdealerApiRequestLogin {
  UserInfoRequest({
    required String username,
    required String password,
    String deviceId = "",
  }) {
    endpoint = "Services/login";
    addParam("Email", username);
    addParam("Password", password);
    // addParam("deviceId", deviceId);
  }

  Future<UserInfoResponse> invoke() async {
    var response = await super.baseInvoke(UserInfoResponse.fromJson);
    if (response.hasError()) {
      throw UnknownError.fromResponse(response);
    }
    return response;
  }
}
