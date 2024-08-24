import 'dart:convert';

import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';

class UserInfoResponse extends BaseResponse {
  User? user;
  String? accessToken;
  String? refreshToken;
  String? expiresIn;
  String? flagSendSms;
  String? username;
  String? password;

  UserInfoResponse({
    this.user,
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
    this.flagSendSms,
  });

  factory UserInfoResponse.fromRawJson(String str) =>
      UserInfoResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      UserInfoResponse()
        ..success = json['Success'] as bool?
        ..errorData = json['ErrorData'] == null
            ? null
            : ErrorData.fromJson(json['ErrorData'] as Map<String, dynamic>)
        ..user = json["User"] == null ? null : User.fromJson(json["User"])
        ..accessToken = json["AccessToken"]
        ..refreshToken = json["RefreshToken"]
        ..expiresIn = json["expires_in"]
        ..flagSendSms = json["FlagSendSMS"];

  Map<String, dynamic> toJson() => {
        "Success": success,
        "ErrorData": errorData,
        "User": user?.toJson(),
        "AccessToken": accessToken,
        "RefreshToken": refreshToken,
        "expires_in": expiresIn,
        "FlagSendSMS": flagSendSms,
      };
}

class User {
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
  dynamic status;
  String? zaloOaid;
  dynamic teamCode;
  dynamic smsReceivedDTime;
  dynamic smsReceivedBy;
  dynamic flagSmsReceive;
  dynamic userPosition;
  dynamic flagAuthorizeSignCtr;
  dynamic addressApi;
  String? networkId;
  String? orgId;
  dynamic addressApiProductCenter;
  dynamic addressApIsQinvoice;
  dynamic accessTokenQinvoice;
  dynamic addressApiVelocaService;
  List<ListAccess>? listAccess;
  dynamic listSysUserInGroup;
  dynamic listSysUserInTeam;
  dynamic mstSysConfigInvoice;
  dynamic roles;

  User({
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
    this.zaloOaid,
    this.teamCode,
    this.smsReceivedDTime,
    this.smsReceivedBy,
    this.flagSmsReceive,
    this.userPosition,
    this.flagAuthorizeSignCtr,
    this.addressApi,
    this.networkId,
    this.orgId,
    this.addressApiProductCenter,
    this.addressApIsQinvoice,
    this.accessTokenQinvoice,
    this.addressApiVelocaService,
    this.listAccess,
    this.listSysUserInGroup,
    this.listSysUserInTeam,
    this.mstSysConfigInvoice,
    this.roles,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        status: json["Status"],
        zaloOaid: json["ZaloOAID"],
        teamCode: json["TeamCode"],
        smsReceivedDTime: json["SMSReceivedDTime"],
        smsReceivedBy: json["SMSReceivedBy"],
        flagSmsReceive: json["FlagSMSReceive"],
        userPosition: json["UserPosition"],
        flagAuthorizeSignCtr: json["FlagAuthorizeSignCtr"],
        addressApi: json["AddressAPI"],
        networkId: json["NetworkID"],
        orgId: json["OrgID"],
        addressApiProductCenter: json["AddressAPIProductCenter"],
        addressApIsQinvoice: json["AddressAPIs_Qinvoice"],
        accessTokenQinvoice: json["AccessToken_Qinvoice"],
        addressApiVelocaService: json["AddressAPI_VelocaService"],
        listAccess: json["ListAccess"] == null
            ? []
            : List<ListAccess>.from(
                json["ListAccess"]!.map((x) => ListAccess.fromJson(x))),
        listSysUserInGroup: json["ListSys_UserInGroup"],
        listSysUserInTeam: json["ListSys_UserInTeam"],
        mstSysConfigInvoice: json["Mst_SysConfigInvoice"],
        roles: json["Roles"],
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
        "Status": status,
        "ZaloOAID": zaloOaid,
        "TeamCode": teamCode,
        "SMSReceivedDTime": smsReceivedDTime,
        "SMSReceivedBy": smsReceivedBy,
        "FlagSMSReceive": flagSmsReceive,
        "UserPosition": userPosition,
        "FlagAuthorizeSignCtr": flagAuthorizeSignCtr,
        "AddressAPI": addressApi,
        "NetworkID": networkId,
        "OrgID": orgId,
        "AddressAPIProductCenter": addressApiProductCenter,
        "AddressAPIs_Qinvoice": addressApIsQinvoice,
        "AccessToken_Qinvoice": accessTokenQinvoice,
        "AddressAPI_VelocaService": addressApiVelocaService,
        "ListAccess": listAccess == null
            ? []
            : List<dynamic>.from(listAccess!.map((x) => x.toJson())),
        "ListSys_UserInGroup": listSysUserInGroup,
        "ListSys_UserInTeam": listSysUserInTeam,
        "Mst_SysConfigInvoice": mstSysConfigInvoice,
        "Roles": roles,
      };
}

class ListAccess {
  dynamic groupcode;
  String? objectcode;
  String? objectname;
  String? objecttype;
  String? logludtime;
  String? logluby;

  ListAccess({
    this.groupcode,
    this.objectcode,
    this.objectname,
    this.objecttype,
    this.logludtime,
    this.logluby,
  });

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
