import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';

import 'response/work_code_response.dart';

class WorkCodeRequest extends IdealerApiRequest {
  WorkCodeRequest() {
    endpoint = "Services/GetSchCode";
    
  }

  Future<WorkCodeResponse> invoke() async {
    var response = await super.baseInvoke(WorkCodeResponse.fromJsonModel);
    return response;
  }
}
