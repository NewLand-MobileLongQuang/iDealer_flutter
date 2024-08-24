import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'dealer_code_response.g.dart';

@JsonSerializable()
class DealerCodeResponse extends BaseResponse{
  // @JsonKey(name: "Success")
  // bool? success;

  @JsonKey(name: "ListDealerCode")
  String? listDealerCode;

  DealerCodeResponse();

  factory DealerCodeResponse.fromJson(Map<String, dynamic> json) => _$DealerCodeResponseFromJson(json);

  static DealerCodeResponse fromJsonModel(Map<String, dynamic> json){
    return DealerCodeResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$DealerCodeResponseToJson(this);
}
