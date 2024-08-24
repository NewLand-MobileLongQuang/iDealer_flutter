import 'dart:convert';

import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/requests/get_customer_no/response/get_customer_no_response.dart';

class GetCustomerNoRequest extends IdealerApiRequest {
  GetCustomerNoRequest() {
    endpoint = "Services/GetCustomerNo";
  }

  Future<GetCustomerNoResponse> invoke() async {
    var response = await super.baseInvoke(GetCustomerNoResponse.fromJsonModel);
    print("Wk_UserSchedule_Search object ${jsonEncode(response)}");
    return response;
  }
}
