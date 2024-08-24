import 'package:idealer/11_apis/core/requests/get_dealer_code/dealer_code_request.dart';

class IDealerCoreApiService {
  static Future<String> getListDealerCode() async {
    var request = DealerCodeRequest();
    var response = await request.invoke();
    if (response.listDealerCode == null) {
      return "";
    }

    return response.listDealerCode ?? "";
  }
}
