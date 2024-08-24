import 'package:idealer/04_core_modules/user_session/api/models/user_cur.dart';

class UserInfo {
  String? userName;
  String? password;
  String? dealerCode;
  UserCur? userCur;
  String? sessionId;
  String? flagSendSMS;

  UserInfo({
    this.userName,
    this.password,
    this.dealerCode,
    this.userCur,
    this.sessionId,
    this.flagSendSMS,
  });
}

// import 'dart:convert';
//
// class UserInfo {
//   UserInfo({
//     this.userName,
//     this.password,
//     this.dealerCode,
//     this.userCur,
//     this.flagSendSms,
//     this.sessionId,
//   });
//
//   String? userName;
//   String? password;
//   String? dealerCode;
//   UserCur? userCur;
//   String? flagSendSms;
//   String? sessionId;
//
//   factory UserInfo.fromRawJson(String str) => UserInfo.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
//     userName: json["UserName"],
//     password: json["Password"],
//     dealerCode: json["DealerCode"],
//     userCur: json["UserCur"] == null ? null : UserCur.fromJson(json["UserCur"]),
//     flagSendSms: json["FlagSendSMS"],
//     sessionId: json["SessionId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "UserName": userName,
//     "Password": password,
//     "DealerCode": dealerCode,
//     "UserCur": userCur == null ? null : userCur?.toJson(),
//     "FlagSendSMS": flagSendSms,
//     "SessionId": sessionId,
//   };
// }


