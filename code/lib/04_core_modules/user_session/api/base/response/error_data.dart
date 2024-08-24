import 'package:json_annotation/json_annotation.dart';

part 'error_data.g.dart';

@JsonSerializable()
class ErrorData {
  @JsonKey(name: "ErrorCode")
  String? errorCode;

  @JsonKey(name: "Message")
  String? message;

  ErrorData();

  factory ErrorData.fromJson(Map<String, dynamic> json) =>
      _$ErrorDataFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorDataToJson(this);
}
