// To parse this JSON data, do
//
//     final customerGroupTypeData = customerGroupTypeDataFromJson(jsonString);

import 'dart:convert';

class CustomerGroupTypeData {
  CustomerGroupTypeData({
    this.customerGrpType,
    this.customerTypeCode,
    this.customerGrpTypeName,
    this.flagActive,
  });

  String? customerGrpType;
  String? customerTypeCode;
  String? customerGrpTypeName;
  String? flagActive;

  factory CustomerGroupTypeData.fromRawJson(String str) =>
      CustomerGroupTypeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerGroupTypeData.fromJson(Map<String, dynamic> json) =>
      CustomerGroupTypeData(
        customerGrpType: json["CustomerGrpType"],
        customerTypeCode: json["CustomerTypeCode"],
        customerGrpTypeName: json["CustomerGrpTypeName"],
        flagActive: json["FlagActive"],
      );

  Map<String, dynamic> toJson() => {
        "CustomerGrpType": customerGrpType,
        "CustomerTypeCode": customerTypeCode,
        "CustomerGrpTypeName": customerGrpTypeName,
        "FlagActive": flagActive,
      };

  static bool compareFn(
      CustomerGroupTypeData? one, CustomerGroupTypeData? two) {
    if (one == null) {
      if (two == null) {
        return true;
      }
      return false;
    }
    if (two == null) {
      return false;
    }
    if (one.customerGrpType == two.customerGrpType) {
      return true;
    }
    return false;
  }
}
