import 'package:idealer/10_app_commons/base_controller/simple_controller.dart';
import 'package:idealer/10_app_commons/pivot/pivot_item.dart';
import 'package:idealer/10_app_commons/pivot/pivot_table.dart';
import 'package:idealer/10_app_commons/pivot/pivot_table_controller.dart';
import 'package:idealer/11_apis/core/models/pivot_retain_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';

class ReportRetainController extends SimpleController {
  static const pivotKeys = [
    "modelCode",
    "specCode",
    "specDescription",
    "colorCode",
    "colorName",
    "vin",
    "engineNo",
    "dlrContractNo",
    "userCodeOwner",
    "fullname",
    "deliveryOutDate",
    "soNgayTon",
    "dealerCode",
    // "soNgayChoGiao",
    // "ddDealNo",
  ];

  late PivotTableController pivotTableController;

  @override
  Future<void> simpleLoad() async {
    final data = await IDealerApiService.getReportPivotRetain();
    var pivotItems = data.map((e) {
      return _getPivotItem(e);
    }).toList();

    var pivotTable = PivotTable.createInstance(
        pivotItems, _headerNames(), "SL", _initSelectedKey());

    pivotTableController = PivotTableController(pivotTable);
  }

  PivotItem _getPivotItem(PivotRetainData apiData) {
    return PivotItem(
      data: {
        "modelCode": apiData.modelCode ?? "",
        "specCode": apiData.specCode ?? "",
        "specDescription": apiData.specDescription ?? "",
        "colorCode": apiData.colorCode ?? "",
        "colorName": apiData.colorName ?? "",
        "vin": apiData.vin ?? "",
        "engineNo": apiData.engineNo ?? "",
        "dlrContractNo": apiData.dlrContractNo ?? "",
        "userCodeOwner": apiData.userCodeOwner ?? "",
        "fullname": apiData.fullname ?? "",
        "deliveryOutDate": apiData.deliveryOutDate ?? "",
        "soNgayTon": apiData.soNgayTon ?? "",
        "dealerCode": apiData.dealerCode ?? "",
        // "soNgayChoGiao": apiData.soNgayChoGiao ?? "",
        // "ddDealNo": apiData.ddDealNo ?? "",
      },
      count: _getItemTotal(apiData.total),
    );
  }

  int _getItemTotal(String? total) {
    if (total == null) return 0;
    return (double.tryParse(total) ?? 0).toInt();
  }

  Map<String, String> _headerNames() {
    return {
      "modelCode": "Model",
      "specCode": "Mã Spec",
      "specDescription": "Mô tả",
      "colorCode": "Mã màu",
      "colorName": "Tên màu",
      "vin": "Vin",
      "engineNo": "Số máy",
      "dlrContractNo": "Số hợp đồng",
      "userCodeOwner": "Tư vấn bán hàng",
      "fullname": "Tên khách hàng",
      "deliveryOutDate": "Ngày nhận xe",
      "soNgayTon": "Số ngày tồn",
      "dealerCode": "Đại lý",
      // "soNgayChoGiao": "soNgayChoGiao",
      // "ddDealNo": "ddDealNo",
    };
  }

  List<String> _initSelectedKey() {
    return [
      "modelCode",
      "specCode",
      "specDescription",
    ];
  }
}
