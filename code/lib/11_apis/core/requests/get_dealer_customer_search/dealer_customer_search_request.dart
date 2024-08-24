import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/dealer_customer_contact_search_data.dart';

class DealerCustomerSearchRequest extends IdealerApiRequest2 {
  DealerCustomerSearchRequest(
    String fullName,
    String phoneNo,
    String phonenolh,
    String usercodeowner,
    String dealercode,
    String custypecode,
    String cusgrouptype,
    String provincecode,
    String fromdate,
    String todate,
    int pageIndex,
    int pageCount,
  ) {
    endpoint = "Services/DealerCustomer_Search";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    
    addParam("fullname", fullName);
    addParam("phoneno", phoneNo);
    addParam("phonenolh", phonenolh);
    addParam("usercodeowner", usercodeowner);
    addParam("dealercode", dealercode);
    addParam("custypecode", custypecode);
    addParam("cusgrouptype", cusgrouptype);
    addParam("provincecode", provincecode);
    addParam("fromdate", fromdate);
    addParam("todate", todate);
    addParam("pageIndex", pageIndex);
    addParam("pageCount", pageCount);
  }

  Future<List<DealerCustomerContactSearchData>> invoke() async {
    var response = await super.coreInvoke();
    List<DealerCustomerContactSearchData> data = (response as List<dynamic>)
        .map((e) =>
            DealerCustomerContactSearchData.fromJson(e as Map<String, dynamic>))
        .toList();
    return data;
  }
}
