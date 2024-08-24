import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/04_core_modules/user_session/api/models/user_info.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/10_app_commons/base_controller/simple_controller.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';
import 'package:idealer/10_app_commons/utils/file_image_picker/api/file_image_picker_service.dart';
import 'package:idealer/10_app_commons/utils/file_image_picker/api/models/attachment.dart';
import 'package:idealer/10_app_commons/utils/file_image_picker/file_image_picker_util.dart';
import 'package:idealer/10_app_commons/utils/validators/data_validator_util.dart';
import 'package:idealer/11_apis/core/models/code_name.dart';
import 'package:idealer/11_apis/core/models/customer_group_type_data.dart';
import 'package:idealer/11_apis/core/models/customer_type_data.dart';
import 'package:idealer/11_apis/core/models/mst_card_type_data.dart';
import 'package:idealer/11_apis/core/models/mst_district_data.dart';
import 'package:idealer/11_apis/core/models/mst_province_data.dart';
import 'package:idealer/11_apis/core/models/save_dealer_customer_create_data.dart';
import 'package:idealer/11_apis/core/models/zalo_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';
import 'package:idealer/12_modules/customer/create_customer/model/create_customer_data_model.dart';
import 'package:idealer/12_modules/customer/create_customer/service/create_customer_service.dart';

enum CreateCustomerControllerMode { create, update }

class CreateCustomerController extends SimpleController {
  late CreateCustomerService service;
  late CreateCustomerDataModel dataModel;

  CreateCustomerControllerMode? mode;
  SaveDealerCustomerData customerInfo = SaveDealerCustomerData();
  String? customerCode;

  VoidCallback onState = () {};
  VoidCallback onFillData = () {};

  List<CodeName> lstGender = [];

  late List<CustomerTypeData> lstCustomerType = [];
  late List<CustomerGroupTypeData> lstCustomerGroupType = [];
  late List<MstProvinceData> lstProvince = [];
  late List<MstDistrictData> lstDistrict = [];
  late List<MstCardTypeData> lstCardType = [];
  late List<ZaloData> lstZaloData = [];

  @override
  Future<void> simpleLoad() async {
    service = await CreateCustomerService.instance();
    dataModel = await service.getCustomerCreateDataModel();

    lstGender = [];
    lstGender.add(CodeName("M", "Nam"));
    lstGender.add(CodeName("F", "Nữ"));
    lstGender.add(CodeName("O", "Khác"));

    if (mode == CreateCustomerControllerMode.create) {
      try {
        // lấy mã khách hàng từ api
        var re = await IDealerApiService.getCustomerNoRequest();
        dataModel.customerCode.value = re.customerNo ?? "";
      } catch (e) {
        MainGet.showToast("Có lỗi xảy ra!");
        return;
      }
    } else if (mode == CreateCustomerControllerMode.update) {
      try {
        var result =
            await IDealerApiService.getDealerCustomerByCode(customerCode ?? "");
        if (result.isNotEmpty) {
          customerInfo = result[0];
          // await MainGet.showHudProgress(initData());
          await initData();
        }
      } catch (e) {
        log("TAG : update customer : ${e.toString()} ");
        MainGet.showToast("${e.toString()}");
        return;
      }
    }
  }

  Future<void> initData() async {
    lstCustomerType = await IDealerApiService.getCustomerType();
    if (lstCustomerType.isEmpty) {
      throw "Dữ liệu danh sách Loại khách hàng không hợp lệ";
    }

    lstCustomerGroupType = await IDealerApiService.getCustomerGroupType();
    if (lstCustomerGroupType.isEmpty) {
      // throw "Dữ liệu danh sách Nhóm khách hàng không hợp lệ";
      MainGet.showToast("Dữ liệu danh sách Nhóm khách hàng không hợp lệ");
    }
    lstProvince = await IDealerApiService.getMstProvince();
    if (lstProvince.isEmpty) {
      throw "Dữ liệu danh sách Tỉnh/Thành phố không hợp lệ";
    }
    lstDistrict = await IDealerApiService.getMstDistrict(provinceCode: "");
    if (lstDistrict.isEmpty) {
      throw "Dữ liệu danh sách Quận/Huyện không hợp lệ";
    }
    lstCardType = await IDealerApiService.getMstCardType();
    if (lstCardType.isEmpty) {
      throw "Dữ liệu danh sách Loại giấy tờ tùy thân không hợp lệ";
    }

    if (customerInfo.zaloID != null && customerInfo.zaloID != "") {
      lstZaloData = await IDealerApiService.getZalos(customerInfo.zaloID ?? "");
      if (lstZaloData.isEmpty) {
        throw "Dữ liệu danh sách Loại giấy tờ tùy thân không hợp lệ";
      }
    }

    dataModel.customerCode.value = customerInfo.customerCode ?? "";
    // saveCustomer.dealerCode = UserSession.instance().userInfo?.dealerCode;
    dataModel.customerTypeCode.value = customerInfo.customerTypeCode ?? "";
    dataModel.customerGroupTypeCode.value = customerInfo.customerGrpType ?? "";
    dataModel.customerName.value = customerInfo.fullName ?? "";
    dataModel.customerGenderCode.value = customerInfo.gender ?? "";
    // saveCustomer.userOwnerPhoneNo = UserSession.instance().userInfo?.;
    dataModel.customerPhoneNo.value = customerInfo.phoneNo ?? "";
    dataModel.customerProvinceCode.value = customerInfo.provinceCode ?? "";
    dataModel.customerDistrictCode.value = customerInfo.districtCode ?? "";
    dataModel.customerAddress.value = customerInfo.address ?? "";
    dataModel.customerEmail.value = customerInfo.email ?? "";
    dataModel.customerTimeSendSMS.value = customerInfo.effDTimeStart ?? "";
    dataModel.zaloID.value = customerInfo.zaloID ?? "";
    if (lstZaloData.isNotEmpty) {
      dataModel.zaloName.value = lstZaloData[0].displayName ?? "";
    }

    dataModel.flagActive.value = customerInfo.flagActive == "1";

    dataModel.attachImages.clear();
    if (customerInfo.filePath != null && customerInfo.filePath != "") {
      dataModel.attachImages.add(Attachment(
          url: customerInfo.filePath ?? "",
          fileName: customerInfo.fileName ?? "",
          fileSize: 20));
      update(dataModel.attachImages, true);
    }

    dataModel.dateOfBirth.value = customerInfo.dateOfBirth ?? "";
    dataModel.cardTypeID.value = customerInfo.idCardType ?? "";
    dataModel.cardTypeNumber.value = customerInfo.idCardNo ?? "";
    dataModel.cardTypeDate.value = customerInfo.idCardDate ?? "";
    dataModel.cardTypePlace.value = customerInfo.idCardPlace ?? "";
    dataModel.driverLicenseNo.value = customerInfo.driverLicenseNo ?? "";

    dataModel.driverLicenseNoExpiredDate.value =
        customerInfo.drvLicenseNoExpDate ?? "";
    dataModel.bankName.value = customerInfo.bankName ?? "";
    dataModel.bankAccountNo.value = customerInfo.bankAccountNo ?? "";
    dataModel.representName.value = customerInfo.representName ?? "";
    dataModel.representPosition.value = customerInfo.representPosition ?? "";
    dataModel.remark.value = customerInfo.remark ?? "";

    if (customerInfo.listDlsDealerCustomerContact != null &&
        customerInfo.listDlsDealerCustomerContact!.isNotEmpty) {
      dataModel.contactCode.value =
          customerInfo.listDlsDealerCustomerContact![0].customerContactCode ??
              "";
      dataModel.customerCode.value =
          customerInfo.listDlsDealerCustomerContact![0].customerCode ?? "";
      dataModel.contactPhoneNo.value =
          customerInfo.listDlsDealerCustomerContact![0].phoneNo ?? "";
      dataModel.contactName.value =
          customerInfo.listDlsDealerCustomerContact![0].fullName ?? "";
      dataModel.contactProvinceCode.value =
          customerInfo.listDlsDealerCustomerContact![0].provinceCode ?? "";
      dataModel.contactProvinceName.value =
          customerInfo.listDlsDealerCustomerContact![0].provinceName ?? "";
    }

    onFillData.call();
  }

  // chọn loại khách hàng
  Future<void> setCustomerType(String code, String name) async {
    dataModel.setCustomerType(code, name);
  }

  // chọn nhóm khách hàng
  Future<void> setCustomerGroupType(String code, String name) async {
    dataModel.setCustomerGroupType(code, name);
  }

  // chọn tỉnh thành phố
  Future<void> setProvince(String code, String name) async {
    dataModel.setProvince(code, name);
  }

  // chọn quận huyện
  Future<void> setDistrict(String code, String name) async {
    dataModel.setDistrict(code, name);
  }

  // chọn giới tính
  Future<void> setCustomerGender(String code, String name) async {
    dataModel.setCustomerGender(code, name);
  }

  // chọn giới tính
  Future<void> setCardType(String code, String name) async {
    dataModel.setCardType(code, name);
  }

  // chọn zalo
  Future<void> setZalo(String code, String name, String ava) async {
    dataModel.setZalo(code, name, ava);
  }

  // chọn kích hoạt
  Future<void> setFlagActive(bool value) async {
    dataModel.setFlagActive(value);
  }

  void addImage(BuildContext context) async {
    var filePicked = await FileImagePickerUtil.pick(context,
        fromFile: false, fromCamera: true, fromGallery: true);
    if (filePicked != null) {
      print("Create Customer Attach: ${filePicked.fileName}\n");
      print("Create Customer Attach: ${filePicked.fileType}\n");
      print(await filePicked.getBase64());
      String? base64 = await filePicked.getBase64();
      var result = await FileImagePickerService.uploadFile(
          filePicked.fileName, base64 ?? "");
      if (result != null) {
        print("Create Customer url ${result.url}");
        dataModel.attachImages.clear();
        dataModel.attachImages.add(result);
        update(dataModel.attachImages, true);
      }
    }
  }

  void removeImage(int index) {
    dataModel.attachImages.removeAt(index);
    update(dataModel.attachImages, true);
  }

  Future<bool>? createCustomer() async {
    if (dataModel.customerTypeCode.value == "") {
      MainGet.showToast("Bạn chưa chọn Loại khách hàng!");
      return false;
    } else if (dataModel.customerName.value == "") {
      MainGet.showToast("Bạn chưa nhập Tên khách hàng!");
      return false;
    } else if (dataModel.customerGenderCode.value == "") {
      MainGet.showToast("Bạn chưa chọn Giới tính!");
      return false;
    } else if (dataModel.customerPhoneNo.value == "") {
      MainGet.showToast("Bạn chưa nhập Số điện thoại!");
      return false;
    } else if (dataModel.customerProvinceCode.value == "") {
      MainGet.showToast("Bạn chưa chọn Tỉnh/Thành phố!");
      return false;
    } else if (dataModel.customerDistrictCode.value == "") {
      MainGet.showToast("Bạn chưa chọn Quận/Huyện!");
      return false;
    }
    // else if (dataModel.customerTimeSendSMS.value == "") {
    //   MainGet.showToast("Bạn chưa chọn Thời gian gửi SMS!");
    //   return false;
    // }

    if (!DataValidatorUtil.isValidPhoneNumber(
        dataModel.customerPhoneNo.value)) {
      MainGet.showToast("Số điện thoại không hợp lệ!");
      return false;
    }

    try {
      var future = IDealerApiService.checkPhoneNo(
        dataModel.customerCode.value,
        dataModel.customerPhoneNo.value,
      );
      var result = await MainGet.showHudProgress(future);
      if (result.isSuccess()) {
        // dataModel.clearData();
        if (result.checkPhoneNoSameOwner == true) {
          MainGet.successAlert(
              message:
                  "Nhân viên ${UserSessionController.instance().userInfo?.user?.userCode} đã tạo khách hàng với số điện thoại ${dataModel.customerPhoneNo.value}! \r\nKhông thể tạo mới khách hàng với SĐT này!");
          return false;
        } else if (result.checkDealerCustomerPhoneNo == true) {
          var re = await MainGet.confirmAlert(
              message:
                  "Số điện thoại: ${dataModel.customerPhoneNo.value} đã tồn tại trong hệ thống. Bạn có muốn tiếp tục lưu?");
          if (re == true) {
            return await saveCustomerToServer();
          }
        } else {
          return await saveCustomerToServer();
          // return false;
        }
      }
    } catch (error) {
      MainGet.showToast("Kiểm tra thất bại");
      return false;
    }
    return false;
  }

  Future<bool> saveCustomerToServer() async {
    SaveDealerCustomerData saveCustomer = SaveDealerCustomerData();

    if (dataModel.attachImages.isNotEmpty) {
      saveCustomer.fileName = dataModel.attachImages[0].fileName; // tên ảnh
      saveCustomer.filePath = dataModel.attachImages[0].url; // link ảnh
    }

    saveCustomer.customerCode = dataModel.customerCode.value;
    saveCustomer.dealerCode =
        UserSessionController.instance().userInfo?.user?.dealerCode;
    saveCustomer.customerTypeCode = dataModel.customerTypeCode.value;
    saveCustomer.customerGrpType = dataModel.customerGroupTypeCode.value;
    saveCustomer.fullName = dataModel.customerName.value;
    saveCustomer.fullNameEn = dataModel.customerName.value;
    saveCustomer.gender = dataModel.customerGenderCode.value;
    // saveCustomer.userOwnerPhoneNo = UserSession.instance().userInfo?.;
    saveCustomer.phoneNo = dataModel.customerPhoneNo.value;
    saveCustomer.provinceCode = dataModel.customerProvinceCode.value;
    saveCustomer.districtCode = dataModel.customerDistrictCode.value;
    saveCustomer.address = dataModel.customerAddress.value;
    saveCustomer.email = dataModel.customerEmail.value;
    saveCustomer.flagSendSms =
        UserSessionController.instance().userInfo?.flagSendSms;
    saveCustomer.effDTimeStart = dataModel.customerTimeSendSMS.value;

    saveCustomer.flagiCic = "0";
    // "CheckInforStatus" = "1"
    if (mode == CreateCustomerControllerMode.create) {
      saveCustomer.flagActive =
          UserSessionController.instance().userInfo?.user?.flagActive;
    } else if (mode == CreateCustomerControllerMode.update) {
      saveCustomer.flagActive = dataModel.flagActive.value ? "1" : "0";
    }
    saveCustomer.zaloID = dataModel.zaloID.value;
    saveCustomer.dateOfBirth = dataModel.dateOfBirth.value;
    saveCustomer.idCardType = dataModel.cardTypeID.value;
    saveCustomer.idCardNo = dataModel.cardTypeNumber.value;
    saveCustomer.idCardDate = dataModel.cardTypeDate.value;
    saveCustomer.idCardPlace = dataModel.cardTypePlace.value;
    saveCustomer.driverLicenseNo = dataModel.driverLicenseNo.value;
    saveCustomer.drvLicenseNoExpDate =
        dataModel.driverLicenseNoExpiredDate.value;
    saveCustomer.bankName = dataModel.bankName.value;
    saveCustomer.bankAccountNo = dataModel.bankAccountNo.value;
    saveCustomer.representName = dataModel.representName.value;
    saveCustomer.representPosition = dataModel.representPosition.value;
    saveCustomer.remark = dataModel.remark.value;

    DealerCustomerContact dealerCustomerContact = DealerCustomerContact();
    dealerCustomerContact.customerContactCode = dataModel.contactCode.value;
    dealerCustomerContact.customerCode = dataModel.customerCode.value;
    dealerCustomerContact.phoneNo = dataModel.contactPhoneNo.value;
    dealerCustomerContact.fullName = dataModel.contactName.value;
    dealerCustomerContact.provinceCode = dataModel.contactProvinceCode.value;
    dealerCustomerContact.provinceName = dataModel.contactProvinceName.value;
    saveCustomer.listDlsDealerCustomerContact?.add(dealerCustomerContact);

    if (mode == CreateCustomerControllerMode.update) {
      try {
        print("Save Customer UPDATE Json: ${saveCustomer.toRawJson()}\n");
        var future = IDealerApiService.saveDealerCustomerUpdate(saveCustomer);
        var result = await MainGet.showHudProgress(future);
        if (result == true) {
          // dataModel.clearData();
          // reload();
          // onFillData.call();
          // MainGet.showToast("Cập nhật thành công");
          return true;
        }
      } catch (error) {
        MainGet.errorDialog(error: "Cập nhật thất bại");
        return false;
      }
    } else if (mode == CreateCustomerControllerMode.create) {
      try {
        print("Save Customer CreateJson: ${saveCustomer.toRawJson()}");
        var future = IDealerApiService.saveDealerCustomerCreate(saveCustomer);
        var result = await MainGet.showHudProgress(future);
        if (result == true) {
          // dataModel.clearData();
          reload();
          onState.call();
          MainGet.successAlert(message: "Tạo khách hàng thành công.");
          return true;
        }else{
          MainGet.errorDialog(error: "Lưu thất bại");
          return false;
        }
      } catch (error) {
        MainGet.errorDialog(error: "Lưu thất bại");
        return false;
      }
    }
    return true;
  }

  Future<void> updateCustomerPhoneNo() async {
    if (dataModel.customerTypeCode.value == "") {
      MainGet.showToast("Bạn chưa chọn Loại khách hàng!");
      return;
    } else if (dataModel.customerName.value == "") {
      MainGet.showToast("Bạn chưa nhập Tên khách hàng!");
      return;
    } else if (dataModel.customerGenderCode.value == "") {
      MainGet.showToast("Bạn chưa chọn Giới tính!");
      return;
    } else if (dataModel.customerPhoneNo.value == "") {
      MainGet.showToast("Bạn chưa nhập Số điện thoại!");
      return;
    } else if (dataModel.customerProvinceCode.value == "") {
      MainGet.showToast("Bạn chưa chọn Tỉnh/Thành phố!");
      return;
    } else if (dataModel.customerDistrictCode.value == "") {
      MainGet.showToast("Bạn chưa chọn Quận/Huyện!");
      return;
    }
    // else if (dataModel.customerTimeSendSMS.value == "") {
    //   MainGet.showToast("Bạn chưa chọn Thời gian gửi SMS!");
    //   return;
    // }

    if (!DataValidatorUtil.isValidPhoneNumber(
        dataModel.customerPhoneNo.value)) {
      MainGet.showToast("Số điện thoại không hợp lệ!");
      return;
    }

    try {
      var future = IDealerApiService.checkPhoneNo(
        dataModel.customerCode.value,
        dataModel.customerPhoneNo.value,
      );
      var result = await MainGet.showHudProgress(future);
      if (result.isSuccess()) {
        // dataModel.clearData();
        if (result.checkPhoneNoSameOwner == true) {
          MainGet.successAlert(
              message:
                  "Nhân viên ${UserSessionController.instance().userInfo?.user?.userCode} đã tạo khách hàng với số điện thoại ${dataModel.customerPhoneNo.value}! \r\nKhông thể tạo mới khách hàng với SĐT này!");
          return;
        } else if (result.checkDealerCustomerPhoneNo == true) {
          var re = await MainGet.confirmAlert(
              message:
                  "Số điện thoại: ${dataModel.customerPhoneNo.value} đã tồn tại trong hệ thống. Bạn có muốn tiếp tục lưu?");
          if (re == true) {
            saveCustomerToServerForUpdatePhone();
          }
        } else {
          saveCustomerToServerForUpdatePhone();
          return;
        }
      }
    } catch (error) {
      MainGet.showToast("Kiểm tra thất bại");
      return;
    }
  }

  Future<bool> saveCustomerToServerForUpdatePhone() async {
    customerInfo.phoneNo = dataModel.customerPhoneNo.value;

    try {
      print("Save Customer UPDATE Json: ${customerInfo.toRawJson()}\n");
      var future = IDealerApiService.updatePhoneNo(customerInfo);
      var result = await MainGet.showHudProgress(future);
      if (result == true) {
        // dataModel.clearData();
        reload();
        onFillData.call();
        MainGet.successAlert(message: "Cập nhật Số điện thoại thành công.");
        return true;
      }
    } catch (error) {
      MainGet.showToast("Cập nhật Số điện thoại thất bại");
      return false;
    }
    return false;
  }
}
