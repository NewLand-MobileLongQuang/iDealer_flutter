import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/10_app_commons/base_controller/base_controller.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';
import 'package:idealer/11_apis/core/models/code_name.dart';
import 'package:idealer/11_apis/core/models/customer_source_data.dart';
import 'package:idealer/11_apis/core/models/dealer_customer_contact_search_data.dart';
import 'package:idealer/11_apis/core/models/marketing_strategy_data.dart';
import 'package:idealer/11_apis/core/models/save_sp_sales_process_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';
import 'package:idealer/12_modules/opportunity/opportunity_create/model/opportunity_model.dart';
import 'package:idealer/12_modules/opportunity/opportunity_create/service/opportunity_service.dart';

enum OpportunityCreateMode { create, update, detail }

class OpportunityCreateController extends BaseController<bool> {
  late OpportunityModel opportunityModel;
  late OpportunityService service;
  late OpportunityCreateMode mode;
  String salesId = "";
  SaveSpSaleProcessData spSaleProcessDataDtl = SaveSpSaleProcessData();
  VoidCallback onState = () {};
  @override
  Future<bool> load(int loadLimit) async {
    // TODO: implement load
    service = await OpportunityService.instance();
    opportunityModel = await service.getOpportunityModel();

    if (mode == OpportunityCreateMode.create) {
      opportunityModel.saleId.value = await IDealerApiService.getSaleId();
    }
    if (mode != OpportunityCreateMode.create) {
      var result = await IDealerApiService.getSpSalesProcess(salesId);
      if (result.isNotEmpty) {
        spSaleProcessDataDtl = result[0];
        initData();
      }
    }
    return true;
  }

  List<CodeName> statusLst = [
    CodeName("THAMKHAO", "Tham khảo"),
    CodeName("QUANTAM", "Quan tâm"),
    CodeName("DAMPHAN", "Đàm phán"),
    CodeName("LAITHU", "Lái thử"),
  ];

  List<CodeName> carModelLst = [
    CodeName("SUV", "Dòng SUV"),
    CodeName("SEDAN", "Dòng SEDAN"),
    CodeName("THETHAO", "Dòng THETHAO"),
    CodeName("HATCHBACK", "Dòng HATCHBACK"),
    CodeName("COMMERCIAL", "Dòng COMMERCIAL"),
  ];

  void initData() {
    opportunityModel.saleId.value = spSaleProcessDataDtl.salesId ?? "";
    opportunityModel.createDate.value = spSaleProcessDataDtl.createDTime ?? "";
    opportunityModel.status.value = CodeName(
        spSaleProcessDataDtl.spStatus ?? "",
        spSaleProcessDataDtl.spStatus ?? "");
    opportunityModel.carMode.value = CodeName(
        spSaleProcessDataDtl.carModelType ?? "",
        spSaleProcessDataDtl.carModelType ?? "");
    opportunityModel.budgetPlan.value =
        double.tryParse(spSaleProcessDataDtl.budgetVal ?? "") ?? 0;
    opportunityModel.marketingData.value = MarketingStrategyData(
      campaignCode: spSaleProcessDataDtl.campaignCode,
      campaignName: spSaleProcessDataDtl.campaignCode,
    );
    opportunityModel.cusSourceData.value = CustomerSourceData(
      customerBaseCode: spSaleProcessDataDtl.customerBaseCode,
      customerBaseName: spSaleProcessDataDtl.customerBaseName,
    );
    opportunityModel.planSignContractDate.value =
        spSaleProcessDataDtl.contractExpectedDate ?? "";
    opportunityModel.remark.value = spSaleProcessDataDtl.remark ?? "";
    opportunityModel.sPSalesProcessDtls =
        spSaleProcessDataDtl.listSalesProcessDtl ?? [];
    opportunityModel.cusSourceData.value.customerBaseCode =
        spSaleProcessDataDtl.customerBaseCode ?? "";
    opportunityModel.dealerCusContract.value = DealerCustomerContactSearchData(
      customerCode: spSaleProcessDataDtl.customerCode ?? "",
      dealerCode: spSaleProcessDataDtl.dealerCode ?? "",
      address: spSaleProcessDataDtl.address ?? "",
      idCardNo: spSaleProcessDataDtl.idCardNo ?? "",
      idCardDate: spSaleProcessDataDtl.idCardDate ?? "",
      idCardPlace: spSaleProcessDataDtl.idCardPlace ?? "",
      bankAccountNo: spSaleProcessDataDtl.bankAccountNoCustomer ?? "",
      bankName: spSaleProcessDataDtl.bankName ?? "",
      representPosition: spSaleProcessDataDtl.representPosition ?? "",
      customerTypeCode: spSaleProcessDataDtl.customerTypeName ?? "",
      fullName: spSaleProcessDataDtl.fullName ?? "",
      dateOfBirth: spSaleProcessDataDtl.dateOfBirth ?? "",
      phoneNo: spSaleProcessDataDtl.phoneNo ?? "",
      email: spSaleProcessDataDtl.email ?? "",
      driverLicenseNo: spSaleProcessDataDtl.driverLicenseNo ?? "",
      customerContactCode: spSaleProcessDataDtl.customerContactCode ?? "",
      customerContactName: spSaleProcessDataDtl.customerContactName ?? "",
      customerContactPhoneNo: spSaleProcessDataDtl.customerContactPhoneNo ?? "",
    );

    onState.call();
  }

  void setContactPlanDateTime(BuildContext context) async {
    var newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (newDate == null) return;
    opportunityModel.planSignContractDate.value =
        AppConfig.instance().dateFormat.format(newDate);
  }

  void saveOpportunityClick() async {
    if (opportunityModel.status.value.code == "") {
      MainGet.errorDialog(error: "Chưa chọn trạng thái !!");
      return;
    }
    // if (opportunityModel.carMode.value.code == "") {
    //   MainGet.errorDialog(error:"Chưa chọn dòng xe quan tâm !!");
    //   return;
    // }

    log("TAG : opportunityModel.dealerCusContract : ${opportunityModel.dealerCusContract.value.customerCode}");

    // mã khách hàng
    var customerCode =  opportunityModel.dealerCusContract.value.customerCode;
    if (customerCode == "" || customerCode == null) {
      MainGet.errorDialog(error:"Chưa chọn mã khách hàng !!");
      return;
    }
    // tên khách hàng
    var fullName = opportunityModel.dealerCusContract.value.fullName;
    if (fullName == "" || fullName == null) {
      MainGet.errorDialog(error:"Chưa chọn tên khách hàng !!");
      return;
    }
    var phoneNo = opportunityModel.dealerCusContract.value.phoneNo;
    if (phoneNo == "" || phoneNo == null) {
      MainGet.errorDialog(error:"Chưa chọn điện thoại khách hàng !!");
      return;
    }

    var customerBaseCode = opportunityModel.cusSourceData.value.customerBaseCode;
    if (customerBaseCode == "" || customerBaseCode == null) {
      MainGet.errorDialog(error:"Chưa chọn nguồn khách hàng !!");
      return;
    }

    SaveSpSaleProcessData sPSalesProcess = SaveSpSaleProcessData();
    sPSalesProcess.campaignCode =
        opportunityModel.marketingData.value.campaignCode;
    sPSalesProcess.budgetVal = opportunityModel.budgetPlan.value;
    sPSalesProcess.carModelType = opportunityModel.carMode.value.code;
    sPSalesProcess.contractExpectedDate =
        opportunityModel.planSignContractDate.value;

    sPSalesProcess.remark = opportunityModel.remark.value;
    sPSalesProcess.createDTime = opportunityModel.createDate.value;
    sPSalesProcess.salesId = opportunityModel.saleId.value;
    sPSalesProcess.userCodeOwner =
        UserSessionController.instance().userInfo?.user?.userCode;
    sPSalesProcess.createBy = UserSessionController.instance().userInfo?.username;
    sPSalesProcess.customerCode =
        opportunityModel.dealerCusContract.value.customerCode;
    sPSalesProcess.dealerCode =
        opportunityModel.dealerCusContract.value.dealerCode;
    sPSalesProcess.address = opportunityModel.dealerCusContract.value.address;
    sPSalesProcess.idCardNo = opportunityModel.dealerCusContract.value.idCardNo;
    sPSalesProcess.idCardDate =
        opportunityModel.dealerCusContract.value.idCardDate;
    sPSalesProcess.idCardPlace =
        opportunityModel.dealerCusContract.value.idCardPlace;
    sPSalesProcess.bankAccountNoCustomer =
        opportunityModel.dealerCusContract.value.bankAccountNo;
    sPSalesProcess.representPosition =
        opportunityModel.dealerCusContract.value.representPosition;
    sPSalesProcess.bankName = opportunityModel.dealerCusContract.value.bankName;
    sPSalesProcess.customerTypeName =
        opportunityModel.dealerCusContract.value.customerTypeCode;
    sPSalesProcess.fullName = opportunityModel.dealerCusContract.value.fullName;
    sPSalesProcess.dateOfBirth =
        opportunityModel.dealerCusContract.value.dateOfBirth;
    sPSalesProcess.phoneNo = opportunityModel.dealerCusContract.value.phoneNo;
    sPSalesProcess.email = opportunityModel.dealerCusContract.value.email;
    sPSalesProcess.driverLicenseNo =
        opportunityModel.dealerCusContract.value.driverLicenseNo;
    sPSalesProcess.customerContactName =
        opportunityModel.dealerCusContract.value.customerContactName;
    sPSalesProcess.customerContactCode =
        opportunityModel.dealerCusContract.value.customerContactCode;
    sPSalesProcess.customerContactPhoneNo =
        opportunityModel.dealerCusContract.value.customerContactPhoneNo;

    sPSalesProcess.customerBaseCode =
        opportunityModel.cusSourceData.value.customerBaseCode;
    sPSalesProcess.customerBaseName =
        opportunityModel.cusSourceData.value.customerBaseName;
    sPSalesProcess.spStatus = opportunityModel.status.value.code;
    sPSalesProcess.listSalesProcessDtl = opportunityModel.sPSalesProcessDtls;
    print("json : ${jsonEncode(sPSalesProcess)}");
    if (mode == OpportunityCreateMode.create) {
      try {
        var future = IDealerApiService.saveSPSalesProcessCreate(sPSalesProcess);
        var result = await MainGet.showHudProgress(future);
        if (result == true) {
          MainGet.successAlert(message: "Lưu cơ hội thành công !!");
          clearData();
        } else {
          MainGet.errorDialog(error:"Lưu thất bại !!");
        }
      } catch (error) {
        MainGet.errorDialog(error:"Lưu thất bại !!");
      }
    }
    if (mode == OpportunityCreateMode.update) {
      try {
        var future = IDealerApiService.saveSPSalesProcessUpdate(sPSalesProcess);
        var result = await MainGet.showHudProgress(future);
        if (result == true) {
          // MainGet.showToast("Sửa cơ hội thành công");
          Get.back(result: true);
        } else {
          MainGet.errorDialog(error:"Lưu thất bại");
        }
      } catch (error) {
        MainGet.errorDialog(error:"Lưu thất bại");
      }
    }
  }

  void clearData() {
    opportunityModel.clearData();
    reload();
    onState.call();
  }
}
