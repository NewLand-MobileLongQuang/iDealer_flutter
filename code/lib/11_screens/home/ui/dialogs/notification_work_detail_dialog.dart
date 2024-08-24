import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/base_controller/base_controller.dart';
import 'package:idealer/10_app_commons/base_controller/view/data_view.dart';
import 'package:idealer/11_apis/core/models/work_detail_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';
import 'package:idealer/12_modules/work_create_detail/dialogs/view_image_dialog.dart';

class NotificationWorkDetailController extends BaseController<bool> {
  String schCode = "";
  WorkDetailData workDetail = WorkDetailData();

  @override
  Future<bool> load(int loadLimit) async {
    var result = await IDealerApiService.getWorkDetail(schCode);
    if (result.isNotEmpty) {
      workDetail = result[0];
    }
    return true;
  }

  String convertRankingType(String rankingType){
    switch (rankingType){
      case "GOOD" : return "Hài lòng";
      case "LOW" : return "Bình thường";
      case "NOTGOOD" : return "Không hài lòng";
      default : return " ";
    }
  }
}

class NotificationWorkDetailDialog extends StatefulWidget {
  const NotificationWorkDetailDialog({Key? key, required this.schCode})
      : super(key: key);
  final String schCode;

  static Future<void> show(String schCode) {
    return Get.dialog(NotificationWorkDetailDialog(
      schCode: schCode,
    ));
  }

  @override
  State<NotificationWorkDetailDialog> createState() =>
      _NotificationWorkDetailDialogState();
}

class _NotificationWorkDetailDialogState
    extends State<NotificationWorkDetailDialog> {
  NotificationWorkDetailController controller =
      NotificationWorkDetailController();

  @override
  void initState() {
    controller = NotificationWorkDetailController();
    controller.schCode = widget.schCode;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                "Chi tiết công việc",
                style: TextStyle(
                    color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                )),
          ],
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: DataView(
            controller: controller,
            builder: (ct, data) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                      GestureDetector(
                        onTap: (){
                          if (controller.workDetail.filePath != null && controller.workDetail.filePath != ""){
                            ViewImageDialog.show(controller.workDetail.filePath??"");
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: (controller.workDetail.filePath != null && controller.workDetail.filePath != "")?
                          NetworkImage("${AppConfig.instance().accountMobileUrl}${controller.workDetail.filePath??""}",) : null,
                          radius: 60,
                          child: (controller.workDetail.filePath != null && controller.workDetail.filePath != "")?
                          null : SvgPicture.asset("assets/icons/ic_avatar_default.svg", height: double.maxFinite,),
                        ),
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(controller.workDetail.fullName??" ", style: const TextStyle(fontWeight: FontWeight.bold, color: blackColor, fontSize: 17),),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Sđt: ", style: TextStyle(color: blackColor, fontSize: 14)),
                        Text(controller.workDetail.phoneNo??" ", style: const TextStyle(color: blackColor, fontSize: 14),),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(
                          text: controller.workDetail.effDTimeStart??" "),
                      decoration: const InputDecoration(
                        labelText: "Thời gian thực hiện",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(text: controller.workDetail.kpiPlusName??" "),
                      decoration: const InputDecoration(
                        labelText: "Tên công việc",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // TextFormField(
                    //   enabled: false,
                    //   controller: TextEditingController(text: controller.workDetail.fullName??" "),
                    //   decoration: const InputDecoration(
                    //     labelText: "Tên khách hàng",
                    //     border: OutlineInputBorder(),
                    //     contentPadding: EdgeInsets.only(left: 12, right: 12),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // TextFormField(
                    //   enabled: false,
                    //   controller: TextEditingController(text: controller.workDetail.phoneNo??" "),
                    //   decoration: const InputDecoration(
                    //     labelText: "Số điện thoại",
                    //     border: OutlineInputBorder(),
                    //     contentPadding: EdgeInsets.only(left: 12, right: 12),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(text: controller.workDetail.remark??" "),
                      decoration: const InputDecoration(
                        labelText: "Mô tả",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(text: controller.workDetail.schLocation??" "),
                      decoration: const InputDecoration(
                        labelText: "Địa điểm",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(text: controller.workDetail.customerContactPhoneNo??" "),
                      decoration: const InputDecoration(
                        labelText: "Điện thoại người liên hệ",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(text: controller.workDetail.customerCode??" "),
                      decoration: const InputDecoration(
                        labelText: "Mã khách hàng",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(text: controller.workDetail.salesId??" "),
                      decoration: const InputDecoration(
                        labelText: "Mã cơ hội",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(text: controller.workDetail.schCode??" "),
                      decoration: const InputDecoration(
                        labelText: "Mã công việc",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(text: controller.workDetail.createDTime??" "),
                      decoration: const InputDecoration(
                        labelText: "Thời gian tạo",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(text: controller.workDetail.createBy??" "),
                      decoration: const InputDecoration(
                        labelText: "Nhân viên tạo",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(text: controller.workDetail.usStatus??" "),
                      decoration: const InputDecoration(
                        labelText: "Trạng thái",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(text: controller.workDetail.levelType??" "),
                      decoration: const InputDecoration(
                        labelText: "Mức độ ưu tiên",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(text: controller.convertRankingType(controller.workDetail.rankingType??"")),
                      decoration: const InputDecoration(
                        labelText: "Đánh giá",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
