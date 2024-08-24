import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/base_controller/view/data_view.dart';
import 'package:idealer/11_apis/core/models/car_plan_data.dart';
import 'package:idealer/11_screens/app_bar_widget.dart';
import 'package:idealer/12_modules/reports/report_synthetic_vehicle/controller/report_synthetic_vehicle_controller.dart';

class ReportSyntheticVehicleScreen extends StatefulWidget {
  const ReportSyntheticVehicleScreen({Key? key}) : super(key: key);

  static Future<void>? show() async {
    return await Get.to(const ReportSyntheticVehicleScreen());
  }

  @override
  State<ReportSyntheticVehicleScreen> createState() =>
      _ReportSyntheticVehicleScreenState();
}

class _ReportSyntheticVehicleScreenState
    extends State<ReportSyntheticVehicleScreen> {
  late ReportSyntheticVehicleController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller = ReportSyntheticVehicleController();
    controller.reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: "Báo cáo tổng hợp xe",
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 12, 8.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Danh sách xe",
                style: TextStyle(
                    color: blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
              margin: const EdgeInsets.only(top: 8),
            ),
            const ItemReportCarPlan(
              spec: 'Mô tả Spec',
              color: "Tên màu",
              retain: "Tồn kho",
              count: 'SL có thể bán',
              fontWeight: FontWeight.bold,
            ),
            Expanded(
              child: DataView<List<CarPlanData>>(
                controller: controller,
                builder: (controller, data) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ItemReportCarPlan(
                        spec: data[index].specDescription ?? "",
                        color: data[index].colorName ?? "",
                        retain: data[index].soLuongTonKho ?? "",
                        count: data[index].soLuongCoTheBan ?? "",
                        fontWeight: FontWeight.normal,
                      );
                    },
                    itemCount: data.length,
                  );
                },
                useLoading: true,
                usePullDown: true,
                usePullUp: true,
                loadingEmptyWidget: Container(),
                showDataOnLoading: true,
                showDataOnError: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemReportCarPlan extends StatelessWidget {
  const ItemReportCarPlan({
    Key? key,
    required this.spec,
    required this.color,
    required this.retain,
    required this.count,
    required this.fontWeight,
  }) : super(key: key);
  final String spec;
  final String color;
  final String retain;
  final String count;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Text(
            spec,
            style: TextStyle(fontWeight: fontWeight, fontSize: 15),
            textAlign: TextAlign.center,
          )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(
            color,
            style: TextStyle(fontWeight: fontWeight, fontSize: 15),
            textAlign: TextAlign.center,
          )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(
            retain,
            style: TextStyle(fontWeight: fontWeight, fontSize: 15),
            textAlign: TextAlign.center,
          )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(
            count,
            style: TextStyle(fontWeight: fontWeight, fontSize: 15),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }
}
