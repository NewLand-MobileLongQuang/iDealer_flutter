// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_phone_no_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckPhoneNoResponse _$CheckPhoneNoResponseFromJson(
        Map<String, dynamic> json) =>
    CheckPhoneNoResponse()
      ..success = json['Success'] as bool?
      ..errorData = json['ErrorData'] == null
          ? null
          : ErrorData.fromJson(json['ErrorData'] as Map<String, dynamic>)
      ..checkPhoneNoSameOwner = json['CheckPhoneNoSameOwner'] as bool?
      ..checkDealerCustomerPhoneNo =
          json['CheckDealerCustomerPhoneNo'] as bool?;

Map<String, dynamic> _$CheckPhoneNoResponseToJson(
        CheckPhoneNoResponse instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'ErrorData': instance.errorData,
      'CheckPhoneNoSameOwner': instance.checkPhoneNoSameOwner,
      'CheckDealerCustomerPhoneNo': instance.checkDealerCustomerPhoneNo,
    };
