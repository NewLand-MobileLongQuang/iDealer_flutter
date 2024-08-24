// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'igoss_upload_file_large_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IGossUploadFileLargeResponse _$IGossUploadFileLargeResponseFromJson(
        Map<String, dynamic> json) =>
    IGossUploadFileLargeResponse()
      ..success = json['Success'] as bool?
      ..errorData = json['ErrorData'] == null
          ? null
          : ErrorData.fromJson(json['ErrorData'] as Map<String, dynamic>)
      ..data = json['Data'] == null
          ? null
          : FileLargeData.fromJson(json['Data'] as Map<String, dynamic>);

Map<String, dynamic> _$IGossUploadFileLargeResponseToJson(
        IGossUploadFileLargeResponse instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'ErrorData': instance.errorData,
      'Data': instance.data,
    };
