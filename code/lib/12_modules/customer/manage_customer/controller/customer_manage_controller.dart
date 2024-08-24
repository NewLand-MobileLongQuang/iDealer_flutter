import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/10_app_commons/base_controller/base_controller.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';
import 'package:idealer/11_apis/core/models/customer_group_type_data.dart';
import 'package:idealer/11_apis/core/models/customer_type_data.dart';
import 'package:idealer/11_apis/core/models/dealer_customer_contact_search_data.dart';
import 'package:idealer/11_apis/core/models/mst_province_data.dart';
import 'package:idealer/11_apis/core/models/user_by_dealer_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';
import 'package:idealer/12_modules/customer/create_customer/controller/create_customer_controller.dart';
import 'package:idealer/12_modules/customer/create_customer/screen/create_customer_screen.dart';
import 'package:idealer/12_modules/customer/manage_customer/bottom_sheets/customer_manage_bottom_sheet.dart';

class CustomerManageController extends BaseController<bool> {
  List<DealerCustomerContactSearchData> get dealerCustomers =>
      dealerCustomersObx.value;
  var dealerCustomersObx = <DealerCustomerContactSearchData>[].obs;
  Rx<int> flagActive = 0.obs;
  Rx<int> flagActiveNot = 0.obs;

  @override
  Future<bool> load(int loadLimit) async {
    dealerCustomersObx.value = await IDealerApiService.getDealerCustomerSearch(
        cusName.value,
        phone.value,
        phoneNoContract.value,
        userByDealer.value.userCode ?? "",
        dealerCode.value,
        cusType.value.customerTypeCode ?? "",
        cusGroup.value.customerGrpType ?? "",
        province.value.provinceCode ?? "",
        fromDate.value,
        toDate.value,
        0,
        loadLimit);
    flagActiveNot.value =
        dealerCustomers.where((element) => element.flagActive == "0").length;
    flagActive.value = dealerCustomers.length - flagActiveNot.value;
    return true;
  }

  Rx<String> dealerCode =
      (UserSessionController.instance().userInfo?.user?.dealerCode ?? "").obs;

  String userByDealerDefault =
      "${UserSessionController.instance().userInfo?.user?.userCode} - ${UserSessionController.instance().userInfo?.user?.userName}";

  Rx<UserByDealerData> userByDealer = UserByDealerData(
          userCode: UserSessionController.instance().userInfo?.user?.userCode)
      .obs;
  Rx<CustomerTypeData> cusType = CustomerTypeData().obs;
  Rx<CustomerGroupTypeData> cusGroup = CustomerGroupTypeData().obs;
  Rx<MstProvinceData> province = MstProvinceData().obs;
  Rx<String> fromDate = AppConfig.instance()
      .dateFormat
      .format(DateTime(DateTime.now().year, DateTime.now().month, 1))
      .obs;
  Rx<String> toDate = "".obs;
  Rx<String> cusName = "".obs;
  Rx<String> phone = "".obs;
  Rx<String> phoneNoContract = "".obs;

  /// -------------------------------- event bottom sheets ------------------//

  Future<void> editCustomer(int index) async {
    var result = await CreateCustomerScreen.showForEdit(
        CreateCustomerControllerMode.update,
        dealerCustomers[index].customerCode ?? "");
    if (result == true) {
      MainGet.successAlert(message: "Cập nhật khách hàng thành công.");
      reload();
    }
  }

  void deleteCustomer(int index) async {
    var result = await Get.dialog(AlertDialog(
      title: const Text("Thông báo"),
      content: Text(
          "Bạn có chắc chắn muốn xóa khách hàng ${dealerCustomers[index].customerCode ?? ""}?"),
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
        var future = IDealerApiService.deleteCustomer(
            dealerCustomers[index].customerCode ?? "");
        var result = await MainGet.showHudProgress(future);
        if (result == true) {
          reload();
          MainGet.successAlert(message: "Xóa khách hàng thành công");
          // Get.back(result: true);
        } else {
          await MainGet.errorDialog(error: "Xóa thất bại");
        }
      } catch (error) {
        await MainGet.errorDialog(error: "Xóa thất bại");
      }
      return;
    }
  }

  ///--------------------------- event item --------------------------/
  ///
  void itemClick(int index) async {
    var result = await CustomerManageBottomSheet.show();
    if (result == null) {
      return;
    }
    switch (result) {
      case CustomerSelect.edit:
        editCustomer(index);
        break;
      case CustomerSelect.detail:
        // detailCustomer(index);
        break;
      case CustomerSelect.delete:
        deleteCustomer(index);
        break;
    }
  }
}
