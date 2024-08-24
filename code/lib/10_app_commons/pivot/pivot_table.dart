import 'package:get/get.dart';
import 'package:idealer/10_app_commons/pivot/pivot_item.dart';

class PivotTable {
  List<PivotItem> items;

  Map<String, String> headerNames;

  String countHeaderName;

  List<String> selectedKeys;

  List<String>? _tableHeader;
  List<PivotItem>? _tableData;

  PivotTable._internal({
    required this.items,
    required this.headerNames,
    required this.countHeaderName,
    required this.selectedKeys,
  }) {
    _resetTableData();
  }

  factory PivotTable.createInstance(
      List<PivotItem> items,
      Map<String, String> headerNames,
      String countHeaderName,
      List<String> selectedKeys) {
    return PivotTable._internal(
        items: items,
        headerNames: headerNames,
        countHeaderName: countHeaderName,
        selectedKeys: selectedKeys);
  }

  void setNewSelectedKeys(List<String> selectedKeys) {
    this.selectedKeys = selectedKeys.toList();
    _calculateTableData();
  }

  List<String> getSelectedNames() {
    return selectedKeys.map((e) {
      return headerNames[e] ?? "";
    }).toList();
  }

  void _calculateTableData() {
    List<PivotItem> tableData = [];

    items.forEach((element) {
      var found = tableData.firstWhereOrNull((item) {
        return item.isSameItemGroup(element, selectedKeys);
      });
      if (found != null) {
        found.count += element.count;
      } else {
        var newItem = PivotItem(data: element.data, count: element.count);
        tableData.add(newItem);
      }
    });

    _tableData = tableData;

    var header = selectedKeys.map((e) {
      return headerNames[e] ?? "";
    }).toList();
    header.add(countHeaderName);
    _tableHeader = header;
  }

  void _resetTableData() {
    _tableHeader = null;
    _tableData = null;
  }

  List<String> get tableHeader {
    if (_tableHeader == null) {
      _calculateTableData();
    }
    return _tableHeader!;
  }

  List<PivotItem> get tableData {
    if (_tableData == null) {
      _calculateTableData();
    }
    return _tableData!;
  }
}
