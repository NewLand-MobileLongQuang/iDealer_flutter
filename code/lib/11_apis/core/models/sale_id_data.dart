// To parse this JSON data, do
//
//     final saleIdData = saleIdDataFromJson(jsonString);

import 'dart:convert';

class SaleIdData {
  SaleIdData({
    this.success,
    this.salesId,
  });

  bool? success;
  String? salesId;

  factory SaleIdData.fromRawJson(String str) => SaleIdData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaleIdData.fromJson(Map<String, dynamic> json) => SaleIdData(
    success: json["Success"],
    salesId: json["SalesID"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "SalesID": salesId,
  };
}
