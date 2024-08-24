import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/mst_card_type_data.dart';

class MstCardTypeRequest extends IdealerApiRequest2 {
  MstCardTypeRequest() {
    endpoint = "Services/MstCardType_Get";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    
        addParam("flagActive", UserSessionController.instance().userInfo?.user?.flagActive);

  }

  Future<List<MstCardTypeData>> invoke() async {
    var response = await super.coreInvoke();
    List<MstCardTypeData> data = (response as List<dynamic>)
        .map((e) => MstCardTypeData.fromJson(e as Map<String, dynamic>))
        .toList();

    return data;
  }
}
