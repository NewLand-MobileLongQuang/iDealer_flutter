import '../response/base_response.dart';

class UnknownError implements Exception {
  String message;
  String errorCode;
  UnknownError(this.message, this.errorCode);
  UnknownError.fromResponse(BaseResponse response)
      : this(response.errorMessage(), response.errorCode());
  @override
  String toString() => 'UnknownError: $message, $errorCode';
}
