import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_code_response.g.dart';

@JsonSerializable()
class WorkCodeResponse extends BaseResponse{
  @JsonKey(name: "SchCode")
  String? workCode;

  WorkCodeResponse();

  factory WorkCodeResponse.fromJson(Map<String, dynamic> json) => _$WorkCodeResponseFromJson(json);

  static WorkCodeResponse fromJsonModel(Map<String, dynamic> json){
    return WorkCodeResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$WorkCodeResponseToJson(this);
}