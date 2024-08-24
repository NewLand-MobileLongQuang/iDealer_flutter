import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/reason_cancel_data.dart';

class ReasonCancelRequest extends IdealerApiRequest2 {
  ReasonCancelRequest(String reasonCode) {
    endpoint = "Services/Mst_SalesProcessCancelReason_Get";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    
    addParam("dealerCode", UserSessionController.instance().userInfo?.user?.dealerCode);
        addParam("flagActive", UserSessionController.instance().userInfo?.user?.flagActive);

    addParam("reasonCode", reasonCode);
  }

  Future<List<ReasonCancelData>> invoke() async {
    var response = await super.coreInvoke();
    List<ReasonCancelData> data = (response as List<dynamic>)
        .map((e) => ReasonCancelData.fromJson(e as Map<String, dynamic>))
        .toList();
    return data;
  }
}
