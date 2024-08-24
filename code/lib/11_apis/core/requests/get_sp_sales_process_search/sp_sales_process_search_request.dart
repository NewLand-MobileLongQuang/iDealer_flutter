import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/sp_sales_process_search_data.dart';

class SPSalesProcessSearchRequest extends IdealerApiRequest2 {
  SPSalesProcessSearchRequest(
    String salesId,
    String fromDate,
    String toDate,
    String fullName,
    String phoneNo,
    String createBy,
    String spStatus,
    int pageIndex,
    int pageCount,
  ) {
    endpoint = "Services/SPSalesProcess_Search_PopUp";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    
    addParam("salesid", salesId);
    addParam("fromdate", fromDate);
    addParam("todate", toDate);
    addParam("fullname", fullName);
    addParam("phoneno", phoneNo);
    addParam("createby", createBy);
    addParam("spstatus", spStatus);
    addParam("pageIndex", pageIndex);
    addParam("pageCount", pageCount);
  }

  Future<List<SPSalesProcessSearchData>> invoke() async {
    var response = await super.coreInvoke();
    List<SPSalesProcessSearchData> data = (response as List<dynamic>)
        .map(
            (e) => SPSalesProcessSearchData.fromJson(e as Map<String, dynamic>))
        .toList();
    return data;
  }
}
