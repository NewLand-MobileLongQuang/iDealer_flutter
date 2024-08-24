// To parse this JSON data, do
//
//     final iGossUploadFileLargeData = iGossUploadFileLargeDataFromJson(jsonString);

import 'dart:convert';

class FileLargeData {
  FileLargeData({
    this.url,
    this.fileName,
    this.name,
    this.fileSize,
  });

  String? url;
  String? fileName;
  String? name;
  int? fileSize;

  factory FileLargeData.fromRawJson(String str) =>
      FileLargeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FileLargeData.fromJson(Map<String, dynamic> json) => FileLargeData(
        url: json["Url"],
        fileName: json["FileName"],
        name: json["Name"],
        fileSize: json["FileSize"],
      );

  Map<String, dynamic> toJson() => {
        "Url": url,
        "FileName": fileName,
        "Name": name,
        "FileSize": fileSize,
      };
}
