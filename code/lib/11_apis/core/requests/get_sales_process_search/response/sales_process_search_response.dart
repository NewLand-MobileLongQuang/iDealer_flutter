import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
import 'package:idealer/11_apis/core/models/sales_process_search_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sales_process_search_response.g.dart';

@JsonSerializable()
class SalesProcessSearchResponse extends BaseResponse{
  // @JsonKey(name: "Success")
  // bool? success;

  @JsonKey(name: "list")
  List<ListElement>? data;

  @JsonKey(name: "ItemCount")
  int? itemCount;

  SalesProcessSearchResponse();

  factory SalesProcessSearchResponse.fromJson(Map<String, dynamic> json) => _$SalesProcessSearchResponseFromJson(json);

  static SalesProcessSearchResponse fromJsonModel(Map<String, dynamic> json){
    return SalesProcessSearchResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$SalesProcessSearchResponseToJson(this);
}
