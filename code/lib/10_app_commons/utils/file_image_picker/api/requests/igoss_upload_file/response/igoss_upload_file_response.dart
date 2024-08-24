import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'igoss_upload_file_data.dart';

part 'igoss_upload_file_response.g.dart';

@JsonSerializable()
class IGossUploadFileResponse extends BaseResponse {
  @JsonKey(name: "Data")
  IGossUploadFileData? data;

  //begin boilerplate code
  IGossUploadFileResponse();
  factory IGossUploadFileResponse.fromJson(Map<String, dynamic> json) =>
      _$IGossUploadFileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$IGossUploadFileResponseToJson(this);
  static IGossUploadFileResponse fromJsonModel(Map<String, dynamic> json) =>
      IGossUploadFileResponse.fromJson(json);
//end boilerplate code
}
