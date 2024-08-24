// To parse this JSON data, do
//
//     final mstProvinceData = mstProvinceDataFromJson(jsonString);

import 'dart:convert';

class MstProvinceData {
  MstProvinceData({
    this.provinceCode,
    this.areaCode,
    this.provinceName,
    this.flagActive,
  });

  String? provinceCode;
  String? areaCode;
  String? provinceName;
  String? flagActive;

  factory MstProvinceData.fromRawJson(String str) =>
      MstProvinceData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MstProvinceData.fromJson(Map<String, dynamic> json) =>
      MstProvinceData(
        provinceCode: json["ProvinceCode"],
        areaCode: json["AreaCode"],
        provinceName: json["ProvinceName"],
        flagActive: json["FlagActive"],
      );

  Map<String, dynamic> toJson() => {
        "ProvinceCode": provinceCode,
        "AreaCode": areaCode,
        "ProvinceName": provinceName,
        "FlagActive": flagActive,
      };

  static bool compareFn(MstProvinceData? one, MstProvinceData? two) {
    if (one == null) {
      if (two == null) {
        return true;
      }
      return false;
    }
    if (two == null) {
      return false;
    }
    if (one.provinceCode == two.provinceCode) {
      return true;
    }
    return false;
  }
}
