import 'package:idealer/04_core_modules/user_session/api/base/errors/unknown_error.dart';
import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/requests/get_sales_process_search/response/sales_process_search_response.dart';

class SalesProcessSearchRequest extends IdealerApiRequest {
  SalesProcessSearchRequest(
      String fromDate,
      String toDate,
      String cusfullname,
      String thamkhao,
      String quantam,
      String laithu,
      String damphan,
      String kyhd,
      String huy,
      int pageIndex,
      int pageCount,
      ) {
    endpoint = "Services/SalesProcess_Search";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    
    addParam("fromdate", fromDate);
    addParam("todate", toDate);
    addParam("cusfullname", cusfullname);
    addParam("thamkhao", thamkhao);
    addParam("quantam", quantam);
    addParam("laithu", laithu);
    addParam("damphan", damphan);
    addParam("kyhd", kyhd);
    addParam("huy", huy);
    addParam("pageIndex", pageIndex);
    addParam("pageCount", pageCount);
  }
  Future<SalesProcessSearchResponse> invoke() async {
    var response = await super.baseInvoke(SalesProcessSearchResponse.fromJsonModel);
    // if (response.hasError()) {
    //   throw UnknownError.fromResponse(response);
    // }
    return response;
  }
}
