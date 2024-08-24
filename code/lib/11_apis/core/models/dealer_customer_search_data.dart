// To parse this JSON data, do
//
//     final dealerCustomerSearchData = dealerCustomerSearchDataFromJson(jsonString);

import 'dart:convert';

class DealerCustomerSearchData {
  DealerCustomerSearchData({
    this.customerCode,
    this.dealerCode,
    this.customerTypeCode,
    this.customerGrpType,
    this.fullName,
    this.fullNameEn,
    this.gender,
    this.phoneNo,
    this.provinceCode,
    this.districtCode,
    this.address,
    this.email,
    this.dateOfBirth,
    this.fileName,
    this.filePath,
    this.idCardType,
    this.idCardNo,
    this.idCardDate,
    this.idCardPlace,
    this.taxCode,
    this.driverLicenseNo,
    this.drvLicenseNoExpDate,
    this.bankCode,
    this.bankName,
    this.bankAccountNo,
    this.representName,
    this.representPosition,
    this.userCodeOwner,
    this.createDTime,
    this.createdBy,
    this.ludTime,
    this.luBy,
    this.flagActive,
    this.flagiCic,
    this.flagSendSms,
    this.remark,
    this.checkInforStatus,
    this.mdlDealername,
    this.mpProvincecode,
    this.mpProvincename,
    this.districtName,
    this.mctIdcardtype,
    this.idcardtypename,
    this.customerContactCode,
    this.customerContactName,
    this.customerContactPhoneNo,
    this.userOwnerPhoneNo,
    this.effDTimeStart,
    this.status,
    this.listUserCodeOwner,
    this.zaloId,
    this.listDlsDealerCustomerContact,
    this.listUserOwnerCustomer,
  });

  String? customerCode;
  String? dealerCode;
  String? customerTypeCode;
  String? customerGrpType;
  String? fullName;
  String? fullNameEn;
  String? gender;
  String? phoneNo;
  String? provinceCode;
  String? districtCode;
  String? address;
  String? email;
  String? dateOfBirth;
  String? fileName;
  String? filePath;
  String? idCardType;
  String? idCardNo;
  String? idCardDate;
  String? idCardPlace;
  String? taxCode;
  dynamic driverLicenseNo;
  dynamic drvLicenseNoExpDate;
  dynamic bankCode;
  String? bankName;
  dynamic bankAccountNo;
  String? representName;
  String? representPosition;
  String? userCodeOwner;
  String? createDTime;
  String? createdBy;
  String? ludTime;
  String? luBy;
  String? flagActive;
  String? flagiCic;
  String? flagSendSms;
  String? remark;
  String? checkInforStatus;
  String? mdlDealername;
  String? mpProvincecode;
  String? mpProvincename;
  String? districtName;
  String? mctIdcardtype;
  String? idcardtypename;
  dynamic customerContactCode;
  dynamic customerContactName;
  dynamic customerContactPhoneNo;
  dynamic userOwnerPhoneNo;
  dynamic effDTimeStart;
  dynamic status;
  String? listUserCodeOwner;
  String? zaloId;
  List<ListDlsDealerCustomerContact>? listDlsDealerCustomerContact;
  List<dynamic>? listUserOwnerCustomer;

  factory DealerCustomerSearchData.fromRawJson(String str) =>
      DealerCustomerSearchData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DealerCustomerSearchData.fromJson(Map<String, dynamic> json) =>
      DealerCustomerSearchData(
        customerCode: json["CustomerCode"],
        dealerCode: json["DealerCode"],
        customerTypeCode: json["CustomerTypeCode"],
        customerGrpType:
            json["CustomerGrpType"] == null ? null : json["CustomerGrpType"],
        fullName: json["FullName"],
        fullNameEn: json["FullNameEN"],
        gender: json["Gender"],
        phoneNo: json["PhoneNo"],
        provinceCode: json["ProvinceCode"],
        districtCode: json["DistrictCode"],
        address: json["Address"],
        email: json["Email"],
        dateOfBirth: json["DateOfBirth"],
        fileName: json["FileName"],
        filePath: json["FilePath"],
        idCardType: json["IDCardType"] == null ? null : json["IDCardType"],
        idCardNo: json["IDCardNo"] == null ? null : json["IDCardNo"],
        idCardDate: json["IDCardDate"],
        idCardPlace: json["IDCardPlace"],
        taxCode: json["TaxCode"],
        driverLicenseNo: json["DriverLicenseNo"],
        drvLicenseNoExpDate: json["DrvLicenseNoExpDate"],
        bankCode: json["BankCode"],
        bankName: json["BankName"],
        bankAccountNo: json["BankAccountNo"],
        representName: json["RepresentName"],
        representPosition: json["RepresentPosition"],
        userCodeOwner: json["UserCodeOwner"],
        createDTime: json["CreateDTime"],
        createdBy: json["CreatedBy"],
        ludTime: json["LUDTime"],
        luBy: json["LUBy"],
        flagActive: json["FlagActive"],
        flagiCic: json["FlagiCIC"],
        flagSendSms: json["FlagSendSMS"],
        remark: json["Remark"],
        checkInforStatus: json["CheckInforStatus"],
        mdlDealername: json["MDL_DEALERNAME"],
        mpProvincecode: json["MP_PROVINCECODE"],
        mpProvincename: json["MP_PROVINCENAME"],
        districtName: json["DistrictName"],
        mctIdcardtype:
            json["MCT_IDCARDTYPE"] == null ? null : json["MCT_IDCARDTYPE"],
        idcardtypename:
            json["IDCARDTYPENAME"] == null ? null : json["IDCARDTYPENAME"],
        customerContactCode: json["CustomerContactCode"],
        customerContactName: json["CustomerContactName"],
        customerContactPhoneNo: json["CustomerContactPhoneNo"],
        userOwnerPhoneNo: json["UserOwnerPhoneNo"],
        effDTimeStart: json["EffDTimeStart"],
        status: json["Status"],
        listUserCodeOwner: json["ListUserCodeOwner"],
        zaloId: json["ZaloID"] == null ? null : json["ZaloID"],
        listDlsDealerCustomerContact: List<ListDlsDealerCustomerContact>.from(
            json["ListDls_DealerCustomerContact"]
                .map((x) => ListDlsDealerCustomerContact.fromJson(x))),
        listUserOwnerCustomer:
            List<dynamic>.from(json["ListUserOwner_Customer"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "CustomerCode": customerCode,
        "DealerCode": dealerCode,
        "CustomerTypeCode": customerTypeCode,
        "CustomerGrpType": customerGrpType == null ? null : customerGrpType,
        "FullName": fullName,
        "FullNameEN": fullNameEn,
        "Gender": gender,
        "PhoneNo": phoneNo,
        "ProvinceCode": provinceCode,
        "DistrictCode": districtCode,
        "Address": address,
        "Email": email,
        "DateOfBirth": dateOfBirth,
        "FileName": fileName,
        "FilePath": filePath,
        "IDCardType": idCardType == null ? null : idCardType,
        "IDCardNo": idCardNo == null ? null : idCardNo,
        "IDCardDate": idCardDate,
        "IDCardPlace": idCardPlace,
        "TaxCode": taxCode,
        "DriverLicenseNo": driverLicenseNo,
        "DrvLicenseNoExpDate": drvLicenseNoExpDate,
        "BankCode": bankCode,
        "BankName": bankName,
        "BankAccountNo": bankAccountNo,
        "RepresentName": representName,
        "RepresentPosition": representPosition,
        "UserCodeOwner": userCodeOwner,
        "CreateDTime": createDTime,
        "CreatedBy": createdBy,
        "LUDTime": ludTime,
        "LUBy": luBy,
        "FlagActive": flagActive,
        "FlagiCIC": flagiCic,
        "FlagSendSMS": flagSendSms,
        "Remark": remark,
        "CheckInforStatus": checkInforStatus,
        "MDL_DEALERNAME": mdlDealername,
        "MP_PROVINCECODE": mpProvincecode,
        "MP_PROVINCENAME": mpProvincename,
        "DistrictName": districtName,
        "MCT_IDCARDTYPE": mctIdcardtype == null ? null : mctIdcardtype,
        "IDCARDTYPENAME": idcardtypename == null ? null : idcardtypename,
        "CustomerContactCode": customerContactCode,
        "CustomerContactName": customerContactName,
        "CustomerContactPhoneNo": customerContactPhoneNo,
        "UserOwnerPhoneNo": userOwnerPhoneNo,
        "EffDTimeStart": effDTimeStart,
        "Status": status,
        "ListUserCodeOwner": listUserCodeOwner,
        "ZaloID": zaloId == null ? null : zaloId,
        "ListDls_DealerCustomerContact": List<dynamic>.from(
            (listDlsDealerCustomerContact ?? []).map((x) => x.toJson())),
        "ListUserOwner_Customer":
            List<dynamic>.from((listUserOwnerCustomer ?? []).map((x) => x)),
      };
}

class ListDlsDealerCustomerContact {
  ListDlsDealerCustomerContact({
    this.customerContactCode,
    this.customerCode,
    this.phoneNo,
    this.fullName,
    this.provinceCode,
    this.provinceName,
  });

  String? customerContactCode;
  String? customerCode;
  String? phoneNo;
  String? fullName;
  String? provinceCode;
  String? provinceName;

  factory ListDlsDealerCustomerContact.fromRawJson(String str) =>
      ListDlsDealerCustomerContact.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListDlsDealerCustomerContact.fromJson(Map<String, dynamic> json) =>
      ListDlsDealerCustomerContact(
        customerContactCode: json["CustomerContactCode"],
        customerCode: json["CustomerCode"],
        phoneNo: json["PhoneNo"],
        fullName: json["FullName"],
        provinceCode:
            json["ProvinceCode"] == null ? null : json["ProvinceCode"],
        provinceName:
            json["ProvinceName"] == null ? null : json["ProvinceName"],
      );

  Map<String, dynamic> toJson() => {
        "CustomerContactCode": customerContactCode,
        "CustomerCode": customerCode,
        "PhoneNo": phoneNo,
        "FullName": fullName,
        "ProvinceCode": provinceCode == null ? null : provinceCode,
        "ProvinceName": provinceName == null ? null : provinceName,
      };
}
