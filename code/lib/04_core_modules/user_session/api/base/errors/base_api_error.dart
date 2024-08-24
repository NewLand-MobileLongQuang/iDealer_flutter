import 'package:idealer/04_core_modules/api_libs/errors/api_error.dart';
import 'package:idealer/04_core_modules/user_session/api/base/errors/unknown_api_response_api_error.dart';

class BaseApiError extends ApiError {
  String detail;

  BaseApiError(this.detail);

  static void checkAndThrow(dynamic apiResponse) {
    if (apiResponse is Map<String, dynamic>) {
      if (apiResponse["Success"] == false) {
        if (apiResponse["Detail"] == null) {
          throw UnknownApiResponseApiError();
        }
        var detail = apiResponse["Detail"]!;
        throw BaseApiError(detail);
      }
    }
  }
}
