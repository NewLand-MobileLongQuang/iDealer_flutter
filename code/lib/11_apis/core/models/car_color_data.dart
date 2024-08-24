// To parse this JSON data, do
//
//     final carColorData = carColorDataFromJson(jsonString);

import 'dart:convert';

class CarColorData {
  CarColorData({
    this.modelCode,
    this.colorCode,
    this.colorExtType,
    this.colorExtCode,
    this.colorExtName,
    this.colorExtNameVn,
    this.colorIntCode,
    this.colorIntName,
    this.colorIntNameVn,
    this.colorFee,
    this.remark,
    this.flagActive,
    this.logLudTime,
    this.logLuBy,
    this.status,
  });

  String? modelCode;
  String? colorCode;
  String? colorExtType;
  String? colorExtCode;
  String? colorExtName;
  String? colorExtNameVn;
  String? colorIntCode;
  String? colorIntName;
  String? colorIntNameVn;
  String? colorFee;
  String? remark;
  String? flagActive;
  dynamic logLudTime;
  String? logLuBy;
  dynamic status;

  factory CarColorData.fromRawJson(String str) => CarColorData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarColorData.fromJson(Map<String, dynamic> json) => CarColorData(
    modelCode: json["ModelCode"],
    colorCode: json["ColorCode"],
    colorExtType: json["ColorExtType"],
    colorExtCode: json["ColorExtCode"],
    colorExtName: json["ColorExtName"],
    colorExtNameVn: json["ColorExtNameVN"],
    colorIntCode: json["ColorIntCode"],
    colorIntName: json["ColorIntName"],
    colorIntNameVn: json["ColorIntNameVN"],
    colorFee: json["ColorFee"],
    remark: json["Remark"],
    flagActive: json["FlagActive"],
    logLudTime: json["LogLUDTime"],
    logLuBy: json["LogLUBy"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "ModelCode": modelCode,
    "ColorCode": colorCode,
    "ColorExtType": colorExtType,
    "ColorExtCode": colorExtCode,
    "ColorExtName": colorExtName,
    "ColorExtNameVN": colorExtNameVn,
    "ColorIntCode": colorIntCode,
    "ColorIntName": colorIntName,
    "ColorIntNameVN": colorIntNameVn,
    "ColorFee": colorFee,
    "Remark": remark,
    "FlagActive": flagActive,
    "LogLUDTime": logLudTime,
    "LogLUBy": logLuBy,
    "Status": status,
  };
}
