import 'package:flutter/material.dart';
import 'package:idealer/10_app_commons/pivot/pivot_table.dart';

class PivotHeader extends StatelessWidget {
  const PivotHeader({
    Key? key,
    required this.pivotTable,
  }) : super(key: key);

  final PivotTable pivotTable;

  @override
  Widget build(BuildContext context) {
    List<String> headers = pivotTable.tableHeader;

    List<Widget> headerWidgets = [];
    for (var i = 0; i < headers.length; i++) {
      headerWidgets.add(Expanded(
          child: Text(
        headers[i],
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        textAlign: TextAlign.center,
      )));
      if (i < headers.length - 1) {
        headerWidgets.add(const SizedBox(
          width: 8,
        ));
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: headerWidgets,
      ),
    );
  }
}
