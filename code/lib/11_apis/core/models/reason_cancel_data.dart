// To parse this JSON data, do
//
//     final reasonCancelData = reasonCancelDataFromJson(jsonString);

import 'dart:convert';

class ReasonCancelData {
  ReasonCancelData({
    this.spCancelReasonCode,
    this.spCancelReasonName,
    this.remark,
    this.flagActive,
  });

  String? spCancelReasonCode;
  String? spCancelReasonName;
  String? remark;
  String? flagActive;

  factory ReasonCancelData.fromRawJson(String str) =>
      ReasonCancelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReasonCancelData.fromJson(Map<String, dynamic> json) =>
      ReasonCancelData(
        spCancelReasonCode: json["SPCancelReasonCode"],
        spCancelReasonName: json["SPCancelReasonName"],
        remark: json["Remark"],
        flagActive: json["FlagActive"],
      );

  Map<String, dynamic> toJson() => {
        "SPCancelReasonCode": spCancelReasonCode,
        "SPCancelReasonName": spCancelReasonName,
        "Remark": remark,
        "FlagActive": flagActive,
      };
}
