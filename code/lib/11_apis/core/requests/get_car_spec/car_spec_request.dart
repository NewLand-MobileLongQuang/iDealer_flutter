import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/car_spec_data.dart';

class CarSpecRequest extends IdealerApiRequest2 {
  CarSpecRequest(String modelCode) {
    endpoint = "Services/Mst_CarSpec_Get";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    addParam("flagActive", UserSessionController.instance().userInfo?.user?.flagActive);
    addParam("modelCode", modelCode);
  }

  Future<List<CarSpecData>> invoke() async {
    var response = await super.coreInvoke();
    List<CarSpecData> data = (response as List<dynamic>)
        .map((e) => CarSpecData.fromJson(e as Map<String, dynamic>))
        .toList();

    return data;
  }
}