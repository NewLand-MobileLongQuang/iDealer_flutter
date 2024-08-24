// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class DealerCustomerContactSearchData {
  DealerCustomerContactSearchData({
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
    this.listDlsDealerCustomerContact,
    this.listUserOwnerCustomer,
  });

  String? customerCode;
  String? dealerCode;
  String? customerTypeCode;
  dynamic customerGrpType;
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
  String? drvLicenseNoExpDate;
  dynamic bankCode;
  String? bankName;
  String? bankAccountNo;
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
  dynamic listDlsDealerCustomerContact;
  dynamic listUserOwnerCustomer;

  factory DealerCustomerContactSearchData.fromRawJson(String str) => DealerCustomerContactSearchData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DealerCustomerContactSearchData.fromJson(Map<String, dynamic> json) => DealerCustomerContactSearchData(
    customerCode: json["CustomerCode"],
    dealerCode: json["DealerCode"],
    customerTypeCode: json["CustomerTypeCode"],
    customerGrpType: json["CustomerGrpType"],
    fullName: json["FullName"],
    fullNameEn: json["FullNameEN"],
    gender: json["Gender"],
    phoneNo: json["PhoneNo"],
    provinceCode: json["ProvinceCode"] == null ? null : json["ProvinceCode"],
    districtCode: json["DistrictCode"] == null ? null : json["DistrictCode"],
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
    bankAccountNo: json["BankAccountNo"] == null ? null : json["BankAccountNo"],
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
    mpProvincecode: json["MP_PROVINCECODE"] == null ? null : json["MP_PROVINCECODE"],
    mpProvincename: json["MP_PROVINCENAME"] == null ? null : json["MP_PROVINCENAME"],
    districtName: json["DistrictName"] == null ? null : json["DistrictName"],
    mctIdcardtype: json["MCT_IDCARDTYPE"] == null ? null : json["MCT_IDCARDTYPE"],
    idcardtypename: json["IDCARDTYPENAME"] == null ? null : json["IDCARDTYPENAME"],
    customerContactCode: json["CustomerContactCode"],
    customerContactName: json["CustomerContactName"],
    customerContactPhoneNo: json["CustomerContactPhoneNo"],
    userOwnerPhoneNo: json["UserOwnerPhoneNo"],
    effDTimeStart: json["EffDTimeStart"],
    status: json["Status"],
    listUserCodeOwner: json["ListUserCodeOwner"],
    listDlsDealerCustomerContact: json["ListDls_DealerCustomerContact"],
    listUserOwnerCustomer: json["ListUserOwner_Customer"],
  );

  Map<String, dynamic> toJson() => {
    "CustomerCode": customerCode,
    "DealerCode": dealerCode,
    "CustomerTypeCode": customerTypeCode,
    "CustomerGrpType": customerGrpType,
    "FullName": fullName,
    "FullNameEN": fullNameEn,
    "Gender": gender,
    "PhoneNo": phoneNo,
    "ProvinceCode": provinceCode == null ? null : provinceCode,
    "DistrictCode": districtCode == null ? null : districtCode,
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
    "BankAccountNo": bankAccountNo == null ? null : bankAccountNo,
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
    "MP_PROVINCECODE": mpProvincecode == null ? null : mpProvincecode,
    "MP_PROVINCENAME": mpProvincename == null ? null : mpProvincename,
    "DistrictName": districtName == null ? null : districtName,
    "MCT_IDCARDTYPE": mctIdcardtype == null ? null : mctIdcardtype,
    "IDCARDTYPENAME": idcardtypename == null ? null : idcardtypename,
    "CustomerContactCode": customerContactCode,
    "CustomerContactName": customerContactName,
    "CustomerContactPhoneNo": customerContactPhoneNo,
    "UserOwnerPhoneNo": userOwnerPhoneNo,
    "EffDTimeStart": effDTimeStart,
    "Status": status,
    "ListUserCodeOwner": listUserCodeOwner,
    "ListDls_DealerCustomerContact": listDlsDealerCustomerContact,
    "ListUserOwner_Customer": listUserOwnerCustomer,
  };
}
