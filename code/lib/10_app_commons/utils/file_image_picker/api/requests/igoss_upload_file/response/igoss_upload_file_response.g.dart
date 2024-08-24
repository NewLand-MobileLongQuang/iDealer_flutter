// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'igoss_upload_file_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IGossUploadFileResponse _$IGossUploadFileResponseFromJson(
        Map<String, dynamic> json) =>
    IGossUploadFileResponse()
      ..success = json['Success'] as bool?
      ..errorData = json['ErrorData'] == null
          ? null
          : ErrorData.fromJson(json['ErrorData'] as Map<String, dynamic>)
      ..data = json['Data'] == null
          ? null
          : IGossUploadFileData.fromJson(json['Data'] as Map<String, dynamic>);

Map<String, dynamic> _$IGossUploadFileResponseToJson(
        IGossUploadFileResponse instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'ErrorData': instance.errorData,
      'Data': instance.data,
    };
