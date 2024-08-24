import 'dart:convert';

import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request.dart';
import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/save_dealer_customer_create_data.dart';

class UpdatePhoneNoRequest extends IdealerApiRequest {
  UpdatePhoneNoRequest(SaveDealerCustomerData saveDealerCustomerData) {
    endpoint = "Services/DealerCustomer_UpdatePhoneNo";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    
    var json = jsonEncode(saveDealerCustomerData);
    addParam("json", json);
  }

  Future<BaseResponse> invoke() async {
    var response = await super.baseInvoke(BaseResponse.fromJsonModel);
    return response;
  }
}
