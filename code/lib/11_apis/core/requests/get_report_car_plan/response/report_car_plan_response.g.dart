// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_car_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportCarPlanResponse _$ReportCarPlanResponseFromJson(
        Map<String, dynamic> json) =>
    ReportCarPlanResponse()
      ..data = (json[''] as List<dynamic>?)
          ?.map((e) => CarPlanData.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ReportCarPlanResponseToJson(
        ReportCarPlanResponse instance) =>
    <String, dynamic>{
      '': instance.data,
    };
