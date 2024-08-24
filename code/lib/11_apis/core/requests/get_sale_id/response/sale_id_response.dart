import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'sale_id_response.g.dart';

@JsonSerializable()
class SaleIdResponse extends BaseResponse{
  // @JsonKey(name: "Success")
  // bool? success;

  @JsonKey(name: "SalesID")
  String? data;

  SaleIdResponse();

  factory SaleIdResponse.fromJson(Map<String, dynamic> json) => _$SaleIdResponseFromJson(json);

  static SaleIdResponse fromJsonModel(Map<String, dynamic> json){
    return SaleIdResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$SaleIdResponseToJson(this);
}
