import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/user_by_dealer_data.dart';
import 'package:idealer/11_apis/core/models/work_detail_data.dart';

class WorkDetailRequest extends IdealerApiRequest2 {
  WorkDetailRequest(String schCode) {
    endpoint = "Services/Wk_UserSchedule_Get";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    addParam("dealerCode", UserSessionController.instance().userInfo?.user?.dealerCode);
    
    addParam("schCode", schCode);
  }

  Future<List<WorkDetailData>> invoke() async {
    var response = await super.coreInvoke();
    List<WorkDetailData> data = (response as List<dynamic>)
        .map((e) => WorkDetailData.fromJson(e as Map<String, dynamic>))
        .toList();

    return data;
  }
}
