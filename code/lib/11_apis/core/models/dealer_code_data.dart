import 'dart:convert';

class DealerCodeData {
  DealerCodeData({
    required this.success,
    required this.listDealerCode,
  });

  bool success;
  String listDealerCode;

  factory DealerCodeData.fromRawJson(String str) => DealerCodeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DealerCodeData.fromJson(Map<String, dynamic> json) => DealerCodeData(
    success: json["Success"],
    listDealerCode: json["ListDealerCode"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "ListDealerCode": listDealerCode,
  };
}