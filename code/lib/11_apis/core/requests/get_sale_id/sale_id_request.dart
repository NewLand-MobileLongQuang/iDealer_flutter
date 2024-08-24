import 'package:idealer/04_core_modules/user_session/api/base/errors/unknown_error.dart';
import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/requests/get_sale_id/response/sale_id_response.dart';

class SaleIdRequest extends IdealerApiRequest {
  SaleIdRequest() {
    endpoint = "Services/GetSalesID";
    
  }

  Future<SaleIdResponse> invoke() async {
    var response = await super.baseInvoke(SaleIdResponse.fromJsonModel);
    if (response.hasError()) {
      throw UnknownError.fromResponse(response);
    }
    return response;
  }
}
