import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/marketing_strategy_data.dart';

class MarketingStrategyRequest extends IdealerApiRequest2 {
  MarketingStrategyRequest() {
    endpoint = "Services/Mkt_Campaign_Get";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    
    addParam("flagActive", UserSessionController.instance().userInfo?.user?.flagActive);
  }

  Future<List<MarketingStrategyData>> invoke() async {
    var response = await super.coreInvoke();
    List<MarketingStrategyData> data = (response as List<dynamic>)
        .map((e) => MarketingStrategyData.fromJson(e as Map<String, dynamic>))
        .toList();

    return data;
  }
}