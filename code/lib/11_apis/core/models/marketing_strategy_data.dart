// To parse this JSON data, do
//
//     final marketingStrategyData = marketingStrategyDataFromJson(jsonString);

import 'dart:convert';

class MarketingStrategyData {
  MarketingStrategyData({
    this.dealerCode,
    this.campaignCode,
    this.campaignName,
    this.effDTimeStart,
    this.effDTimeEnd,
    this.remark,
    this.flagActive,
  });

  String? dealerCode;
  String? campaignCode;
  String? campaignName;
  String? effDTimeStart;
  String? effDTimeEnd;
  String? remark;
  String? flagActive;

  factory MarketingStrategyData.fromRawJson(String str) => MarketingStrategyData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarketingStrategyData.fromJson(Map<String, dynamic> json) => MarketingStrategyData(
    dealerCode: json["DealerCode"],
    campaignCode: json["CampaignCode"],
    campaignName: json["CampaignName"],
    effDTimeStart: json["EffDTimeStart"],
    effDTimeEnd: json["EffDTimeEnd"],
    remark: json["Remark"],
    flagActive: json["FlagActive"],
  );

  Map<String, dynamic> toJson() => {
    "DealerCode": dealerCode,
    "CampaignCode": campaignCode,
    "CampaignName": campaignName,
    "EffDTimeStart": effDTimeStart,
    "EffDTimeEnd": effDTimeEnd,
    "Remark": remark,
    "FlagActive": flagActive,
  };
}
