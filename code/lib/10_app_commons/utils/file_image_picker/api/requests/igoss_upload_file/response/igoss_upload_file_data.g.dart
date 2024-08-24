// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'igoss_upload_file_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IGossUploadFileData _$IGossUploadFileDataFromJson(Map<String, dynamic> json) =>
    IGossUploadFileData()
      ..success = json['Success'] as bool?
      ..errorData = json['ErrorData'] == null
          ? null
          : ErrorData.fromJson(json['ErrorData'] as Map<String, dynamic>)
      ..Url = json['Url'] as String?
      ..Message = json['Message'] as String?;

Map<String, dynamic> _$IGossUploadFileDataToJson(
        IGossUploadFileData instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'ErrorData': instance.errorData,
      'Url': instance.Url,
      'Message': instance.Message,
    };
