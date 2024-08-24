import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/mst_district_data.dart';

class MstDistrictRequest extends IdealerApiRequest2 {
  MstDistrictRequest(String provinceCode) {
    endpoint = "Services/MstDistrict_Get";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    
        addParam("flagActive", UserSessionController.instance().userInfo?.user?.flagActive);

    addParam("provinceCode", provinceCode);
  }

  Future<List<MstDistrictData>> invoke() async {
    var response = await super.coreInvoke();
    List<MstDistrictData> data = (response as List<dynamic>)
        .map((e) => MstDistrictData.fromJson(e as Map<String, dynamic>))
        .toList();

    return data;
  }
}
