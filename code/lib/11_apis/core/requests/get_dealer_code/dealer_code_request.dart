import 'package:idealer/04_core_modules/user_session/api/base/errors/unknown_error.dart';
import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request.dart';

import 'response/dealer_code_response.dart';

class DealerCodeRequest extends IdealerApiRequest {
  DealerCodeRequest() {
    endpoint = "Services/GetListDealerCode";
  }
  Future<DealerCodeResponse> invoke() async {
    var response = await super.baseInvoke(DealerCodeResponse.fromJsonModel);
    if (response.hasError()) {
      throw UnknownError.fromResponse(response);
    }
    return response;
  }
}
