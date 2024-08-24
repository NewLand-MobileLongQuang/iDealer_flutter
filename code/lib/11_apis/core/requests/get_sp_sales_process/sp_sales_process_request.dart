import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/save_sp_sales_process_data.dart';

class SpSalesProcessRequest extends IdealerApiRequest2 {
  SpSalesProcessRequest(String salesId) {
    endpoint = "Services/SP_SalesProcess_Get";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    addParam("dealerCode", UserSessionController.instance().userInfo?.user?.dealerCode);
    
    addParam("salesId", salesId);
  }

  Future<List<SaveSpSaleProcessData>> invoke() async {
    var response = await super.coreInvoke();
    List<SaveSpSaleProcessData> data = (response as List<dynamic>)
        .map((e) => SaveSpSaleProcessData.fromJson(e as Map<String, dynamic>))
        .toList();

    return data;
  }
}
