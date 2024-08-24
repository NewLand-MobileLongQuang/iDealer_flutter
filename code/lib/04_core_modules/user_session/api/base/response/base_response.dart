import 'package:json_annotation/json_annotation.dart';

import '../../core/response/core_api_response.dart';
import 'error_data.dart';

export 'error_data.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse extends CoreApiResponse {
  @JsonKey(name: "Success")
  bool? success;

  @JsonKey(name: "ErrorData")
  ErrorData? errorData;

  BaseResponse();

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);

  static BaseResponse fromJsonModel(Map<String, dynamic> json) =>
      BaseResponse.fromJson(json);

  bool isSuccess() {
    return success == true;
  }

  bool hasError() {
    return success != true;
  }

  String errorMessage() {
    if (hasError()) {
      if (errorData != null && errorData!.message != null) {
        return errorData!.message!;
      }
    }
    return "";
  }

  String errorCode() {
    if (hasError()) {
      if (errorData != null && errorData!.errorCode != null) {
        return errorData!.errorCode!;
      }
    }
    return "";
  }
}
