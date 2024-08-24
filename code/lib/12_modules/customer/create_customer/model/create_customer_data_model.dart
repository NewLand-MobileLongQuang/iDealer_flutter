import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/10_app_commons/utils/file_image_picker/api/models/attachment.dart';

class CreateCustomerDataModel {
  CreateCustomerDataModel() {}

  Rx<String> customerCode = "".obs;
  Rx<String> customerTypeCode = "".obs;
  Rx<String> customerTypeName = "".obs;
  Rx<String> customerGroupTypeCode = "".obs;
  Rx<String> customerGroupTypeName = "".obs;
  Rx<String> customerName = "".obs;
  Rx<String> customerGenderName = "".obs;
  Rx<String> customerGenderCode = "".obs;
  Rx<String> customerPhoneNo = "".obs;
  Rx<String> customerProvinceCode = "".obs;
  Rx<String> customerProvinceName = "".obs;
  Rx<String> customerDistrictName = "".obs;
  Rx<String> customerDistrictCode = "".obs;
  Rx<String> customerAddress = "".obs;
  Rx<String> customerEmail = "".obs;
  Rx<String> customerTimeSendSMS = "".obs;

  Rx<String> dateOfBirth = "".obs;
  Rx<String> cardType = "".obs;
  Rx<String> cardTypeID = "".obs;
  Rx<String> cardTypeNumber = "".obs;
  Rx<String> cardTypeDate = "".obs;
  Rx<String> cardTypePlace = "".obs;
  Rx<String> driverLicenseNo = "".obs;
  Rx<String> driverLicenseNoExpiredDate = "".obs;
  Rx<String> bankAccountNo = "".obs;
  Rx<String> bankName = "".obs;
  Rx<String> representName = "".obs;
  Rx<String> representPosition = "".obs;
  Rx<String> remark = "".obs;

  RxList<Attachment> attachImages = <Attachment>[].obs;

  Rx<String> contactCode = "".obs;
  Rx<String> contactName = "".obs;
  Rx<String> contactPhoneNo = "".obs;
  Rx<String> contactProvinceCode = "".obs;
  Rx<String> contactProvinceName = "".obs;

  Rx<String> zaloID = "".obs;
  Rx<String> zaloName = "".obs;
  Rx<String> zaloAvatar = "".obs;
  Rx<bool> flagActive = false.obs;

  Future<void> setCustomerType(String code, String name) async {
    customerTypeCode.value = code;
    customerTypeName.value = name;
  }

  Future<void> setCustomerGroupType(String code, String name) async {
    customerGroupTypeCode.value = code;
    customerGroupTypeName.value = name;
  }

  Future<void> setCustomerGender(String genderCode, String genderName) async {
    customerGenderCode.value = genderCode;
    customerGenderName.value = genderName;
  }

  Future<void> setProvince(String code, String name) async {
    customerProvinceCode.value = code;
    customerProvinceName.value = name;
  }

  Future<void> setDistrict(String code, String name) async {
    customerDistrictCode.value = code;
    customerDistrictName.value = name;
  }

  Future<void> setCardType(String code, String name) async {
    cardTypeID.value = code;
    cardType.value = name;
  }

  Future<void> setZalo(String code, String name, String avatar) async {
    zaloID.value = code;
    zaloName.value = name;
    zaloAvatar.value = avatar;
  }

  Future<void> setFlagActive(bool value) async {
    flagActive.value = value;
  }

  Future<void> clearData() async {
    customerCode.value = "";
    customerTypeCode.value = "";
    customerTypeName.value = "";
    customerGroupTypeCode.value = "";
    customerGroupTypeName.value = "";
    customerName.value = "";
    customerGenderName.value = "";
    customerGenderCode.value = "";
    customerPhoneNo.value = "";
    customerProvinceCode.value = "";
    customerProvinceName.value = "";
    customerDistrictName.value = "";
    customerDistrictCode.value = "";
    customerAddress.value = "";
    customerEmail.value = "";
    customerTimeSendSMS.value = "";

    dateOfBirth.value = "";
    cardType.value = "";
    cardTypeID.value = "";
    cardTypeNumber.value = "";
    cardTypeDate.value = "";
    cardTypePlace.value = "";
    driverLicenseNo.value = "";
    driverLicenseNoExpiredDate.value = "";
    bankAccountNo.value = "";
    bankName.value = "";
    representName.value = "";
    representPosition.value = "";
    remark.value = "";

    attachImages.value = [];

    contactCode.value = "";
    contactName.value = "";
    contactPhoneNo.value = "";
    contactProvinceCode.value = "";
    contactProvinceName.value = "";

    zaloID.value = "";
    zaloName.value = "";
    zaloAvatar.value = "";
    flagActive.value = false;
  }
}
