// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_user_schedule_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WkUserScheduleResponse _$WkUserScheduleResponseFromJson(
        Map<String, dynamic> json) =>
    WkUserScheduleResponse()
      ..success = json['Success'] as bool?
      ..errorData = json['ErrorData'] == null
          ? null
          : ErrorData.fromJson(json['ErrorData'] as Map<String, dynamic>)
      ..listElement = (json['list'] as List<dynamic>?)
          ?.map((e) => ListElement.fromJson(e as Map<String, dynamic>))
          .toList()
      ..itemCount = json['ItemCount'] as int?;

Map<String, dynamic> _$WkUserScheduleResponseToJson(
        WkUserScheduleResponse instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'ErrorData': instance.errorData,
      'list': instance.listElement,
      'ItemCount': instance.itemCount,
    };
