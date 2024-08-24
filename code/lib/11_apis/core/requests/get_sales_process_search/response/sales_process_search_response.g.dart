// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_process_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesProcessSearchResponse _$SalesProcessSearchResponseFromJson(
        Map<String, dynamic> json) =>
    SalesProcessSearchResponse()
      ..success = json['Success'] as bool?
      ..errorData = json['ErrorData'] == null
          ? null
          : ErrorData.fromJson(json['ErrorData'] as Map<String, dynamic>)
      ..data = (json['list'] as List<dynamic>?)
          ?.map((e) => ListElement.fromJson(e as Map<String, dynamic>))
          .toList()
      ..itemCount = json['ItemCount'] as int?;

Map<String, dynamic> _$SalesProcessSearchResponseToJson(
        SalesProcessSearchResponse instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'ErrorData': instance.errorData,
      'list': instance.data,
      'ItemCount': instance.itemCount,
    };
