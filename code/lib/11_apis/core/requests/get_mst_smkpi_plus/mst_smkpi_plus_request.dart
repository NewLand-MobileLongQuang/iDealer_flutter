import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/mst_smkpi_plus_data.dart';

class MstSMKPIPlusRequest extends IdealerApiRequest2 {
  MstSMKPIPlusRequest() {
    endpoint = "Services/Mst_SMKPIPlus_Get";
    addParam("username", UserSessionController.instance().userInfo?.username);
    addParam("password", UserSessionController.instance().userInfo?.password);
    addParam("deviceId", "");
    
  }

  Future<List<MstSMKPIPlusData>> invoke() async {
    var response = await super.coreInvoke();
    List<MstSMKPIPlusData> data = (response as List<dynamic>)
        .map((e) => MstSMKPIPlusData.fromJson(e as Map<String, dynamic>))
        .toList();

    return data;
  }
}
