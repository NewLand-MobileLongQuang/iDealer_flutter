// To parse this JSON data, do
//
//     final mstCardTypeData = mstCardTypeDataFromJson(jsonString);

import 'dart:convert';

class MstCardTypeData {
  MstCardTypeData({
    this.idCardType,
    this.idCardTypeName,
    this.createdDate,
    this.flagActive,
  });

  String? idCardType;
  String? idCardTypeName;
  String? createdDate;
  String? flagActive;

  factory MstCardTypeData.fromRawJson(String str) =>
      MstCardTypeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MstCardTypeData.fromJson(Map<String, dynamic> json) =>
      MstCardTypeData(
        idCardType: json["IDCardType"],
        idCardTypeName: json["IDCardTypeName"],
        createdDate: json["CreatedDate"],
        flagActive: json["FlagActive"],
      );

  Map<String, dynamic> toJson() => {
        "IDCardType": idCardType,
        "IDCardTypeName": idCardTypeName,
        "CreatedDate": createdDate,
        "FlagActive": flagActive,
      };

  static bool compareFn(MstCardTypeData? one, MstCardTypeData? two) {
    if (one == null) {
      if (two == null) {
        return true;
      }
      return false;
    }
    if (two == null) {
      return false;
    }
    if (one.idCardType == two.idCardType) {
      return true;
    }
    return false;
  }
}
