import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/car_model_data.dart';

class CarModelRequest extends IdealerApiRequest2 {
  CarModelRequest() {
    endpoint = "Services/Mst_CarModel_Get";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    addParam("flagActive", UserSessionController.instance().userInfo?.user?.flagActive);
  }

  Future<List<CarModelData>> invoke() async {
    var response = await super.coreInvoke();
    List<CarModelData> data = (response as List<dynamic>)
        .map((e) => CarModelData.fromJson(e as Map<String, dynamic>))
        .toList();

    return data;
  }
}