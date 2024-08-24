import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/10_app_commons/base_controller/base_controller.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';
import 'package:idealer/11_apis/core/models/wk_user_schedule_data.dart';
import 'package:idealer/11_apis/core/models/work_schedule_in_month_data.dart';
import 'package:idealer/11_apis/core/requests/get_wk_user_schedule/response/wk_user_schedule_response.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';
import 'package:idealer/12_modules/work_create_detail/controller/work_create_controller.dart';
import 'package:idealer/12_modules/work_create_detail/work_create_screen.dart';
import 'package:idealer/12_modules/work_schedule/bottom_sheets/work_schedule_bottom_sheet.dart';

class WorkScheduleController extends BaseController<WkUserScheduleResponse> {
  DateFilter dateFilter = DateFilter();
  List<WorkScheduleInMonthData> workInMonths = [];
  List<ListElement> elements = [];

  // Dữ liệu trên lịch
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusDay = DateTime.now().obs;

  // Các ngày có lịch
  Map<DateTime, List<String>> events = <DateTime, List<String>>{};

  @override
  Future<WkUserScheduleResponse> load(int loadLimit) async {
    // await getWorkInMonths(selectedDay.value);
    var result = await IDealerApiService.getWkUserSchedule(
        dateFilter.fromDate ?? "",
        dateFilter.toDate ?? "",
        dateFilter.usStatus ?? "",
        "",
        "",
        0,
        loadLimit);

    elements = result.listElement ?? [];

    return result;
  }

  Future<void> getWorkInMonths(DateTime dateTime) async {
    String year = dateTime.year.toString();
    String month = dateTime.month.toString();
    workInMonths = await IDealerApiService.getWorkScheduleInMonth(year, month);
    for (WorkScheduleInMonthData mWork in workInMonths) {
      for (ListDateOfWeek mDateOfWeek in mWork.listDateOfWeek ?? []) {
        if ((mDateOfWeek.isWork ?? false) == true) {
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
              (int.tryParse(mDateOfWeek.curDate?.substring(6, 19) ?? "0") ??
                      0) +
                  25200000,
              isUtc: true);
          events[dateTime] = [""];
        }
      }
    }
  }

  void setFilter(DateTime dateTime, WorkScheduleController controller) {
    selectedDay.value = dateTime;
    dateFilter.fromDate = AppConfig().dateFormat.format(selectedDay.value);
    dateFilter.toDate = AppConfig().dateFormat.format(selectedDay.value);
    controller.reload();
  }

  List<String> getEvents(DateTime dateTime) {
    return events[dateTime] ?? [];
  }

  ///------------------------- event click -------------------------------/

  void addClick() async {
    var result = await WorkCreateScreen.show(WorkCreateControllerMode.create);
    if (result == true) {
      reload();
      MainGet.successAlert(message:"Lưu thành công");
    }
  }

  void editWork(int index) async {
    var result = await WorkCreateScreen.showDetail(
        WorkCreateControllerMode.update, elements[index].schCode ?? "");
    if (result == true) {
      reload();
      MainGet.successAlert(message:"Sửa công việc thành công");
    }
  }

  void detailWork(int index) async {
    WorkCreateScreen.showDetail(
        WorkCreateControllerMode.detail, elements[index].schCode ?? "");
  }

  Future<bool?> deleteWork(int index) async {
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
          MainGet.successAlert(message: "Xóa công việc thành công");
          return true;
        } else {
          MainGet.errorDialog(error: "Xóa thất bại");
          return false;
        }
      } catch (error) {
        MainGet.errorDialog(error: "Xóa thất bại");
        return false;
      }
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
        var result = await deleteWork(index);
        if(result == true) reload();
        break;
    }
  }
}

class DateFilter {
  String? fromDate = AppConfig.instance().dateFormat.format(DateTime.now());
  String? toDate = AppConfig.instance().dateFormat.format(DateTime.now());
  String? usStatus;

  DateFilter clone() {
    var newItem = DateFilter();
    newItem.fromDate = fromDate;
    newItem.toDate = toDate;
    newItem.usStatus = usStatus;
    return newItem;
  }
}
