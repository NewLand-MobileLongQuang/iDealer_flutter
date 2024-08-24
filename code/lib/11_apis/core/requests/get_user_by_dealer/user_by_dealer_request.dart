import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/user_by_dealer_data.dart';

class UserByDealerRequest extends IdealerApiRequest2 {
  UserByDealerRequest() {
    endpoint = "Services/GetListSysUserByDealerCode";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    addParam("dealerCode", UserSessionController.instance().userInfo?.user?.dealerCode);
    
  }

  Future<List<UserByDealerData>> invoke() async {
    var response = await super.coreInvoke();
    List<UserByDealerData> data = (response as List<dynamic>)
        .map((e) => UserByDealerData.fromJson(e as Map<String, dynamic>))
        .toList();

    return data;
  }
}
