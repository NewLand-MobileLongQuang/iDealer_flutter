// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleIdResponse _$SaleIdResponseFromJson(Map<String, dynamic> json) =>
    SaleIdResponse()
      ..success = json['Success'] as bool?
      ..errorData = json['ErrorData'] == null
          ? null
          : ErrorData.fromJson(json['ErrorData'] as Map<String, dynamic>)
      ..data = json['SalesID'] as String?;

Map<String, dynamic> _$SaleIdResponseToJson(SaleIdResponse instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'ErrorData': instance.errorData,
      'SalesID': instance.data,
    };
