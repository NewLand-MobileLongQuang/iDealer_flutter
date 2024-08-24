import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'igoss_upload_file_data.g.dart';

@JsonSerializable()
class IGossUploadFileData extends BaseResponse {
  @JsonKey(name: "Url")
  String? Url;

  @JsonKey(name: "Message")
  String? Message;

  // @JsonKey(name: "FileName")
  // String? FileName;
  //
  // @JsonKey(name: "Name")
  // String? Name;
  //
  // @JsonKey(name: "FileSize")
  // int? FileSize;

  //begin boilerplate code
  IGossUploadFileData();
  factory IGossUploadFileData.fromJson(Map<String, dynamic> json) =>
      _$IGossUploadFileDataFromJson(json);
  Map<String, dynamic> toJson() => _$IGossUploadFileDataToJson(this);
  static IGossUploadFileData fromJsonModel(Map<String, dynamic> json) =>
      IGossUploadFileData.fromJson(json);
//end boilerplate code
}
