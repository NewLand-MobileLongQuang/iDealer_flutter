import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/10_app_commons/base_controller/view/data_view.dart';
import 'package:idealer/10_app_commons/base_controller/view/simple_data_view.dart';
import 'package:idealer/10_app_commons/pivot/ui/pivot_data.dart';
import 'package:idealer/10_app_commons/pivot/ui/pivot_header.dart';
import 'package:idealer/11_apis/core/models/pivot_retain_data.dart';
import 'package:idealer/11_screens/app_bar_widget.dart';
import 'package:idealer/12_modules/reports/report_retain/controller/report_retain_controller.dart';
import 'package:idealer/12_modules/reports/report_retain/screens/components/pivot_column_selection.dart';

class ReportRetainScreen extends StatefulWidget {
  const ReportRetainScreen({Key? key}) : super(key: key);

  static Future<void> show() async {
    return await Get.to(const ReportRetainScreen());
  }

  @override
  State<ReportRetainScreen> createState() => _ReportRetainScreenState();
}

class _ReportRetainScreenState extends State<ReportRetainScreen> {
  late ReportRetainController controller;
  @override
  void initState() {
    controller = ReportRetainController();
    controller.reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: "Tồn kho",
      ),
      body: SimpleDataView(
        controller: controller,
        builder: (_) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                PivotHeader(
                  pivotTable: controller.pivotTableController.pivotTable,
                ),
                Expanded(
                  child: PivotData(
                    pivotTable: controller.pivotTableController.pivotTable,
                  ),
                ),
                PivotColumnSelection(
                  inputItems: controller
                      .pivotTableController.pivotTable.headerNames.values
                      .toList(),
                  onItemSelected: (selectedItems) {
                    print(selectedItems);
                    controller.pivotTableController
                        .setNewSelectedNames(selectedItems);
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
