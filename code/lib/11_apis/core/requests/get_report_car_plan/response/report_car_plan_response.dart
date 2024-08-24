import 'package:idealer/04_core_modules/user_session/api/core/response/core_api_response.dart';
import 'package:idealer/11_apis/core/models/car_plan_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_car_plan_response.g.dart';

@JsonSerializable()
class ReportCarPlanResponse extends CoreApiResponse{
  @JsonKey(name: "")
  List<CarPlanData>? data;
  
  ReportCarPlanResponse();
  factory ReportCarPlanResponse.fromJson(Map<String, dynamic> json) => _$ReportCarPlanResponseFromJson(json);

  static ReportCarPlanResponse fromJsonModel(Map<String, dynamic> json){
    return ReportCarPlanResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$ReportCarPlanResponseToJson(this);
}