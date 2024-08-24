// To parse this JSON data, do
//
//     final carModelData = carModelDataFromJson(jsonString);

import 'dart:convert';

class CarModelData {
  CarModelData({
    this.modelCode,
    this.modelProductionCode,
    this.modelName,
    this.modelType,
    this.segmentType,
    this.flagActive,
    this.status,
    this.logLudTime,
    this.qty,
    this.logLuBy,
  });

  String? modelCode;
  String? modelProductionCode;
  String? modelName;
  dynamic modelType;
  String? segmentType;
  String? flagActive;
  dynamic status;
  dynamic logLudTime;
  int? qty;
  String? logLuBy;

  factory CarModelData.fromRawJson(String str) => CarModelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarModelData.fromJson(Map<String, dynamic> json) => CarModelData(
    modelCode: json["ModelCode"],
    modelProductionCode: json["ModelProductionCode"],
    modelName: json["ModelName"],
    modelType: json["ModelType"],
    segmentType: json["SegmentType"],
    flagActive: json["FlagActive"],
    status: json["Status"],
    logLudTime: json["LogLudTime"],
    qty: json["Qty"],
    logLuBy: json["LogLuBy"],
  );

  Map<String, dynamic> toJson() => {
    "ModelCode": modelCode,
    "ModelProductionCode": modelProductionCode,
    "ModelName": modelName,
    "ModelType": modelType,
    "SegmentType": segmentType,
    "FlagActive": flagActive,
    "Status": status,
    "LogLudTime": logLudTime,
    "Qty": qty,
    "LogLuBy": logLuBy,
  };
}
