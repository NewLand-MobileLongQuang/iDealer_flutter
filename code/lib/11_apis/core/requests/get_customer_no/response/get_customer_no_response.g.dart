// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_customer_no_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCustomerNoResponse _$GetCustomerNoResponseFromJson(
        Map<String, dynamic> json) =>
    GetCustomerNoResponse()
      ..success = json['Success'] as bool?
      ..errorData = json['ErrorData'] == null
          ? null
          : ErrorData.fromJson(json['ErrorData'] as Map<String, dynamic>)
      ..customerNo = json['CustomerNo'] as String?;

Map<String, dynamic> _$GetCustomerNoResponseToJson(
        GetCustomerNoResponse instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'ErrorData': instance.errorData,
      'CustomerNo': instance.customerNo,
    };
