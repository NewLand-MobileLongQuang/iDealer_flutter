// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkCodeResponse _$WorkCodeResponseFromJson(Map<String, dynamic> json) =>
    WorkCodeResponse()
      ..success = json['Success'] as bool?
      ..errorData = json['ErrorData'] == null
          ? null
          : ErrorData.fromJson(json['ErrorData'] as Map<String, dynamic>)
      ..workCode = json['SchCode'] as String?;

Map<String, dynamic> _$WorkCodeResponseToJson(WorkCodeResponse instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'ErrorData': instance.errorData,
      'SchCode': instance.workCode,
    };
