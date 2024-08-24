import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/10_app_commons/base_controller/base_controller.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';
import 'package:idealer/11_apis/core/models/code_name.dart';
import 'package:idealer/11_apis/core/models/wk_user_schedule_data.dart';
import 'package:idealer/11_apis/core/requests/get_wk_user_schedule/response/wk_user_schedule_response.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';
import 'package:idealer/12_modules/work_create_detail/controller/work_create_controller.dart';
import 'package:idealer/12_modules/work_create_detail/work_create_screen.dart';
import 'package:idealer/12_modules/work_schedule/bottom_sheets/work_schedule_bottom_sheet.dart';

class WorkManageController extends BaseController<WkUserScheduleResponse> {
  List<ListElement> elements = [];

  @override
  Future<WkUserScheduleResponse> load(int loadLimit) async {
    // levelLst.clear;
    // levelLst.add(CodeName("", "All"));
    // levelLst.add(CodeName("HIGH", "Cao"));
    // levelLst.add(CodeName("LOW", "Thấp"));
    // levelLst.add(CodeName("MEDIUM", "Trung bình"));
    //
    // statusLst.clear;
    // statusLst.add(CodeName("", "All"));
    // statusLst.add(CodeName("P", "P"));
    // statusLst.add(CodeName("F", "F"));
    // statusLst.add(CodeName("C", "C"));

    var result = await IDealerApiService.getWkUserSchedule(
        fromDateTime.value,
        toDateTime.value,
        status.value.code,
        level.value.code,
        cusName.value,
        0,
        loadLimit);

    elements = result.listElement ?? [];

    return result;
  }

  void reloadData() {
    reload();
  }

  Rx<String> cusName = "".obs;
  Rx<String> fromDateTime =
      AppConfig.instance().dateFormat.format(DateTime.now()).obs;
  Rx<String> toDateTime = "".obs;
  Rx<CodeName> status = CodeName("", "").obs;
  Rx<CodeName> level = CodeName("", "").obs;
  List<CodeName> statusLst = [
    CodeName("", "All"),
    CodeName("P", "P"),
    CodeName("F", "F"),
    CodeName("C", "C")
  ];
  List<CodeName> levelLst = [
    CodeName("", "All"),
    CodeName("HIGH", "Cao"),
    CodeName("LOW", "Thấp"),
    CodeName("MEDIUM", "Trung bình")
  ];

  ///------------------------- event click -------------------------------/

  void addClick() async {
    var result = await WorkCreateScreen.show(WorkCreateControllerMode.create);
    if (result == true) {
      reloadData();
      MainGet.successAlert(message:"Lưu thành công");
    }
  }

  void editWork(int index) async {
    var result = await WorkCreateScreen.showDetail(
        WorkCreateControllerMode.update, elements[index].schCode ?? "");
    if (result == true) {
      reloadData();
      MainGet.successAlert(message:"Sửa công việc thành công");
    }
  }

  void detailWork(int index) async {
    WorkCreateScreen.showDetail(
        WorkCreateControllerMode.detail, elements[index].schCode ?? "");
  }

  void deleteWork(int index) async {
    var result = await Get.dialog(AlertDialog(
      title: const Text("Thông báo"),
      content: Text(
          "Bạn có chắc chắn muốn xóa công việc ${elements[index].schCode ?? ""}?"),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("No")),
        TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: const Text("Yes")),
      ],
    ));
    if (result == true) {
      try {
        var future =
            IDealerApiService.deleteWork(elements[index].schCode ?? "");
        var result = await MainGet.showHudProgress(future);
        if (result == true) {
          reloadData();
          MainGet.showToast("Xóa công việc thành công");
          // Get.back(result: true);
        } else {
          MainGet.showToast("Xóa thất bại");
        }
      } catch (error) {
        MainGet.showToast("Xóa thất bại");
      }
      return;
    }
  }

  ///--------------------------- event item --------------------------/

  void itemClick(int index) async {
    var result =
        await WorkScheduleBottomSheet.show(elements[index].usStatus ?? "");
    if (result == null) {
      return;
    }
    switch (result) {
      case WorkSelect.edit:
        editWork(index);
        break;
      case WorkSelect.detail:
        detailWork(index);
        break;
      case WorkSelect.delete:
        deleteWork(index);
        break;
    }
  }
}
