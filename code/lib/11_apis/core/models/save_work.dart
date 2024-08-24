import 'dart:convert';

class SaveWork {
  String? schCode;
  String? userCodeOwner;
  String? kPIPlusCode;
  String? salesID;
  String? schLocation;
  String? effDTimeStart;
  String? effDTimeEnd;
  String? rankingType = "";
  String? levelType = "";
  String? createDTime;
  String? createBy;
  String? lUDTime;
  String? lUBy;
  String? uSStatus;
  String? fileName;
  String? filePath;
  String? remark;
  String? customerCode;
  String? kPIPlusName;
  String? fullName;
  String? phoneNo;
  String? customerContactCode;
  String? customerContactName;
  String? customerContactPhoneNo;

  SaveWork({
      this.schCode,
      this.userCodeOwner,
      this.kPIPlusCode,
      this.salesID,
      this.schLocation,
      this.effDTimeStart,
      this.effDTimeEnd,
      this.rankingType,
      this.levelType,
      this.createDTime,
      this.createBy,
      this.lUDTime,
      this.lUBy,
      this.uSStatus,
      this.fileName,
      this.filePath,
      this.remark,
      this.customerCode,
      this.kPIPlusName,
      this.fullName,
      this.phoneNo,
      this.customerContactCode,
      this.customerContactName,
      this.customerContactPhoneNo,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
    "CreateBy": createBy,
    "CreateDTime": createDTime,
    "CustomerCode": customerCode,
    "CustomerContactCode": customerContactCode,
    "CustomerContactName": customerContactName,
    "CustomerContactPhoneNo": customerContactPhoneNo,
    "EffDTimeEnd": effDTimeEnd,
    "EffDTimeStart": effDTimeStart,
    "FileName": fileName,
    "FilePath": filePath,
    "FullName": fullName,
    "KPIPlusCode": kPIPlusCode,
    "KPIPlusName": kPIPlusName,
    "LUBy": lUBy,
    "LUDTime": lUDTime,
    "LevelType": levelType,
    "PhoneNo": phoneNo,
    "RankingType": rankingType,
    "Remark": remark,
    "SalesID": salesID,
    "SchCode": schCode,
    "SchLocation": schLocation,
    "USStatus": uSStatus,
    "UserCodeOwner": userCodeOwner
      };
}
