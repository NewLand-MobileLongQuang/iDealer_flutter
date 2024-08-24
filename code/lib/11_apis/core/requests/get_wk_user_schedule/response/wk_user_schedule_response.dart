import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
import 'package:idealer/11_apis/core/models/wk_user_schedule_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wk_user_schedule_response.g.dart';

@JsonSerializable()
class WkUserScheduleResponse extends BaseResponse{
  @JsonKey(name: "list")
  List<ListElement>? listElement;

  @JsonKey(name: "ItemCount")
  int? itemCount;

  WkUserScheduleResponse();

  factory WkUserScheduleResponse.fromJson(Map<String, dynamic> json) => _$WkUserScheduleResponseFromJson(json);

  static WkUserScheduleResponse fromJsonModel(Map<String, dynamic> json){
    return WkUserScheduleResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$WkUserScheduleResponseToJson(this);
}