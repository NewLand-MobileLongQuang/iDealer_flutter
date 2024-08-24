// To parse this JSON data, do
//
//     final carSpecData = carSpecDataFromJson(jsonString);

import 'dart:convert';

class CarSpecData {
  CarSpecData({
    this.specCode,
    this.modelCode,
    this.stdOptCode,
    this.gradeCode,
    this.ocnCode,
    this.specDescription,
    this.assemblyStatus,
    this.tradeMarkCode,
    this.flagActive,
    this.logLudTime,
    this.logLuBy,
    this.soDongCo,
    this.hopSo,
    this.soChoNgoi,
    this.namSanXuat,
    this.xuatXu,
    this.status,
    this.price,
  });

  String? specCode;
  String? modelCode;
  dynamic stdOptCode;
  dynamic gradeCode;
  dynamic ocnCode;
  String? specDescription;
  String? assemblyStatus;
  String? tradeMarkCode;
  String? flagActive;
  dynamic logLudTime;
  String? logLuBy;
  String? soDongCo;
  String? hopSo;
  String? soChoNgoi;
  String? namSanXuat;
  String? xuatXu;
  dynamic status;
  dynamic price;

  factory CarSpecData.fromRawJson(String str) => CarSpecData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarSpecData.fromJson(Map<String, dynamic> json) => CarSpecData(
    specCode: json["SpecCode"],
    modelCode: json["ModelCode"],
    stdOptCode: json["StdOptCode"],
    gradeCode: json["GradeCode"],
    ocnCode: json["OCNCode"],
    specDescription: json["SpecDescription"],
    assemblyStatus: json["AssemblyStatus"],
    tradeMarkCode: json["TradeMarkCode"],
    flagActive: json["FlagActive"],
    logLudTime: json["LogLUDTime"],
    logLuBy: json["LogLUBy"],
    soDongCo: json["SoDongCo"],
    hopSo: json["HopSo"],
    soChoNgoi: json["SoChoNgoi"],
    namSanXuat: json["NamSanXuat"],
    xuatXu: json["XuatXu"],
    status: json["Status"],
    price: json["Price"],
  );

  Map<String, dynamic> toJson() => {
    "SpecCode": specCode,
    "ModelCode": modelCode,
    "StdOptCode": stdOptCode,
    "GradeCode": gradeCode,
    "OCNCode": ocnCode,
    "SpecDescription": specDescription,
    "AssemblyStatus": assemblyStatus,
    "TradeMarkCode": tradeMarkCode,
    "FlagActive": flagActive,
    "LogLUDTime": logLudTime,
    "LogLUBy": logLuBy,
    "SoDongCo": soDongCo,
    "HopSo": hopSo,
    "SoChoNgoi": soChoNgoi,
    "NamSanXuat": namSanXuat,
    "XuatXu": xuatXu,
    "Status": status,
    "Price": price,
  };
}
