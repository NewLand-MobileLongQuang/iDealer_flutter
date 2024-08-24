import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/10_app_commons/base_controller/base_controller.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';
import 'package:idealer/11_apis/core/models/sales_process_search_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';
import 'package:idealer/12_modules/opportunity/opportunity_create/bottom_sheets/opportunity_bottom_sheet.dart';
import 'package:idealer/12_modules/opportunity/opportunity_create/controller/opportunity_create_controller.dart';
import 'package:idealer/12_modules/opportunity/opportunity_create/opportunity_create_screen.dart';
import 'package:idealer/12_modules/opportunity/opportunity_manage/dialogs/cancel_opportunity_dialog.dart';


class OpportunityManageController extends BaseController<bool> {
  List<ListElement> get elements => elementsObx.value;
  var elementsObx = <ListElement>[].obs;
  @override
  Future<bool> load(int loadLimit) async {
    elementsObx.value = await IDealerApiService.getSalesProcessSearch(
        fromDate.value,
        toDate.value,
        cusfullname.value,
        thamkhao.value,
        quantam.value,
        laithu.value,
        damphan.value,
        kyhd.value,
        huy.value,
        0,
        loadLimit);
    if (elements.isEmpty) {
      elementsObx.value = [];
    }
    return true;
  }

  searchClick() {
    if (isThamkhao.value) {
      thamkhao.value = "1";
    } else {
      thamkhao.value = "";
    }

    if (isQuantam.value) {
      quantam.value = "1";
    } else {
      quantam.value = "";
    }

    if (isLaithu.value) {
      laithu.value = "1";
    } else {
      laithu.value = "";
    }

    if (isDamphan.value) {
      damphan.value = "1";
    } else {
      damphan.value = "";
    }

    if (isKyhd.value) {
      kyhd.value = "1";
    } else {
      kyhd.value = "";
    }

    if (isHuy.value) {
      huy.value = "1";
    } else {
      huy.value = "";
    }
    reload();
  }

  Rx<String> cusfullname = "".obs;
  Rx<String> fromDate = "".obs;
  Rx<String> toDate = "".obs;
  Rx<bool> isThamkhao = false.obs;
  Rx<bool> isQuantam = false.obs;
  Rx<bool> isLaithu = false.obs;
  Rx<bool> isDamphan = false.obs;
  Rx<bool> isKyhd = false.obs;
  Rx<bool> isHuy = false.obs;

  Rx<String> thamkhao = "".obs;
  Rx<String> quantam = "".obs;
  Rx<String> laithu = "".obs;
  Rx<String> damphan = "".obs;
  Rx<String> kyhd = "".obs;
  Rx<String> huy = "".obs;

  void editOpportunity(int index) async {
    var result = await OpportunityCreateScreen.show(
        OpportunityCreateMode.update, elements[index].salesId ?? "");
    if (result == true) {
      MainGet.successAlert(message:"Cập nhật cơ hội thành công");
    }
  }

  void detailOpportunity(int index) {
    OpportunityCreateScreen.show(
        OpportunityCreateMode.detail, elements[index].salesId ?? "");
  }

  void deleteOpportunity(int index) async {
    var result =
        await CancelOpportunityDialog.show(elements[index].salesId ?? "");
    if (result == true) {
      MainGet.successAlert(message: "Hủy thành công");
      reload();
    }
  }

  ///--------------------------- event item --------------------------/

  void itemClick(int index) async {
    var result =
        await OpportunityBottomSheet.show(elements[index].spStatus ?? "");
    if (result == null) {
      return;
    }
    switch (result) {
      case OpportunitySelect.edit:
        editOpportunity(index);
        break;
      case OpportunitySelect.detail:
        detailOpportunity(index);
        break;
      case OpportunitySelect.delete:
        deleteOpportunity(index);
        break;
    }
  }
}
