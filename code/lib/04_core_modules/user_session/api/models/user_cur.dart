import 'dart:convert';

class UserCur {
  UserCur({
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
    this.zaloId,
  });

  String? userCode;
  String? dealerCode;
  dynamic deptCode;
  dynamic userStaffId;
  String? userName;
  dynamic userPassword;
  dynamic userEmail;
  dynamic userPhoneNo;
  dynamic viewAbilityType;
  String? flagSysAdmin;
  dynamic flagSaleMan;
  String? flagActive;
  String? zaloId;
  dynamic status;
  dynamic teamCode;
  dynamic smsReceivedDTime;
  dynamic smsReceivedBy;
  dynamic flagSmsReceive;
  dynamic userPosition;
  dynamic flagAuthorizeSignCtr;
  List<ListAccess>? listAccess;
  dynamic listSysUserInGroup;
  dynamic listSysUserInTeam;
  List<int>? roles;

  factory UserCur.fromRawJson(String str) => UserCur.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserCur.fromJson(Map<String, dynamic> json) => UserCur(
        userCode: json["UserCode"],
        dealerCode: json["DealerCode"],
        deptCode: json["DeptCode"],
        userStaffId: json["UserStaffId"],
        userName: json["UserName"],
        userPassword: json["UserPassword"],
        userEmail: json["UserEmail"],
        userPhoneNo: json["UserPhoneNo"],
        viewAbilityType: json["ViewAbilityType"],
        flagSysAdmin: json["FlagSysAdmin"],
        flagSaleMan: json["FlagSaleMan"],
        flagActive: json["FlagActive"],
        zaloId: json["ZaloOAID"],
        status: json["Status"],
        teamCode: json["TeamCode"],
        smsReceivedDTime: json["SMSReceivedDTime"],
        smsReceivedBy: json["SMSReceivedBy"],
        flagSmsReceive: json["FlagSMSReceive"],
        userPosition: json["UserPosition"],
        flagAuthorizeSignCtr: json["FlagAuthorizeSignCtr"],
        listAccess: json["ListAccess"] == null
            ? null
            : List<ListAccess>.from(
                json["ListAccess"].map((x) => ListAccess.fromJson(x))),
        listSysUserInGroup: json["ListSys_UserInGroup"],
        listSysUserInTeam: json["ListSys_UserInTeam"],
        roles: json["Roles"] == null
            ? null
            : List<int>.from(json["Roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "UserCode": userCode,
        "DealerCode": dealerCode,
        "DeptCode": deptCode,
        "UserStaffId": userStaffId,
        "UserName": userName,
        "UserPassword": userPassword,
        "UserEmail": userEmail,
        "UserPhoneNo": userPhoneNo,
        "ViewAbilityType": viewAbilityType,
        "FlagSysAdmin": flagSysAdmin,
        "FlagSaleMan": flagSaleMan,
        "FlagActive": flagActive,
        "ZaloOAID": zaloId,
        "Status": status,
        "TeamCode": teamCode,
        "SMSReceivedDTime": smsReceivedDTime,
        "SMSReceivedBy": smsReceivedBy,
        "FlagSMSReceive": flagSmsReceive,
        "UserPosition": userPosition,
        "FlagAuthorizeSignCtr": flagAuthorizeSignCtr,
        "ListAccess": listAccess == null
            ? null
            : List<dynamic>.from((listAccess ?? []).map((x) => x.toJson())),
        "ListSys_UserInGroup": listSysUserInGroup,
        "ListSys_UserInTeam": listSysUserInTeam,
        "Roles": roles == null
            ? null
            : List<dynamic>.from((roles ?? []).map((x) => x)),
      };
}

class ListAccess {
  ListAccess({
    this.groupcode,
    this.objectcode,
    this.objectname,
    this.objecttype,
    this.logludtime,
    this.logluby,
  });

  dynamic groupcode;
  String? objectcode;
  String? objectname;
  String? objecttype;
  String? logludtime;
  String? logluby;

  factory ListAccess.fromRawJson(String str) =>
      ListAccess.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListAccess.fromJson(Map<String, dynamic> json) => ListAccess(
        groupcode: json["GROUPCODE"],
        objectcode: json["OBJECTCODE"],
        objectname: json["OBJECTNAME"],
        objecttype: json["OBJECTTYPE"],
        logludtime: json["LOGLUDTIME"],
        logluby: json["LOGLUBY"],
      );

  Map<String, dynamic> toJson() => {
        "GROUPCODE": groupcode,
        "OBJECTCODE": objectcode,
        "OBJECTNAME": objectname,
        "OBJECTTYPE": objecttype,
        "LOGLUDTIME": logludtime,
        "LOGLUBY": logluby,
      };
}
