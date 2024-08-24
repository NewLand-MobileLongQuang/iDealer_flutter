// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class UserByDealerData {
  UserByDealerData({
    this.userCode,
    this.dealerCode,
    this.deptCode,
    this.userStaffId,
    this.userName,
    this.userPassword,
    this.userEmail,
    this.userPhoneNo,
    this.viewAbilityType,
    this.flagSysAdmin,
    this.flagSaleMan,
    this.flagActive,
    this.status,
    this.teamCode,
    this.smsReceivedDTime,
    this.smsReceivedBy,
    this.flagSmsReceive,
    this.userPosition,
    this.flagAuthorizeSignCtr,
    this.listAccess,
    this.listSysUserInGroup,
    this.listSysUserInTeam,
    this.roles,
  });

  String? userCode;
  String? dealerCode;
  String? deptCode;
  String? userStaffId;
  String? userName;
  String? userPassword;
  String? userEmail;
  String? userPhoneNo;
  String? viewAbilityType;
  String? flagSysAdmin;
  String? flagSaleMan;
  String? flagActive;
  dynamic status;
  dynamic teamCode;
  dynamic smsReceivedDTime;
  dynamic smsReceivedBy;
  String? flagSmsReceive;
  String? userPosition;
  String? flagAuthorizeSignCtr;
  dynamic listAccess;
  dynamic listSysUserInGroup;
  dynamic listSysUserInTeam;
  dynamic roles;

  factory UserByDealerData.fromRawJson(String str) => UserByDealerData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserByDealerData.fromJson(Map<String, dynamic> json) => UserByDealerData(
    userCode: json["UserCode"],
    dealerCode: json["DealerCode"],
    deptCode: json["DeptCode"],
    userStaffId: json["UserStaffId"] == null ? null : json["UserStaffId"],
    userName: json["UserName"],
    userPassword: json["UserPassword"],
    userEmail: json["UserEmail"] == null ? null : json["UserEmail"],
    userPhoneNo: json["UserPhoneNo"],
    viewAbilityType: json["ViewAbilityType"] == null ? null : json["ViewAbilityType"],
    flagSysAdmin: json["FlagSysAdmin"],
    flagSaleMan: json["FlagSaleMan"],
    flagActive: json["FlagActive"],
    status: json["Status"],
    teamCode: json["TeamCode"],
    smsReceivedDTime: json["SMSReceivedDTime"],
    smsReceivedBy: json["SMSReceivedBy"],
    flagSmsReceive: json["FlagSMSReceive"],
    userPosition: json["UserPosition"] == null ? null : json["UserPosition"],
    flagAuthorizeSignCtr: json["FlagAuthorizeSignCtr"],
    listAccess: json["ListAccess"],
    listSysUserInGroup: json["ListSys_UserInGroup"],
    listSysUserInTeam: json["ListSys_UserInTeam"],
    roles: json["Roles"],
  );

  Map<String, dynamic> toJson() => {
    "UserCode": userCode,
    "DealerCode": dealerCode,
    "DeptCode": deptCode == null ? null : deptCode,
    "UserStaffId": userStaffId == null ? null : userStaffId,
    "UserName": userName,
    "UserPassword": userPassword,
    "UserEmail": userEmail == null ? null : userEmail,
    "UserPhoneNo": userPhoneNo,
    "ViewAbilityType": viewAbilityType == null ? null : viewAbilityType,
    "FlagSysAdmin": flagSysAdmin,
    "FlagSaleMan": flagSaleMan,
    "FlagActive": flagActive,
    "Status": status,
    "TeamCode": teamCode,
    "SMSReceivedDTime": smsReceivedDTime,
    "SMSReceivedBy": smsReceivedBy,
    "FlagSMSReceive": flagSmsReceive,
    "UserPosition": userPosition == null ? null : userPosition,
    "FlagAuthorizeSignCtr": flagAuthorizeSignCtr,
    "ListAccess": listAccess,
    "ListSys_UserInGroup": listSysUserInGroup,
    "ListSys_UserInTeam": listSysUserInTeam,
    "Roles": roles,
  };
}
