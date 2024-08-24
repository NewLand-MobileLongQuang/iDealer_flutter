// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class CarPlanData {
  CarPlanData({
    this.cpCode,
    this.colorCode,
    this.modelCode,
    this.specCode,
    this.orderNo,
    this.qty,
    this.qtyOrder,
    this.dealerCode,
    this.logLudTime,
    this.logLuBy,
    this.status,
    this.creadtedDate,
    this.createdBy,
    this.modelName,
    this.specName,
    this.colorName,
    this.mccColorextnamevn,
    this.mccColorintnamevn,
    this.soLuongDaVe,
    this.soLuongChuaVe,
    this.soLuongTonKho,
    this.soLuongSapVe,
    this.soLuongTong,
    this.soLuongHd,
    this.soLuongGiaoDichA,
    this.soLuongBlock,
    this.soLuongCoTheBan,
    this.modelName1,
    this.specDescription,
    this.colorExtNameVn,
    this.colorIntName,
    this.listCarPlan,
  });

  dynamic cpCode;
  String? colorCode;
  String? modelCode;
  String? specCode;
  dynamic orderNo;
  dynamic qty;
  dynamic qtyOrder;
  dynamic dealerCode;
  dynamic logLudTime;
  dynamic logLuBy;
  dynamic status;
  dynamic creadtedDate;
  dynamic createdBy;
  dynamic modelName;
  dynamic specName;
  String? colorName;
  dynamic mccColorextnamevn;
  dynamic mccColorintnamevn;
  dynamic soLuongDaVe;
  dynamic soLuongChuaVe;
  String? soLuongTonKho;
  String? soLuongSapVe;
  String? soLuongTong;
  dynamic soLuongHd;
  dynamic soLuongGiaoDichA;
  String? soLuongBlock;
  String? soLuongCoTheBan;
  String? modelName1;
  String? specDescription;
  dynamic colorExtNameVn;
  dynamic colorIntName;
  dynamic listCarPlan;

  factory CarPlanData.fromRawJson(String str) => CarPlanData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarPlanData.fromJson(Map<String, dynamic> json) => CarPlanData(
    cpCode: json["CPCode"],
    colorCode: json["ColorCode"],
    modelCode: json["ModelCode"],
    specCode: json["SpecCode"],
    orderNo: json["OrderNo"],
    qty: json["Qty"],
    qtyOrder: json["QtyOrder"],
    dealerCode: json["DealerCode"],
    logLudTime: json["LogLUDTime"],
    logLuBy: json["LogLUBy"],
    status: json["Status"],
    creadtedDate: json["CreadtedDate"],
    createdBy: json["CreatedBy"],
    modelName: json["ModelName"],
    specName: json["SpecName"],
    colorName: json["ColorName"],
    mccColorextnamevn: json["MCC_COLOREXTNAMEVN"],
    mccColorintnamevn: json["MCC_COLORINTNAMEVN"],
    soLuongDaVe: json["SoLuongDaVe"],
    soLuongChuaVe: json["SoLuongChuaVe"],
    soLuongTonKho: json["SoLuongTonKho"],
    soLuongSapVe: json["SoLuongSapVe"] ,
    soLuongTong: json["SoLuongTong"],
    soLuongHd: json["SoLuongHD"],
    soLuongGiaoDichA: json["SoLuongGiaoDichA"],
    soLuongBlock: json["SoLuongBlock"],
    soLuongCoTheBan: json["SoLuongCoTheBan"],
    modelName1: json["ModelName1"],
    specDescription: json["SpecDescription"],
    colorExtNameVn: json["ColorExtNameVN"],
    colorIntName: json["ColorIntName"],
    listCarPlan: json["ListCarPlan"],
  );

  Map<String, dynamic> toJson() => {
    "CPCode": cpCode,
    "ColorCode": colorCode,
    "ModelCode": modelCode,
    "SpecCode": specCode,
    "OrderNo": orderNo,
    "Qty": qty,
    "QtyOrder": qtyOrder,
    "DealerCode": dealerCode,
    "LogLUDTime": logLudTime,
    "LogLUBy": logLuBy,
    "Status": status,
    "CreadtedDate": creadtedDate,
    "CreatedBy": createdBy,
    "ModelName": modelName,
    "SpecName": specName,
    "ColorName": colorName,
    "MCC_COLOREXTNAMEVN": mccColorextnamevn,
    "MCC_COLORINTNAMEVN": mccColorintnamevn,
    "SoLuongDaVe": soLuongDaVe,
    "SoLuongChuaVe": soLuongChuaVe,
    "SoLuongTonKho": soLuongTonKho,
    "SoLuongSapVe": soLuongSapVe,
    "SoLuongTong": soLuongTong,
    "SoLuongHD": soLuongHd,
    "SoLuongGiaoDichA": soLuongGiaoDichA,
    "SoLuongBlock": soLuongBlock,
    "SoLuongCoTheBan": soLuongCoTheBan,
    "ModelName1": modelName1,
    "SpecDescription": specDescription,
    "ColorExtNameVN": colorExtNameVn,
    "ColorIntName": colorIntName,
    "ListCarPlan": listCarPlan,
  };
}