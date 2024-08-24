import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/pivot_retain_data.dart';

class ReportPivotRetainRequest extends IdealerApiRequest2 {
  ReportPivotRetainRequest() {
    endpoint = "Services/RptPivotTonKho";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    addParam("dealerCode", UserSessionController.instance().userInfo?.user?.dealerCode);
    
  }

  Future<List<PivotRetainData>> invoke() async {
    var response = await super.coreInvoke();
    List<PivotRetainData> data = (response as List<dynamic>)
        .map((e) => PivotRetainData.fromJson(e as Map<String, dynamic>))
        .toList();

    return data;
  }
}
