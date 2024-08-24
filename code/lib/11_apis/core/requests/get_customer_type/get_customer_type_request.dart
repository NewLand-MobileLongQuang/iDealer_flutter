import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/customer_type_data.dart';

class GetCustomerTypeRequest extends IdealerApiRequest2 {
  GetCustomerTypeRequest() {
    endpoint = "Services/DealerCustomerType_Get";
    
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
        addParam("flagActive", UserSessionController.instance().userInfo?.user?.flagActive);

  }

  Future<List<CustomerTypeData>> invoke() async {
    var response = await super.coreInvoke();
    List<CustomerTypeData> data = (response as List<dynamic>)
        .map((e) => CustomerTypeData.fromJson(e as Map<String, dynamic>))
        .toList();
    return data;
  }
}
