// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dealer_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DealerCodeResponse _$DealerCodeResponseFromJson(Map<String, dynamic> json) =>
    DealerCodeResponse()
      ..success = json['Success'] as bool?
      ..errorData = json['ErrorData'] == null
          ? null
          : ErrorData.fromJson(json['ErrorData'] as Map<String, dynamic>)
      ..listDealerCode = json['ListDealerCode'] as String?;

Map<String, dynamic> _$DealerCodeResponseToJson(DealerCodeResponse instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'ErrorData': instance.errorData,
      'ListDealerCode': instance.listDealerCode,
    };
