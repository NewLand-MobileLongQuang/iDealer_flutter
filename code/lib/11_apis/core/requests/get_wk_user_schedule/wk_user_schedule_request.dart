import 'dart:convert';

import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';

import 'response/wk_user_schedule_response.dart';

class WkUserScheduleRequest extends IdealerApiRequest {
  WkUserScheduleRequest(String fromDate, String toDate, String usStatus,
      String leveltype, String kpiplusname, int pageIndex, int pageCount) {
    endpoint = "Services/Wk_UserSchedule_Search";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    
    addParam("dealerCode", UserSessionController.instance().userInfo?.user?.dealerCode);
    addParam("usStatus", usStatus);
    addParam("fromDate", fromDate);
    addParam("toDate", toDate);
    addParam("createby", "");
    addParam("leveltype", leveltype);
    addParam("customername", kpiplusname);
    addParam("pageIndex", pageIndex);
    addParam("pageCount", pageCount);
    // addParam("fromDate", "2022-08-01");
    // addParam("toDate", "2022-08-01");
  }

  Future<WkUserScheduleResponse> invoke() async {
    var response = await super.baseInvoke(WkUserScheduleResponse.fromJsonModel);
    print("Wk_UserSchedule_Search object ${jsonEncode(response)}");
    return response;
  }
}
