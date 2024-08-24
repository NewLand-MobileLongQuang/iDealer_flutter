import 'package:idealer/04_core_modules/user_session/api/base/request/msgtest_api_request.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/zalo_data.dart';

class ZaloRequest extends MsgtestApiRequest {
  ZaloRequest(String keyword) {
    endpoint = "zalo/searchuser";
    addParam("oaid", UserSessionController.instance().userInfo?.user?.zaloOaid);
    addParam("keyword", keyword);
  }

  Future<List<ZaloData>> invoke() async {
    var response = await super.coreInvoke();
    List<ZaloData> data = (response as List<dynamic>)
        .map((e) => ZaloData.fromJson(e as Map<String, dynamic>))
        .toList();
    return data;
  }
}
