// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class MstSMKPIPlusData {
  MstSMKPIPlusData({
    this.kpiPlusCode,
    this.smkpiPlusType,
    this.kpiPlusName,
    this.smsContent,
    this.remark,
    this.flagActive,
    this.createdDate,
    this.createdBy,
    this.logLuDateTime,
    this.logLuBy,
    this.status,
  });

  String? kpiPlusCode;
  String? smkpiPlusType;
  String? kpiPlusName;
  String? smsContent;
  String? remark;
  String? flagActive;
  String? createdDate;
  String? createdBy;
  String? logLuDateTime;
  String? logLuBy;
  dynamic status;

  factory MstSMKPIPlusData.fromRawJson(String str) => MstSMKPIPlusData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MstSMKPIPlusData.fromJson(Map<String, dynamic> json) => MstSMKPIPlusData(
    kpiPlusCode: json["KPIPlusCode"],
    smkpiPlusType: json["SMKPIPlusType"],
    kpiPlusName: json["KPIPlusName"],
    smsContent: json["SMSContent"] == null ? null : json["SMSContent"],
    remark: json["Remark"],
    flagActive: json["FlagActive"],
    createdDate: json["CreatedDate"],
    createdBy: json["CreatedBy"],
    logLuDateTime: json["LogLUDateTime"],
    logLuBy: json["LogLUBy"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "KPIPlusCode": kpiPlusCode,
    "SMKPIPlusType": smkpiPlusType,
    "KPIPlusName": kpiPlusName,
    "SMSContent": smsContent == null ? null : smsContent,
    "Remark": remark,
    "FlagActive": flagActive,
    "CreatedDate": createdDate,
    "CreatedBy": createdBy,
    "LogLUDateTime": logLuDateTime,
    "LogLUBy": logLuBy,
    "Status": status,
  };
}
