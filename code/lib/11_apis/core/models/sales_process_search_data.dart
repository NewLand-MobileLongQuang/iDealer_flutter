// To parse this JSON data, do
//
//     final salesProcessSearchData = salesProcessSearchDataFromJson(jsonString);

import 'dart:convert';

class SalesProcessSearchData {
  SalesProcessSearchData({
    this.list,
    this.itemCount,
  });

  List<ListElement>? list;
  int? itemCount;

  factory SalesProcessSearchData.fromRawJson(String str) => SalesProcessSearchData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesProcessSearchData.fromJson(Map<String, dynamic> json) => SalesProcessSearchData(
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    itemCount: json["ItemCount"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from((list??[]).map((x) => x.toJson())),
    "ItemCount": itemCount,
  };
}

class ListElement {
  ListElement({
    this.salesId,
    this.userCodeOwner,
    this.customerCode,
    this.customerBaseCode,
    this.dealerCode,
    this.campaignCode,
    this.budgetVal,
    this.carModelType,
    this.contractExpectedDate,
    this.spCancelReasonCode,
    this.createDTime,
    this.createBy,
    this.ludTime,
    this.luBy,
    this.cancelDTime,
    this.cancelBy,
    this.spStatus,
    this.remark,
    this.logLuDateTime,
    this.logLuBy,
    this.address,
    this.districtName,
    this.provinceName,
    this.idCardNo,
    this.idCardDate,
    this.idCardPlace,
    this.bankAccountNoCustomer,
    this.representName,
    this.representPosition,
    this.bankName,
    this.customerTypeName,
    this.fullName,
    this.dateOfBirth,
    this.phoneNo,
    this.email,
    this.driverLicenseNo,
    this.customerBaseName,
    this.modelTiemNang,
    this.driveDate,
    this.customerContactCode,
    this.customerContactName,
    this.customerContactPhoneNo,
    this.listSalesProcessKpi,
    this.listSalesProcessDtl,
    this.dealerName,
    this.companyName,
    this.companyAddress,
    this.showroomAddress,
    this.taxCode,
    this.dealerPhoneNo,
    this.dealerFaxNo,
    this.directorName,
    this.bankName1,
    this.bankAccountNo1,
    this.bankName2,
    this.bankAccountNo2,
    this.bankName3,
    this.bankAccountNo3,
  });

  String? salesId;
  String? userCodeOwner;
  String? customerCode;
  String? customerBaseCode;
  String? dealerCode;
  String? campaignCode;
  String? budgetVal;
  String? carModelType;
  String? contractExpectedDate; //DateTime
  String? spCancelReasonCode;
  String? createDTime;
  String? createBy;
  String? ludTime;
  String? luBy;
  String? cancelDTime;
  String? cancelBy;
  String? spStatus;
  String? remark;
  String? logLuDateTime;
  String? logLuBy;
  String? address;
  dynamic districtName;
  dynamic provinceName;
  String? idCardNo;
  String? idCardDate;
  String? idCardPlace;
  String? bankAccountNoCustomer;
  String? representName;
  String? representPosition;
  String? bankName;
  dynamic customerTypeName;
  String? fullName;
  String? dateOfBirth;  // DateTime
  String? phoneNo;
  String? email;
  dynamic driverLicenseNo;
  String? customerBaseName;
  String? modelTiemNang;
  dynamic driveDate;
  dynamic customerContactCode;
  dynamic customerContactName;
  dynamic customerContactPhoneNo;
  dynamic listSalesProcessKpi;
  dynamic listSalesProcessDtl;
  String? dealerName;
  String? companyName;
  String? companyAddress;
  String? showroomAddress;
  String? taxCode;
  String? dealerPhoneNo;
  dynamic dealerFaxNo;
  String? directorName;
  String? bankName1;
  String? bankAccountNo1;
  String? bankName2;
  String? bankAccountNo2;
  String? bankName3;
  String? bankAccountNo3;

  factory ListElement.fromRawJson(String str) => ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    salesId: json["SalesID"],
    userCodeOwner: json["UserCodeOwner"],
    customerCode: json["CustomerCode"],
    customerBaseCode: json["CustomerBaseCode"],
    dealerCode: json["DealerCode"],
    campaignCode: json["CampaignCode"] == null ? null : json["CampaignCode"],
    budgetVal: json["BudgetVal"] == null ? null : json["BudgetVal"],
    carModelType: json["CarModelType"] == null ? null : json["CarModelType"],
    contractExpectedDate: json["ContractExpectedDate"],
    spCancelReasonCode: json["SPCancelReasonCode"] == null ? null : json["SPCancelReasonCode"],
    createDTime: json["CreateDTime"],
    createBy: json["CreateBy"],
    ludTime: json["LUDTime"],
    luBy: json["LUBy"],
    cancelDTime: json["CancelDTime"] == null ? null : json["CancelDTime"],
    cancelBy: json["CancelBy"] == null ? null : json["CancelBy"],
    spStatus: json["SPStatus"],
    remark: json["Remark"],
    logLuDateTime: json["LogLUDateTime"],
    logLuBy: json["LogLUBy"],
    address: json["Address"],
    districtName: json["DistrictName"],
    provinceName: json["ProvinceName"],
    idCardNo: json["IDCardNo"] == null ? null : json["IDCardNo"],
    idCardDate: json["IDCardDate"],
    idCardPlace: json["IDCardPlace"],
    bankAccountNoCustomer: json["BankAccountNoCustomer"] == null ? null : json["BankAccountNoCustomer"],
    representName: json["RepresentName"],
    representPosition: json["RepresentPosition"],
    bankName: json["BankName"],
    customerTypeName: json["CustomerTypeName"],
    fullName: json["FullName"],
    dateOfBirth: json["DateOfBirth"],
    phoneNo: json["PhoneNo"],
    email: json["Email"],
    driverLicenseNo: json["DriverLicenseNo"],
    customerBaseName: json["CustomerBaseName"],
    modelTiemNang: json["ModelTiemNang"],
    driveDate: json["DriveDate"],
    customerContactCode: json["CustomerContactCode"],
    customerContactName: json["CustomerContactName"],
    customerContactPhoneNo: json["CustomerContactPhoneNo"],
    listSalesProcessKpi: json["ListSalesProcessKPI"],
    listSalesProcessDtl: json["ListSalesProcessDtl"],
    dealerName: json["DealerName"],
    companyName: json["CompanyName"],
    companyAddress: json["CompanyAddress"],
    showroomAddress: json["ShowroomAddress"],
    taxCode: json["TaxCode"],
    dealerPhoneNo: json["DealerPhoneNo"],
    dealerFaxNo: json["DealerFaxNo"],
    directorName: json["DirectorName"],
    bankName1: json["BankName1"],
    bankAccountNo1: json["BankAccountNo1"],
    bankName2: json["BankName2"],
    bankAccountNo2: json["BankAccountNo2"],
    bankName3: json["BankName3"],
    bankAccountNo3: json["BankAccountNo3"],
  );

  Map<String, dynamic> toJson() => {
    "SalesID": salesId,
    "UserCodeOwner": userCodeOwner,
    "CustomerCode": customerCode,
    "CustomerBaseCode": customerBaseCode,
    "DealerCode": dealerCode,
    "CampaignCode": campaignCode == null ? null : campaignCode,
    "BudgetVal": budgetVal == null ? null : budgetVal,
    "CarModelType": carModelType == null ? null : carModelType,
    "ContractExpectedDate": contractExpectedDate ,
    "SPCancelReasonCode": spCancelReasonCode == null ? null : spCancelReasonCode,
    "CreateDTime": createDTime,
    "CreateBy": createBy,
    "LUDTime": ludTime,
    "LUBy": luBy,
    "CancelDTime": cancelDTime == null ? null : cancelDTime,
    "CancelBy": cancelBy == null ? null : cancelBy,
    "SPStatus": spStatus,
    "Remark": remark,
    "LogLUDateTime": logLuDateTime,
    "LogLUBy": logLuBy,
    "Address": address,
    "DistrictName": districtName,
    "ProvinceName": provinceName,
    "IDCardNo": idCardNo == null ? null : idCardNo,
    "IDCardDate": idCardDate,
    "IDCardPlace": idCardPlace,
    "BankAccountNoCustomer": bankAccountNoCustomer == null ? null : bankAccountNoCustomer,
    "RepresentName": representName,
    "RepresentPosition": representPosition,
    "BankName": bankName,
    "CustomerTypeName": customerTypeName,
    "FullName": fullName,
    "DateOfBirth": dateOfBirth,
    "PhoneNo": phoneNo,
    "Email": email,
    "DriverLicenseNo": driverLicenseNo,
    "CustomerBaseName": customerBaseName,
    "ModelTiemNang": modelTiemNang,
    "DriveDate": driveDate,
    "CustomerContactCode": customerContactCode,
    "CustomerContactName": customerContactName,
    "CustomerContactPhoneNo": customerContactPhoneNo,
    "ListSalesProcessKPI": listSalesProcessKpi,
    "ListSalesProcessDtl": listSalesProcessDtl,
    "DealerName": dealerName,
    "CompanyName": companyName,
    "CompanyAddress": companyAddress,
    "ShowroomAddress": showroomAddress,
    "TaxCode": taxCode,
    "DealerPhoneNo": dealerPhoneNo,
    "DealerFaxNo": dealerFaxNo,
    "DirectorName": directorName,
    "BankName1": bankName1,
    "BankAccountNo1": bankAccountNo1,
    "BankName2": bankName2,
    "BankAccountNo2": bankAccountNo2,
    "BankName3": bankName3,
    "BankAccountNo3": bankAccountNo3,
  };
}
