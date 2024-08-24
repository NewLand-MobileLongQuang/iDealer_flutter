import 'package:json_annotation/json_annotation.dart';

part 'core_api_response.g.dart';

@JsonSerializable()
class CoreApiResponse {
  CoreApiResponse();

  factory CoreApiResponse.fromJson(Map<String, dynamic> json) =>
      _$CoreApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CoreApiResponseToJson(this);
}
