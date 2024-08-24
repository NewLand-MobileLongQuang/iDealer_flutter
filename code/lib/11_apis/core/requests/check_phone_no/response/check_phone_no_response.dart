import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_phone_no_response.g.dart';

@JsonSerializable()
class CheckPhoneNoResponse extends BaseResponse {
  @JsonKey(name: "CheckPhoneNoSameOwner")
  bool? checkPhoneNoSameOwner;

  @JsonKey(name: "CheckDealerCustomerPhoneNo")
  bool? checkDealerCustomerPhoneNo;

  CheckPhoneNoResponse();

  factory CheckPhoneNoResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckPhoneNoResponseFromJson(json);

  static CheckPhoneNoResponse fromJsonModel(Map<String, dynamic> json) {
    return CheckPhoneNoResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$CheckPhoneNoResponseToJson(this);
}
