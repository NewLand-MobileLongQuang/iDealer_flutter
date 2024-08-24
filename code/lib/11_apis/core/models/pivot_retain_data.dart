// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class PivotRetainData {
  PivotRetainData({
    this.modelCode,
    this.specCode,
    this.specDescription,
    this.colorCode,
    this.colorName,
    this.vin,
    this.engineNo,
    this.dlrContractNo,
    this.userCodeOwner,
    this.fullname,
    this.deliveryOutDate,
    this.soNgayTon,
    this.dealerCode,
    this.total,
    this.soNgayChoGiao,
    this.ddDealNo,
  });

  String? modelCode;
  String? specCode;
  String? specDescription;
  String? colorCode;
  String? colorName;
  String? vin;
  String? engineNo;
  String? dlrContractNo;
  String? userCodeOwner;
  String? fullname;
  String? deliveryOutDate;
  String? soNgayTon;
  String? dealerCode;
  String? total;
  dynamic soNgayChoGiao;
  dynamic ddDealNo;

  factory PivotRetainData.fromRawJson(String str) => PivotRetainData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PivotRetainData.fromJson(Map<String, dynamic> json) => PivotRetainData(
    modelCode: json["ModelCode"],
    specCode: json["SpecCode"],
    specDescription: json["SpecDescription"],
    colorCode: json["ColorCode"],
    colorName: json["ColorName"],
    vin: json["VIN"],
    engineNo: json["EngineNo"],
    dlrContractNo: json["DlrContractNo"],
    userCodeOwner: json["UserCodeOwner"],
    fullname: json["Fullname"],
    deliveryOutDate: json["DeliveryOutDate"],
    soNgayTon: json["SoNgayTon"],
    dealerCode: json["DealerCode"],
    total: json["Total"],
    soNgayChoGiao: json["SoNgayChoGiao"],
    ddDealNo: json["dd_DealNo"],
  );

  Map<String, dynamic> toJson() => {
    "ModelCode": modelCode,
    "SpecCode": specCode,
    "SpecDescription": specDescription,
    "ColorCode": colorCode,
    "ColorName": colorName,
    "VIN": vin,
    "EngineNo": engineNo,
    "DlrContractNo": dlrContractNo,
    "UserCodeOwner": userCodeOwner,
    "Fullname": fullname,
    "DeliveryOutDate": deliveryOutDate,
    "SoNgayTon": soNgayTon,
    "DealerCode": dealerCode,
    "Total": total,
    "SoNgayChoGiao": soNgayChoGiao,
    "dd_DealNo": ddDealNo,
  };
}