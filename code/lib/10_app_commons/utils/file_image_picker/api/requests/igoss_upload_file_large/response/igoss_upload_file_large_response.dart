import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'igoss_upload_file_large_data.dart';

part 'igoss_upload_file_large_response.g.dart';

@JsonSerializable()
class IGossUploadFileLargeResponse extends BaseResponse {
  @JsonKey(name: "Data")
  FileLargeData? data;

  //begin boilerplate code
  IGossUploadFileLargeResponse();
  factory IGossUploadFileLargeResponse.fromJson(Map<String, dynamic> json) =>
      _$IGossUploadFileLargeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$IGossUploadFileLargeResponseToJson(this);
  static IGossUploadFileLargeResponse fromJsonModel(
          Map<String, dynamic> json) =>
      IGossUploadFileLargeResponse.fromJson(json);
//end boilerplate code
}
