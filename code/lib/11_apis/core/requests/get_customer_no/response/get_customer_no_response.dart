import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_customer_no_response.g.dart';

@JsonSerializable()
class GetCustomerNoResponse extends BaseResponse {
  @JsonKey(name: "CustomerNo")
  String? customerNo;

  GetCustomerNoResponse();

  factory GetCustomerNoResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCustomerNoResponseFromJson(json);

  static GetCustomerNoResponse fromJsonModel(Map<String, dynamic> json) {
    return GetCustomerNoResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$GetCustomerNoResponseToJson(this);
}
