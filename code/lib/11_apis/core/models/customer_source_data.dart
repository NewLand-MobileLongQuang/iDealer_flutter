// To parse this JSON data, do
//
//     final customerSourceData = customerSourceDataFromJson(jsonString);

import 'dart:convert';

class CustomerSourceData {
  CustomerSourceData({
    this.customerBaseCode,
    this.customerBaseName,
    this.flagActive,
  });

  String? customerBaseCode;
  String? customerBaseName;
  String? flagActive;

  factory CustomerSourceData.fromRawJson(String str) => CustomerSourceData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerSourceData.fromJson(Map<String, dynamic> json) => CustomerSourceData(
    customerBaseCode: json["CustomerBaseCode"],
    customerBaseName: json["CustomerBaseName"],
    flagActive: json["FlagActive"],
  );

  Map<String, dynamic> toJson() => {
    "CustomerBaseCode": customerBaseCode,
    "CustomerBaseName": customerBaseName,
    "FlagActive": flagActive,
  };
}
