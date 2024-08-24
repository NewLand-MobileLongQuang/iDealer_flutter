import 'package:flutter/material.dart';
import 'package:idealer/10_app_commons/pivot/pivot_item.dart';
import 'package:idealer/10_app_commons/pivot/pivot_table.dart';

class PivotData extends StatelessWidget {
  const PivotData({
    Key? key,
    required this.pivotTable,
  }) : super(key: key);

  final PivotTable pivotTable;

  @override
  Widget build(BuildContext context) {
    List<PivotItem> data = pivotTable.tableData;
    var selectedKeys = pivotTable.selectedKeys;

    List<Widget> dataWidgets = [];
    for (var i = 0; i < data.length; i++) {
      var item = data[i];

      List<Widget> row = [];
      for (int j = 0; j < selectedKeys.length; j++) {
        row.add(
          Expanded(
            child: Text(
              item.data[selectedKeys[j]] ?? "",
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        );
        row.add(const SizedBox(
          width: 8,
        ));
      }
      row.add(
        Expanded(
          child: Text(
            item.count.toString(),
            style: TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ),
      );
      dataWidgets.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: row,
          ),
        ),
      );
    }

    return ListView.separated(
        itemBuilder: (context, index) {
          return dataWidgets[index];
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: dataWidgets.length);
  }
}
