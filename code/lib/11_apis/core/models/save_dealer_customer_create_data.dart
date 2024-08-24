// To parse this JSON data, do
//
//     final saveDealerCustomerData = saveDealerCustomerDataFromJson(jsonString);

import 'dart:convert';

class SaveDealerCustomerData {
  SaveDealerCustomerData({
    this.customerCode,
    this.dealerCode,
    this.customerTypeCode,
    this.customerGrpType,
    this.fullName,
    this.fullNameEn,
    this.gender,
    this.userOwnerPhoneNo,
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
    this.effDTimeStart,
    this.remark,
    this.checkInforStatus,
    this.mdlDealername,
    this.mpProvincecode,
    this.mpProvincename,
    this.districtName,
    this.mctIdcardtype,
    this.idcardtypename,
    this.status,
    this.listUserCodeOwner,
    this.zaloID,
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
  String? userOwnerPhoneNo;
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
  String? driverLicenseNo;
  String? drvLicenseNoExpDate;
  String? bankCode;
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
  String? effDTimeStart;
  String? remark;
  String? checkInforStatus;
  String? mdlDealername;
  String? mpProvincecode;
  String? mpProvincename;
  String? districtName;
  String? mctIdcardtype;
  String? idcardtypename;
  String? status;
  String? listUserCodeOwner;
  String? zaloID;
  List<DealerCustomerContact>? listDlsDealerCustomerContact;
  List<UserOwnerCustomer>? listUserOwnerCustomer;

  factory SaveDealerCustomerData.fromRawJson(String str) =>
      SaveDealerCustomerData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaveDealerCustomerData.fromJson(Map<String, dynamic> json) =>
      SaveDealerCustomerData(
        customerCode: json["CustomerCode"],
        dealerCode: json["DealerCode"],
        customerTypeCode: json["CustomerTypeCode"],
        customerGrpType: json["CustomerGrpType"],
        fullName: json["FullName"],
        fullNameEn: json["FullNameEN"],
        gender: json["Gender"],
        userOwnerPhoneNo: json["UserOwnerPhoneNo"],
        phoneNo: json["PhoneNo"],
        provinceCode: json["ProvinceCode"],
        districtCode: json["DistrictCode"],
        address: json["Address"],
        email: json["Email"],
        dateOfBirth: json["DateOfBirth"],
        fileName: json["FileName"],
        filePath: json["FilePath"],
        idCardType: json["IDCardType"],
        idCardNo: json["IDCardNo"],
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
        effDTimeStart: json["EffDTimeStart"],
        remark: json["Remark"],
        checkInforStatus: json["CheckInforStatus"],
        mdlDealername: json["MDL_DEALERNAME"],
        mpProvincecode: json["MP_PROVINCECODE"],
        mpProvincename: json["MP_PROVINCENAME"],
        districtName: json["DistrictName"],
        mctIdcardtype: json["MCT_IDCARDTYPE"],
        idcardtypename: json["IDCARDTYPENAME"],
        status: json["Status"],
        listUserCodeOwner: json["ListUserCodeOwner"],
        zaloID: json["ZaloID"],
        listDlsDealerCustomerContact: List<DealerCustomerContact>.from(
            json["ListDls_DealerCustomerContact"]
                .map((x) => DealerCustomerContact.fromJson(x))),
        listUserOwnerCustomer: List<UserOwnerCustomer>.from(
            json["ListUserOwner_Customer"]
                .map((x) => UserOwnerCustomer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CustomerCode": customerCode,
        "DealerCode": dealerCode,
        "CustomerTypeCode": customerTypeCode,
        "CustomerGrpType": customerGrpType,
        "FullName": fullName,
        "FullNameEN": fullNameEn,
        "Gender": gender,
        "UserOwnerPhoneNo": userOwnerPhoneNo,
        "PhoneNo": phoneNo,
        "ProvinceCode": provinceCode,
        "DistrictCode": districtCode,
        "Address": address,
        "Email": email,
        "DateOfBirth": dateOfBirth,
        "FileName": fileName,
        "FilePath": filePath,
        "IDCardType": idCardType,
        "IDCardNo": idCardNo,
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
        "EffDTimeStart": effDTimeStart,
        "Remark": remark,
        "CheckInforStatus": checkInforStatus,
        "MDL_DEALERNAME": mdlDealername,
        "MP_PROVINCECODE": mpProvincecode,
        "MP_PROVINCENAME": mpProvincename,
        "DistrictName": districtName,
        "MCT_IDCARDTYPE": mctIdcardtype,
        "IDCARDTYPENAME": idcardtypename,
        "Status": status,
        "ListUserCodeOwner": listUserCodeOwner,
        "ZaloID": zaloID,
        "ListDls_DealerCustomerContact": List<dynamic>.from(
            (listDlsDealerCustomerContact ?? []).map((x) => x.toJson())),
        "ListUserOwner_Customer": List<dynamic>.from(
            (listUserOwnerCustomer ?? []).map((x) => x.toJson())),
      };
}

class DealerCustomerContact {
  DealerCustomerContact({
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

  factory DealerCustomerContact.fromRawJson(String str) =>
      DealerCustomerContact.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DealerCustomerContact.fromJson(Map<String, dynamic> json) =>
      DealerCustomerContact(
        customerContactCode: json["CustomerContactCode"],
        customerCode: json["CustomerCode"],
        phoneNo: json["PhoneNo"],
        fullName: json["FullName"],
        provinceCode: json["ProvinceCode"],
        provinceName: json["ProvinceName"],
      );

  Map<String, dynamic> toJson() => {
        "CustomerContactCode": customerContactCode,
        "CustomerCode": customerCode,
        "PhoneNo": phoneNo,
        "FullName": fullName,
        "ProvinceCode": provinceCode,
        "ProvinceName": provinceName,
      };
}

class UserOwnerCustomer {
  UserOwnerCustomer({
    this.userCode,
    this.customerCode,
    this.functionActionType,
    this.userName,
    this.phoneNo,
    this.deptCode,
    this.teamCode,
  });

  String? userCode;
  String? customerCode;
  String? functionActionType;
  String? userName;
  String? phoneNo;
  String? deptCode;
  String? teamCode;

  factory UserOwnerCustomer.fromRawJson(String str) =>
      UserOwnerCustomer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserOwnerCustomer.fromJson(Map<String, dynamic> json) =>
      UserOwnerCustomer(
        userCode: json["UserCode"],
        customerCode: json["CustomerCode"],
        functionActionType: json["FunctionActionType"],
        userName: json["UserName"],
        phoneNo: json["PhoneNo"],
        deptCode: json["DeptCode"],
        teamCode: json["TeamCode"],
      );

  Map<String, dynamic> toJson() => {
        "UserCode": userCode,
        "CustomerCode": customerCode,
        "FunctionActionType": functionActionType,
        "UserName": userName,
        "PhoneNo": phoneNo,
        "DeptCode": deptCode,
        "TeamCode": teamCode,
      };
}
