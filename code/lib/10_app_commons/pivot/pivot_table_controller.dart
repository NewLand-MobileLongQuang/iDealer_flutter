import 'package:idealer/10_app_commons/pivot/pivot_table.dart';

class PivotTableController {
  PivotTable pivotTable;

  PivotTableController(this.pivotTable);

  void setNewSelectedNames(List<String> selectedNames) {
    List<String> newKeys = [];
    for (var element in pivotTable.headerNames.keys) {
      if (selectedNames.contains(pivotTable.headerNames[element])) {
        newKeys.add(element);
      }
    }
    print(newKeys);
    pivotTable.setNewSelectedKeys(newKeys);
  }
}
