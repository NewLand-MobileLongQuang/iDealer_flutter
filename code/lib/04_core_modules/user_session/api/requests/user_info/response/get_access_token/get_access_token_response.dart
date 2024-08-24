import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GetAccessTokenResponse extends BaseResponse{
  @JsonKey(name: "User") String? user;
  @JsonKey(name: "AccessToken") String? accessToken;
  @JsonKey(name: "RefreshToken") String? refreshToken;

  GetAccessTokenResponse();

  factory GetAccessTokenResponse.fromJson(Map<String, dynamic> json) =>  GetAccessTokenResponse()
    ..success = json['Success'] as bool?
    ..errorData = json['ErrorData'] == null
        ? null
        : ErrorData.fromJson(json['ErrorData'] as Map<String, dynamic>)
    ..accessToken = json['AccessToken'] as String?
    ..refreshToken = json['RefreshToken'] as String?;

  static GetAccessTokenResponse fromJsonModel(Map<String, dynamic> json){
    return GetAccessTokenResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'Success': success,
    'ErrorData': errorData,
    'AccessToken': accessToken,
    'RefreshToken': refreshToken,

  };
}