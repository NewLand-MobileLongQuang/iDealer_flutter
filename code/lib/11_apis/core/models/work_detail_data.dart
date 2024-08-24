// To parse this JSON data, do
//
//     final WorkDetailData = WorkDetailDataFromJson(jsonString);

import 'dart:convert';

class WorkDetailData {
  WorkDetailData({
    this.schCode,
    this.userCodeOwner,
    this.kpiPlusCode,
    this.salesId,
    this.schLocation,
    this.effDTimeStart,
    this.effDTimeEnd,
    this.rankingType,
    this.levelType,
    this.createDTime,
    this.createBy,
    this.ludTime,
    this.luBy,
    this.usStatus,
    this.fileName,
    this.filePath,
    this.remark,
    this.customerCode,
    this.kpiPlusName,
    this.fullName,
    this.phoneNo,
    this.customerContactCode,
    this.customerContactName,
    this.customerContactPhoneNo,
  });

  String? schCode;
  String? userCodeOwner;
  String? kpiPlusCode;
  String? salesId;
  String? schLocation;
  String? effDTimeStart;
  dynamic effDTimeEnd;
  String? rankingType;
  String? levelType;
  String? createDTime;
  String? createBy;
  String? ludTime;
  String? luBy;
  String? usStatus;
  String? fileName;
  String? filePath;
  String? remark;
  String? customerCode;
  String? kpiPlusName;
  String? fullName;
  String? phoneNo;
  dynamic customerContactCode;
  dynamic customerContactName;
  dynamic customerContactPhoneNo;

  factory WorkDetailData.fromRawJson(String str) => WorkDetailData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkDetailData.fromJson(Map<String, dynamic> json) => WorkDetailData(
    schCode: json["SchCode"],
    userCodeOwner: json["UserCodeOwner"],
    kpiPlusCode: json["KPIPlusCode"],
    salesId: json["SalesID"],
    schLocation: json["SchLocation"],
    effDTimeStart: json["EffDTimeStart"],
    effDTimeEnd: json["EffDTimeEnd"],
    rankingType: json["RankingType"],
    levelType: json["LevelType"],
    createDTime: json["CreateDTime"],
    createBy: json["CreateBy"],
    ludTime: json["LUDTime"],
    luBy: json["LUBy"],
    usStatus: json["USStatus"],
    fileName: json["FileName"],
    filePath: json["FilePath"],
    remark: json["Remark"],
    customerCode: json["CustomerCode"],
    kpiPlusName: json["KPIPlusName"],
    fullName: json["FullName"],
    phoneNo: json["PhoneNo"],
    customerContactCode: json["CustomerContactCode"],
    customerContactName: json["CustomerContactName"],
    customerContactPhoneNo: json["CustomerContactPhoneNo"],
  );

  Map<String, dynamic> toJson() => {
    "SchCode": schCode,
    "UserCodeOwner": userCodeOwner,
    "KPIPlusCode": kpiPlusCode,
    "SalesID": salesId,
    "SchLocation": schLocation,
    "EffDTimeStart": effDTimeStart,
    "EffDTimeEnd": effDTimeEnd,
    "RankingType": rankingType,
    "LevelType": levelType,
    "CreateDTime": createDTime,
    "CreateBy": createBy,
    "LUDTime": ludTime,
    "LUBy": luBy,
    "USStatus": usStatus,
    "FileName": fileName,
    "FilePath": filePath,
    "Remark": remark,
    "CustomerCode": customerCode,
    "KPIPlusName": kpiPlusName,
    "FullName": fullName,
    "PhoneNo": phoneNo,
    "CustomerContactCode": customerContactCode,
    "CustomerContactName": customerContactName,
    "CustomerContactPhoneNo": customerContactPhoneNo,
  };
}
