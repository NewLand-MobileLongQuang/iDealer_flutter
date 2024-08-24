
import 'dart:convert';

// class ListSalesProcessDtl {
//
//   String? salesID;
//   String? modelCode;
//   String? colorCode;
//   String? specCode;
//   String? qty;
//   String? sPStatusDtl;
//   String? remark;
//   String? modelName;
//   String? specDesc;
//   String? namSanXuat;
//   String? xuatXu;
//   String? colorIntNameVN;
//   String? colorExtNameVN;
//   dynamic price;
//   dynamic vAT;
//   dynamic giaTruocVAT;
//   dynamic tongTienTruocVAT;
//   dynamic tongTienSauVAT;
//
//
//   ListSalesProcessDtl({
//       this.salesID,
//       this.modelCode,
//       this.colorCode,
//       this.specCode,
//       this.qty,
//       this.sPStatusDtl,
//       this.remark,
//       this.modelName,
//       this.specDesc,
//       this.namSanXuat,
//       this.xuatXu,
//       this.colorIntNameVN,
//       this.colorExtNameVN,
//       this.price,
//       this.vAT,
//       this.giaTruocVAT,
//       this.tongTienTruocVAT,
//       this.tongTienSauVAT});
//
//   factory ListSalesProcessDtl.fromRawJson(String str) => ListSalesProcessDtl.fromJson(json.decode(str));
//   String toRawJson() => json.encode(toJson());
//
//   factory ListSalesProcessDtl.fromJson(Map<String, dynamic> json) => ListSalesProcessDtl(
//     salesID: json["SalesID"],
//     modelCode: json["ModelCode"],
//     colorCode: json["ColorCode"],
//     specCode: json["SpecCode"],
//     qty: json["Qty"],
//     sPStatusDtl: json["SPStatusDtl"],
//     remark: json["Remark"],
//     modelName: json["ModelName"],
//     specDesc: json["SpecDesc"],
//     namSanXuat: json["NamSanXuat"],
//     xuatXu: json["XuatXu"],
//     colorIntNameVN: json["ColorIntNameVN"],
//     colorExtNameVN: json["ColorExtNameVN"],
//     price: json["Price"],
//     vAT: json["VAT"],
//     giaTruocVAT: json["GiaTruocVAT"],
//     tongTienTruocVAT: json["TongTienTruocVAT"],
//     tongTienSauVAT: json["TongTienSauVAT"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "SalesID": salesID,
//     "ModelCode": modelCode,
//     "ColorCode": colorCode,
//     "SpecCode": specCode,
//     "Qty": qty,
//     "SPStatusDtl": sPStatusDtl,
//     "Remark": remark,
//     "ModelName": modelName,
//     "SpecDesc": specDesc,
//     "NamSanXuat": namSanXuat,
//     "XuatXu": xuatXu,
//     "ColorIntNameVN": colorIntNameVN,
//     "ColorExtNameVN": colorExtNameVN,
//     "Price": price,
//     "VAT": vAT,
//     "GiaTruocVAT": giaTruocVAT,
//     "TongTienTruocVAT": tongTienTruocVAT,
//     "TongTienSauVAT": tongTienSauVAT,
//
//   };
//
// }