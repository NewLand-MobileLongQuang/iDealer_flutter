import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/base_controller/base_controller.dart';
import 'package:idealer/10_app_commons/base_controller/view/data_view.dart';
import 'package:idealer/11_apis/core/models/wk_user_schedule_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';
import 'package:idealer/11_screens/home/ui/dialogs/notification_work_detail_dialog.dart';

class NotificationController extends BaseController<bool>{
  List<ListElement> elements = [];

  @override
  Future<bool> load(int loadLimit) async{
    var result = await IDealerApiService.getWkUserSchedule(
       AppConfig.instance().dateFormat.format(DateTime.now()) , AppConfig.instance().dateFormat.format(DateTime.now()), "P", "","", 0, loadLimit
    );
    if ((result.listElement??[]).isNotEmpty){
      elements = result.listElement??[];
    }

    return true;
  }

  void itemClick(int index){
    NotificationWorkDetailDialog.show(elements[index].schCode ?? "");
  }

}

class NotificationDialog extends StatefulWidget {
  const NotificationDialog({Key? key}) : super(key: key);

  static Future<void> show() {
    return Get.dialog(const NotificationDialog());
  }

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {

  late NotificationController controller;
  @override
  void initState() {
    controller = NotificationController();
    controller.reload();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(8),
      title: Container(
        height: 50,
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        alignment: Alignment.center,
        child: const Text(
          "Danh sách công việc trong ngày",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: DataView<bool>(
            controller: controller,
            builder: (ct, data){
          return Column(
            children: [
              const ItemNotifyDay(
                // icon: Icons.sort,
                workName: "Công việc",
                cusName: "Khách hàng",
                phone: "Điện thoại",
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                      );
                    },
                    itemCount: controller.elements.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.itemClick(index);
                        },
                        child: ItemNotifyDay(
                          // icon: Icons.settings,
                          workName:
                          (controller.elements)[index].kpiPlusName ?? "",
                          cusName:
                          (controller.elements )[index].fullName ?? "",
                          phone: (controller.elements)[index].phoneNo ?? "",
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      );
                    },
                  )),
              const SizedBox(
                height: 16,
              ),
              Container(height: 5, color: Colors.grey,),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            "Đóng",
                            style: TextStyle(color: Colors.white),
                          )))
                ],
              )
            ],
          );
        },
          useLoading: true,
          usePullDown: false,
          usePullUp: true,
          loadingEmptyWidget: Container(),
          showDataOnLoading: true,
          showDataOnError: true,
        ),
      ),
    );
  }
}

class ItemNotifyDay extends StatelessWidget {
  const ItemNotifyDay({
    Key? key,
    // required this.icon,
    required this.workName,
    required this.cusName,
    required this.phone,
    required this.fontWeight,
    required this.fontSize,
  }) : super(key: key);
  // final IconData icon;
  final String workName;
  final String cusName;
  final String phone;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      // color: itemColor,
      child: Row(
        children: [
          Expanded(
              child: Text(
                workName,
                style: TextStyle(
                    fontSize: fontSize, fontWeight: fontWeight, color: blackColor),
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(cusName,
                  style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: blackColor),
                  textAlign: TextAlign.center)),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(phone,
                  style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: blackColor),
                  textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
