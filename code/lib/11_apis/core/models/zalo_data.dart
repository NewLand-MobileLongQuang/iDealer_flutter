// To parse this JSON data, do
//
//     final zaloData = zaloDataFromJson(jsonString);

import 'dart:convert';

class ZaloData {
  ZaloData({
    this.userId,
    this.userGender,
    this.userIdByApp,
    this.avatar,
    this.displayName,
  });

  double? userId;
  int? userGender;
  double? userIdByApp;
  String? avatar;
  String? displayName;

  factory ZaloData.fromRawJson(String str) =>
      ZaloData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ZaloData.fromJson(Map<String, dynamic> json) => ZaloData(
        userId: json["user_id"].toDouble(),
        userGender: json["user_gender"],
        userIdByApp: json["user_id_by_app"].toDouble(),
        avatar: json["avatar"],
        displayName: json["display_name"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_gender": userGender,
        "user_id_by_app": userIdByApp,
        "avatar": avatar,
        "display_name": displayName,
      };

  static bool compareFn(ZaloData? one, ZaloData? two) {
    if (one == null) {
      if (two == null) {
        return true;
      }
      return false;
    }
    if (two == null) {
      return false;
    }
    if (one.userId == two.userId) {
      return true;
    }
    return false;
  }
}
