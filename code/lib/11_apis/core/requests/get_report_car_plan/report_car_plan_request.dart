import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/car_plan_data.dart';

class ReportCarPlanRequest extends IdealerApiRequest2 {
  ReportCarPlanRequest() {
    endpoint = "Services/ReportCarPlan";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    addParam("dealerCode", UserSessionController.instance().userInfo?.user?.dealerCode);
    
  }

  Future<List<CarPlanData>> invoke() async {
    var response = await super.coreInvoke();
    List<CarPlanData> data = (response as List<dynamic>)
        .map((e) => CarPlanData.fromJson(e as Map<String, dynamic>))
        .toList();

    return data;
  }
}
