import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/save_dealer_customer_create_data.dart';

class GetDealerCustomerByCodeRequest extends IdealerApiRequest2 {
  GetDealerCustomerByCodeRequest({required String? customerCode}) {
    endpoint = "Services/DealerCustomer_GetByCustomerCode";
    
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    addParam("customerCode", customerCode);
  }

  Future<List<SaveDealerCustomerData>> invoke() async {
    var response = await super.coreInvoke();
    List<SaveDealerCustomerData> data = (response as List<dynamic>)
        .map((e) => SaveDealerCustomerData.fromJson(e as Map<String, dynamic>))
        .toList();
    return data;
  }
}
