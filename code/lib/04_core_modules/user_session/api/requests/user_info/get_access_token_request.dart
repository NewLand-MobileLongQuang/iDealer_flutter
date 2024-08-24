import 'package:idealer/04_core_modules/user_session/api/base/errors/unknown_error.dart';
import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request.dart';
import 'package:idealer/04_core_modules/user_session/api/requests/user_info/response/user_info_response/user_response.dart';

import 'response/get_access_token/get_access_token_response.dart';

class GetAccessTokenRequest extends IdealerApiRequest {
  GetAccessTokenRequest({
    required String username,
    required String password,
    String deviceId = "",
  }) {
    endpoint = "Services/GetAccessToken";
    addParam("Email", username);
    addParam("Password", password);
    // addParam("deviceId", deviceId);
  }

  Future<GetAccessTokenResponse> invoke() async {
    var response = await super.baseInvoke(GetAccessTokenResponse.fromJson);
    if (response.hasError()) {
      throw UnknownError.fromResponse(response);
    }
    return response;
  }
}
