// To parse this JSON data, do
//
//     final mstDistrictData = mstDistrictDataFromJson(jsonString);

import 'dart:convert';

class MstDistrictData {
  MstDistrictData({
    this.provinceCode,
    this.districtCode,
    this.districtName,
    this.flagActive,
  });

  String? provinceCode;
  String? districtCode;
  String? districtName;
  String? flagActive;

  factory MstDistrictData.fromRawJson(String str) =>
      MstDistrictData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MstDistrictData.fromJson(Map<String, dynamic> json) =>
      MstDistrictData(
        provinceCode: json["ProvinceCode"],
        districtCode: json["DistrictCode"],
        districtName: json["DistrictName"],
        flagActive: json["FlagActive"],
      );

  Map<String, dynamic> toJson() => {
        "ProvinceCode": provinceCode,
        "DistrictCode": districtCode,
        "DistrictName": districtName,
        "FlagActive": flagActive,
      };

  static bool compareFn(MstDistrictData? one, MstDistrictData? two) {
    if (one == null) {
      if (two == null) {
        return true;
      }
      return false;
    }
    if (two == null) {
      return false;
    }
    if (one.districtCode == two.districtCode) {
      return true;
    }
    return false;
  }
}
