import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/customer_group_type_data.dart';

class GetCustomerGroupTypeRequest extends IdealerApiRequest2 {
  GetCustomerGroupTypeRequest() {
    endpoint = "Services/DealerCustomerGroupType_Get";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    addParam(
        "flagActive", UserSessionController.instance().userInfo?.user?.flagActive);
  }

  Future<List<CustomerGroupTypeData>> invoke() async {
    var response = await super.coreInvoke();
    List<CustomerGroupTypeData> data = (response as List<dynamic>)
        .map((e) => CustomerGroupTypeData.fromJson(e as Map<String, dynamic>))
        .toList();
    return data;
  }
}
