// To parse this JSON data, do
//
//     final customerTypeData = customerTypeDataFromJson(jsonString);

import 'dart:convert';

class CustomerTypeData {
  CustomerTypeData({
    this.customerTypeCode,
    this.customerTypeName,
    this.flagActive,
  });

  String? customerTypeCode;
  String? customerTypeName;
  String? flagActive;

  factory CustomerTypeData.fromRawJson(String str) =>
      CustomerTypeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerTypeData.fromJson(Map<String, dynamic> json) =>
      CustomerTypeData(
        customerTypeCode: json["CustomerTypeCode"],
        customerTypeName: json["CustomerTypeName"],
        flagActive: json["FlagActive"],
      );

  Map<String, dynamic> toJson() => {
        "CustomerTypeCode": customerTypeCode,
        "CustomerTypeName": customerTypeName,
        "FlagActive": flagActive,
      };

  static bool compareFn(CustomerTypeData? one, CustomerTypeData? two) {
    if (one == null) {
      if (two == null) {
        return true;
      }
      return false;
    }
    if (two == null) {
      return false;
    }
    if (one.customerTypeCode == two.customerTypeCode) {
      return true;
    }
    return false;
  }
}
