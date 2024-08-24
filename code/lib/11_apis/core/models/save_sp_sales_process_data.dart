// To parse this JSON data, do
//
//     final saveSpSaleProcessData = saveSpSaleProcessDataFromJson(jsonString);

import 'dart:convert';

import 'package:idealer/11_apis/core/models/sp_sales_process_search_data.dart';

class SaveSpSaleProcessData {
  SaveSpSaleProcessData({
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
  dynamic budgetVal;
  String? carModelType;
  dynamic contractExpectedDate;
  dynamic spCancelReasonCode;
  String? createDTime;
  String? createBy;
  String? ludTime;
  String? luBy;
  dynamic cancelDTime;
  dynamic cancelBy;
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
  dynamic bankAccountNoCustomer;
  String? representName;
  String? representPosition;
  String? bankName;
  dynamic customerTypeName;
  String? fullName;
  dynamic dateOfBirth;
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
  List<ListSalesProcessDtl>? listSalesProcessDtl;
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

  factory SaveSpSaleProcessData.fromRawJson(String str) =>
      SaveSpSaleProcessData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaveSpSaleProcessData.fromJson(Map<String, dynamic> json) =>
      SaveSpSaleProcessData(
        salesId: json["SalesID"],
        userCodeOwner: json["UserCodeOwner"],
        customerCode: json["CustomerCode"],
        customerBaseCode: json["CustomerBaseCode"],
        dealerCode: json["DealerCode"],
        campaignCode: json["CampaignCode"],
        budgetVal: json["BudgetVal"],
        carModelType: json["CarModelType"],
        contractExpectedDate: json["ContractExpectedDate"],
        spCancelReasonCode: json["SPCancelReasonCode"],
        createDTime: json["CreateDTime"],
        createBy: json["CreateBy"],
        ludTime: json["LUDTime"],
        luBy: json["LUBy"],
        cancelDTime: json["CancelDTime"],
        cancelBy: json["CancelBy"],
        spStatus: json["SPStatus"],
        remark: json["Remark"],
        logLuDateTime: json["LogLUDateTime"],
        logLuBy: json["LogLUBy"],
        address: json["Address"],
        districtName: json["DistrictName"],
        provinceName: json["ProvinceName"],
        idCardNo: json["IDCardNo"],
        idCardDate: json["IDCardDate"],
        idCardPlace: json["IDCardPlace"],
        bankAccountNoCustomer: json["BankAccountNoCustomer"],
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
        listSalesProcessDtl: List<ListSalesProcessDtl>.from(
            json["ListSalesProcessDtl"]
                .map((x) => ListSalesProcessDtl.fromJson(x))),
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
        "CampaignCode": campaignCode,
        "BudgetVal": budgetVal,
        "CarModelType": carModelType,
        "ContractExpectedDate": contractExpectedDate,
        "SPCancelReasonCode": spCancelReasonCode,
        "CreateDTime": createDTime,
        "CreateBy": createBy,
        "LUDTime": ludTime,
        "LUBy": luBy,
        "CancelDTime": cancelDTime,
        "CancelBy": cancelBy,
        "SPStatus": spStatus,
        "Remark": remark,
        "LogLUDateTime": logLuDateTime,
        "LogLUBy": logLuBy,
        "Address": address,
        "DistrictName": districtName,
        "ProvinceName": provinceName,
        "IDCardNo": idCardNo,
        "IDCardDate": idCardDate,
        "IDCardPlace": idCardPlace,
        "BankAccountNoCustomer": bankAccountNoCustomer,
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
        "ListSalesProcessDtl": List<dynamic>.from(
            (listSalesProcessDtl ?? []).map((x) => x.toJson())),
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

// class ListSalesProcessDtl {
//   ListSalesProcessDtl({
//     this.salesId,
//     this.modelCode,
//     this.colorCode,
//     this.specCode,
//     this.qty,
//     this.spStatusDtl,
//     this.remark,
//     this.modelName,
//     this.specDesc,
//     this.namSanXuat,
//     this.xuatXu,
//     this.colorIntNameVn,
//     this.colorExtNameVn,
//     this.price,
//     this.vat,
//     this.giaTruocVat,
//     this.tongTienTruocVat,
//     this.tongTienSauVat,
//   });
//
//   String? salesId;
//   String? modelCode;
//   String? colorCode;
//   String? specCode;
//   String? qty;
//   String? spStatusDtl;
//   String? remark;
//   String? modelName;
//   String? specDesc;
//   String? namSanXuat;
//   String? xuatXu;
//   String? colorIntNameVn;
//   String? colorExtNameVn;
//   dynamic price;
//   dynamic vat;
//   dynamic giaTruocVat;
//   dynamic tongTienTruocVat;
//   dynamic tongTienSauVat;
//
//   factory ListSalesProcessDtl.fromRawJson(String str) => ListSalesProcessDtl.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory ListSalesProcessDtl.fromJson(Map<String, dynamic> json) => ListSalesProcessDtl(
//     salesId: json["SalesID"],
//     modelCode: json["ModelCode"],
//     colorCode: json["ColorCode"],
//     specCode: json["SpecCode"],
//     qty: json["Qty"],
//     spStatusDtl: json["SPStatusDtl"],
//     remark: json["Remark"],
//     modelName: json["ModelName"],
//     specDesc: json["SpecDesc"],
//     namSanXuat: json["NamSanXuat"],
//     xuatXu: json["XuatXu"],
//     colorIntNameVn: json["ColorIntNameVN"],
//     colorExtNameVn: json["ColorExtNameVN"],
//     price: json["Price"],
//     vat: json["VAT"],
//     giaTruocVat: json["GiaTruocVAT"],
//     tongTienTruocVat: json["TongTienTruocVAT"],
//     tongTienSauVat: json["TongTienSauVAT"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "SalesID": salesId,
//     "ModelCode": modelCode,
//     "ColorCode": colorCode,
//     "SpecCode": specCode,
//     "Qty": qty,
//     "SPStatusDtl": spStatusDtl,
//     "Remark": remark,
//     "ModelName": modelName,
//     "SpecDesc": specDesc,
//     "NamSanXuat": namSanXuat,
//     "XuatXu": xuatXu,
//     "ColorIntNameVN": colorIntNameVn,
//     "ColorExtNameVN": colorExtNameVn,
//     "Price": price,
//     "VAT": vat,
//     "GiaTruocVAT": giaTruocVat,
//     "TongTienTruocVAT": tongTienTruocVat,
//     "TongTienSauVAT": tongTienSauVat,
//   };
// }
