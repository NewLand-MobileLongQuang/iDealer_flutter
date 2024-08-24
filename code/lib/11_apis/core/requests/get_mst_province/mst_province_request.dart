import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/mst_province_data.dart';

class MstProvinceRequest extends IdealerApiRequest2 {
  MstProvinceRequest() {
    endpoint = "Services/MstProvince_Get";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    
        addParam("flagActive", UserSessionController.instance().userInfo?.user?.flagActive);

  }

  Future<List<MstProvinceData>> invoke() async {
    var response = await super.coreInvoke();
    List<MstProvinceData> data = (response as List<dynamic>)
        .map((e) => MstProvinceData.fromJson(e as Map<String, dynamic>))
        .toList();

    return data;
  }
}
