// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorData _$ErrorDataFromJson(Map<String, dynamic> json) => ErrorData()
  ..errorCode = json['ErrorCode'] as String?
  ..message = json['Message'] as String?;

Map<String, dynamic> _$ErrorDataToJson(ErrorData instance) => <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'Message': instance.message,
    };
