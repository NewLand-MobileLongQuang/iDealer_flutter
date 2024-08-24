import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/base_controller/view/simple_data_view.dart';
import 'package:idealer/10_app_commons/custom/expanded_section/expanded_section.dart';
import 'package:idealer/10_app_commons/custom/name_circle_avatar.dart';
import 'package:idealer/10_app_commons/extension/date_time_extension.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';
import 'package:idealer/11_apis/core/models/code_name.dart';
import 'package:idealer/11_apis/core/models/customer_group_type_data.dart';
import 'package:idealer/11_apis/core/models/customer_type_data.dart';
import 'package:idealer/11_apis/core/models/mst_card_type_data.dart';
import 'package:idealer/11_apis/core/models/mst_district_data.dart';
import 'package:idealer/11_apis/core/models/mst_province_data.dart';
import 'package:idealer/11_apis/core/models/zalo_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';
import 'package:idealer/11_screens/app_bar_widget.dart';
import 'package:idealer/12_modules/customer/create_customer/controller/create_customer_controller.dart';
import 'package:idealer/12_modules/customer/create_customer/screen/component/choose_zalo_dialog.dart';
import 'package:idealer/12_modules/customer/create_customer/screen/component/custom_date_picker.dart';
import 'package:idealer/12_modules/customer/create_customer/screen/component/search_customer_screen.dart';
import 'package:idealer/12_modules/customer/create_customer/screen/component/text_title_widget.dart';
import 'package:idealer/12_modules/customer/create_customer/screen/component/view_image_dialog.dart';

class CreateCustomerScreen extends StatefulWidget {
  const CreateCustomerScreen(
      {Key? key, required this.mode, required this.customerCode})
      : super(key: key);

  final CreateCustomerControllerMode mode;
  final String customerCode;

  static Future<bool>? show(CreateCustomerControllerMode mode) async {
    return await Get.to(CreateCustomerScreen(
      mode: mode,
      customerCode: "",
    ));
  }

  static Future<bool?>? showForEdit(
      CreateCustomerControllerMode mode, String customerCode) async {
    return await Get.to(CreateCustomerScreen(
      mode: mode,
      customerCode: customerCode,
    ));
  }

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  late TextEditingController customerNameController;
  late TextEditingController phoneNoController;
  late TextEditingController addressController;
  late TextEditingController emailController;

  late TextEditingController gtttNoController; // số giấy tờ tùy thân
  late TextEditingController gtttPlaceController; // nơi cấp giấy tờ tùy thân
  late TextEditingController gplxController; // giấy phép lái xe
  late TextEditingController bankNoController;
  late TextEditingController bankNameController;
  late TextEditingController representativeController; // người đại diên
  late TextEditingController positionController; // chức vụ
  late TextEditingController remarkController;

  bool expanded = false;

  late CreateCustomerController controller;

  @override
  void initState() {
    controller = CreateCustomerController();
    controller.mode = widget.mode;
    controller.customerCode = widget.customerCode;
    controller.reload();

    customerNameController = TextEditingController();
    phoneNoController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();

    gtttNoController = TextEditingController();
    gtttPlaceController = TextEditingController();
    gplxController = TextEditingController();
    bankNoController = TextEditingController();
    bankNameController = TextEditingController();
    representativeController = TextEditingController();
    positionController = TextEditingController();
    remarkController = TextEditingController();

    controller.onState = () {
      customerNameController.clear();
      phoneNoController.clear();
      addressController.clear();
      emailController.clear();

      gtttNoController.clear();
      gtttPlaceController.clear();
      gplxController.clear();
      bankNoController.clear();
      bankNameController.clear();
      representativeController.clear();
      positionController.clear();
      remarkController.clear();
      setState(() {});
    };

    controller.onFillData = () {
      customerNameController =
          TextEditingController(text: controller.dataModel.customerName.value);
      phoneNoController = TextEditingController(
          text: controller.dataModel.customerPhoneNo.value);
      addressController = TextEditingController(
          text: controller.dataModel.customerAddress.value);
      emailController =
          TextEditingController(text: controller.dataModel.customerEmail.value);

      gtttNoController = TextEditingController(
          text: controller.dataModel.cardTypeNumber.value);
      gtttPlaceController =
          TextEditingController(text: controller.dataModel.cardTypePlace.value);
      gplxController = TextEditingController(
          text: controller.dataModel.driverLicenseNo.value);
      bankNoController =
          TextEditingController(text: controller.dataModel.bankAccountNo.value);
      bankNameController =
          TextEditingController(text: controller.dataModel.bankName.value);
      representativeController =
          TextEditingController(text: controller.dataModel.representName.value);
      positionController = TextEditingController(
          text: controller.dataModel.representPosition.value);
      remarkController =
          TextEditingController(text: controller.dataModel.remark.value);
      setState(() {});
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          text: (widget.mode == CreateCustomerControllerMode.update)
              ? "Cập nhật khách hàng"
              : "Tạo mới khách hàng"),
      body: SimpleDataView(
        controller: controller,
        builder: (_) {
          return Obx(
            () {
              var dataModel = controller.dataModel;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Thông tin khách hàng",
                            style: TextStyle(
                              fontSize: 19,
                              color: titleBlackColor,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: titleBlackColor,
                                size: 30,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  DateTime.now().longDateTimeString(),
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: titleBlackColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextTitleWidget(
                            title: "Mã khách hàng",
                            content: dataModel.customerCode.value,
                          ),
                          const TitleNStar(title: "Loại khách hàng"),
                          SizedBox(
                            height: 35,
                            child: DropdownSearch<CustomerTypeData>(
                              popupProps: const PopupProps.menu(
                                showSelectedItems: true,
                              ),
                              compareFn: CustomerTypeData.compareFn,
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.only(left: 5, top: 5)),
                              ),
                              clearButtonProps: const ClearButtonProps(
                                isVisible: true,
                              ),
                              onChanged: (value) {
                                controller.setCustomerType(
                                    value?.customerTypeCode ?? "",
                                    value?.customerTypeName ?? "");
                              },
                              asyncItems: (query) {
                                return IDealerApiService.getCustomerType();
                              },
                              itemAsString: (value) {
                                return value != null
                                    ? value.customerTypeName ?? ""
                                    : "";
                              },
                              selectedItem: controller.lstCustomerType
                                  .firstWhereOrNull((e) =>
                                      e.customerTypeCode ==
                                      controller
                                          .dataModel.customerTypeCode.value),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Nhóm khách hàng",
                            style:
                                TextStyle(color: titleBlackColor, fontSize: 16),
                          ),
                          SizedBox(
                            height: 35,
                            child: DropdownSearch<CustomerGroupTypeData>(
                              popupProps: const PopupProps.menu(
                                showSelectedItems: true,
                              ),
                              compareFn: CustomerGroupTypeData.compareFn,
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.only(left: 5, top: 5)),
                              ),
                              clearButtonProps: const ClearButtonProps(
                                isVisible: true,
                              ),
                              onChanged: (value) {
                                controller.setCustomerGroupType(
                                    value?.customerGrpType ?? "",
                                    value?.customerGrpTypeName ?? "");
                              },
                              asyncItems: (query) {
                                return IDealerApiService.getCustomerGroupType();
                              },
                              itemAsString: (value) {
                                return value != null
                                    ? value.customerGrpTypeName ?? ""
                                    : "";
                              },
                              selectedItem: controller.lstCustomerGroupType
                                  .firstWhereOrNull((e) =>
                                      e.customerGrpType ==
                                      controller.dataModel.customerGroupTypeCode
                                          .value),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const TitleNStar(title: "Tên khách hàng"),
                          TextField(
                            controller: customerNameController,
                            style: const TextStyle(fontSize: 16),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 5)),
                            onChanged: (va) {
                              dataModel.customerName.value = va;
                            },
                          ),
                          const SizedBox(height: 16),
                          const TitleNStar(title: "Giới tính"),
                          SizedBox(
                            height: 35,
                            child: DropdownSearch<CodeName>(
                              popupProps: const PopupProps.menu(
                                showSelectedItems: true,
                              ),
                              compareFn: CodeName.compareFn,
                              items: controller.lstGender,
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.only(left: 5, top: 5)),
                              ),
                              clearButtonProps: const ClearButtonProps(
                                isVisible: true,
                              ),
                              onChanged: (value) {
                                controller.setCustomerGender(
                                    value?.code ?? "", value?.name ?? "");
                              },
                              itemAsString: (item) {
                                return item.name;
                              },
                              selectedItem: controller.lstGender
                                  .firstWhereOrNull((e) =>
                                      e.code ==
                                      controller
                                          .dataModel.customerGenderCode.value),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const TitleNStar(title: "Số điện thoại"),
                          TextField(
                            controller: phoneNoController,
                            style: const TextStyle(fontSize: 16),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 5)),
                            onChanged: (va) {
                              dataModel.customerPhoneNo.value = va;
                            },
                          ),
                          const SizedBox(height: 16),
                          const TitleNStar(title: "Tỉnh/Thành phố"),
                          SizedBox(
                            height: 35,
                            child: DropdownSearch<MstProvinceData>(
                              popupProps: PopupProps.dialog(
                                  showSelectedItems: true,
                                  title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 8),
                                        const Text("Tỉnh/Thành phố"),
                                        const SizedBox(height: 8),
                                        Container(height: 1, color: Colors.grey)
                                      ]),
                                  showSearchBox: true),
                              compareFn: MstProvinceData.compareFn,
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.only(left: 5, top: 5)),
                              ),
                              clearButtonProps: const ClearButtonProps(
                                isVisible: true,
                              ),
                              onChanged: (value) {
                                controller.setProvince(
                                    value?.provinceCode ?? "",
                                    value?.provinceName ?? "");
                              },
                              asyncItems: (query) async {
                                var result =
                                    await IDealerApiService.getMstProvince();

                                return result.where((e) {
                                  var name = e.provinceName ?? "";
                                  return name
                                      .toLowerCase()
                                      .contains(query.toLowerCase());
                                }).toList();
                              },
                              itemAsString: (value) {
                                return value != null
                                    ? value.provinceName ?? ""
                                    : "";
                              },
                              selectedItem: controller.lstProvince
                                  .firstWhereOrNull((e) =>
                                      e.provinceCode ==
                                      controller.dataModel.customerProvinceCode
                                          .value),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const TitleNStar(title: "Quận/Huyện"),
                          SizedBox(
                            height: 35,
                            child: DropdownSearch<MstDistrictData>(
                              popupProps: PopupProps.dialog(
                                  showSelectedItems: true,
                                  title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 8),
                                        const Text("Quận/Huyện"),
                                        const SizedBox(height: 8),
                                        Container(height: 1, color: Colors.grey)
                                      ]),
                                  showSearchBox: true),
                              compareFn: MstDistrictData.compareFn,
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.only(left: 5, top: 5)),
                              ),
                              clearButtonProps: const ClearButtonProps(
                                isVisible: true,
                              ),
                              onChanged: (value) {
                                controller.setDistrict(
                                    value?.districtCode ?? "",
                                    value?.districtName ?? "");
                              },
                              asyncItems: (query) async {
                                var provinceCode = controller
                                    .dataModel.customerProvinceCode.value;
                                var result =
                                    await IDealerApiService.getMstDistrict(
                                        provinceCode: provinceCode);

                                return result.where((e) {
                                  var name = e.districtName ?? "";
                                  return name
                                      .toLowerCase()
                                      .contains(query.toLowerCase());
                                }).toList();
                              },
                              itemAsString: (value) {
                                return value != null
                                    ? value.districtName ?? ""
                                    : "";
                              },
                              selectedItem: controller.lstDistrict
                                  .firstWhereOrNull((e) =>
                                      e.districtCode ==
                                      controller.dataModel.customerDistrictCode
                                          .value),
                            ),
                          ),
                            const SizedBox(height: 16),
                            const Text(
                              "Zalo",
                              style: TextStyle(
                                  fontSize: 16, color: titleBlackColor),
                            ),
                            GestureDetector(
                              onTap: () async {
                                var result = await ChooseZaloDialog.show();
                                if (result != null) {
                                  controller.setZalo(
                                      result.userId.toString(),
                                      result.displayName ?? "",
                                      result.avatar ?? "");
                                }
                              },
                              child: Container(
                                height: 50,
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    if (dataModel.zaloName.value != "")
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: NamedCircleAvatar(
                                          name: dataModel.zaloName.value,
                                          avatar: dataModel.zaloAvatar.value,
                                          size: 18,
                                        ),
                                      ),
                                    const SizedBox(width: 14),
                                    if (dataModel.zaloName.value != "")
                                      Text(
                                        dataModel.zaloName.value,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    const Expanded(child: SizedBox()),
                                    if (dataModel.zaloName.value != "")
                                      IconButton(
                                          onPressed: () {
                                            dataModel.zaloName.value = "";
                                            dataModel.zaloID.value = "";
                                            dataModel.zaloAvatar.value = "";
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.grey,
                                            size: 24,
                                          )),
                                    const SizedBox(width: 14),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 12),
                                  ],
                                ),
                              ),
                            ),
                            Container(height: 1, color: Colors.grey),
                          const SizedBox(height: 16),
                          const Text(
                            "Địa chỉ",
                            style:
                                TextStyle(color: titleBlackColor, fontSize: 16),
                          ),
                          TextField(
                            controller: addressController,
                            style: const TextStyle(fontSize: 16),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 5)),
                            onChanged: (va) {
                              dataModel.customerAddress.value = va;
                            },
                          ),
                          const SizedBox(height: 16),
                          const SizedBox(height: 16),
                          const Text(
                            "Email",
                            style:
                                TextStyle(color: titleBlackColor, fontSize: 16),
                          ),
                          TextField(
                            controller: emailController,
                            style: const TextStyle(fontSize: 16),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 5)),
                            onChanged: (va) {
                              dataModel.customerEmail.value = va;
                            },
                          ),
                          if (widget.mode ==
                              CreateCustomerControllerMode.create)
                          const SizedBox(height: 16),
                          if (widget.mode ==
                              CreateCustomerControllerMode.create)
                          CustomDatePicker(
                            header: "Thời gian gửi SMS",
                            isStar: true,
                            text: dataModel.customerTimeSendSMS.value,
                            onChangeDateTime: (value1) {
                              dataModel.customerTimeSendSMS.value =
                                  value1.longDateTimeString();
                            },
                          ),
                          if (widget.mode ==
                              CreateCustomerControllerMode.update)
                            const SizedBox(height: 16),
                          if (widget.mode ==
                              CreateCustomerControllerMode.update)
                            Row(
                              children: [
                                const Text(
                                  "Kích hoạt",
                                  style: TextStyle(
                                      color: titleBlackColor, fontSize: 16),
                                ),
                                const SizedBox(width: 20),
                                CupertinoSwitch(
                                  value: dataModel.flagActive.value,
                                  onChanged: (value) {
                                    controller.setFlagActive(value);
                                  },
                                  activeColor: Colors.redAccent,
                                ),
                              ],
                            ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              controller.addImage(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.photo,
                                      color: Colors.black54, size: 18),
                                  SizedBox(width: 8),
                                  Text("Thêm ảnh",
                                      style: TextStyle(
                                          fontSize: 16, color: blackColor)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              ViewImageDialog.show(controller
                                                  .dataModel
                                                  .attachImages[index]
                                                  .url);
                                            },
                                            child: RichText(
                                              text: TextSpan(children: [
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0),
                                                    child: Image.asset(
                                                        ("assets/file/png.png"),
                                                        width: 20,
                                                        height: 20,
                                                        fit: BoxFit.scaleDown),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: controller
                                                      .dataModel
                                                      .attachImages[index]
                                                      .fileName,
                                                  style: const TextStyle(
                                                      color: kPrimaryColor),
                                                ),
                                              ]),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            controller.removeImage(index);
                                          },
                                          icon: const Icon(Icons.delete,
                                              color: kPrimaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(height: 1);
                              },
                              itemCount: dataModel.attachImages.length),
                        ],
                      ),
                    ),
                    Container(height: 8, color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 2, 12, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Text(
                                expanded ? "RÚT GỌN" : "MỞ RỘNG",
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: titleBlackColor,
                                    fontWeight: FontWeight.bold),
                              )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      expanded = !expanded;
                                    });
                                  },
                                  icon: Icon(expanded
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_up)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ExpandedSection(
                            expand: expanded,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomDatePicker(
                                  header: "Ngày sinh/Ngày thành lập",
                                  text: dataModel.dateOfBirth.value,
                                  onChangeDateTime: (value1) {
                                    dataModel.dateOfBirth.value =
                                        value1.longDateTimeString();
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Loại giấy tờ tùy thân",
                                  style: TextStyle(
                                      color: titleBlackColor, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: DropdownSearch<MstCardTypeData>(
                                    popupProps: const PopupProps.menu(
                                      showSelectedItems: true,
                                    ),
                                    compareFn: MstCardTypeData.compareFn,
                                    dropdownDecoratorProps:
                                        const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          contentPadding:
                                              EdgeInsets.only(left: 5, top: 5)),
                                    ),
                                    clearButtonProps: const ClearButtonProps(
                                      isVisible: true,
                                    ),
                                    onChanged: (value) {
                                      controller.setCardType(
                                          value?.idCardType ?? "",
                                          value?.idCardTypeName ?? "");
                                    },
                                    asyncItems: (query) {
                                      return IDealerApiService.getMstCardType();
                                    },
                                    itemAsString: (value) {
                                      return value != null
                                          ? value.idCardTypeName ?? ""
                                          : "";
                                    },
                                    selectedItem: controller.lstCardType
                                        .firstWhereOrNull((e) =>
                                            e.idCardType ==
                                            controller
                                                .dataModel.cardTypeID.value),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Số giấy tờ tùy thân",
                                  style: TextStyle(
                                      color: titleBlackColor, fontSize: 16),
                                ),
                                TextField(
                                  controller: gtttNoController,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 5)),
                                  onChanged: (va) {
                                    dataModel.cardTypeNumber.value = va;
                                  },
                                ),
                                const SizedBox(height: 16),
                                CustomDatePicker(
                                  header: "Ngày cấp",
                                  text: dataModel.cardTypeDate.value,
                                  onChangeDateTime: (value1) {
                                    dataModel.cardTypeDate.value =
                                        value1.longDateTimeString();
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Nơi cấp",
                                  style: TextStyle(
                                      color: titleBlackColor, fontSize: 16),
                                ),
                                TextField(
                                  controller: gtttPlaceController,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 5)),
                                  onChanged: (va) {
                                    dataModel.cardTypePlace.value = va;
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Giấy phép lái xe",
                                  style: TextStyle(
                                      color: titleBlackColor, fontSize: 16),
                                ),
                                TextField(
                                  controller: gplxController,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 5)),
                                  onChanged: (va) {
                                    dataModel.driverLicenseNo.value = va;
                                  },
                                ),
                                const SizedBox(height: 16),
                                CustomDatePicker(
                                  header: "Ngày hết hạn",
                                  text: dataModel
                                      .driverLicenseNoExpiredDate.value,
                                  onChangeDateTime: (value1) {
                                    controller
                                        .dataModel
                                        .driverLicenseNoExpiredDate
                                        .value = value1.longDateTimeString();
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Số tài khoản",
                                  style: TextStyle(
                                      color: titleBlackColor, fontSize: 16),
                                ),
                                TextField(
                                  controller: bankNoController,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 5)),
                                  onChanged: (va) {
                                    dataModel.bankAccountNo.value = va;
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Ngân hàng",
                                  style: TextStyle(
                                      color: titleBlackColor, fontSize: 16),
                                ),
                                TextField(
                                  controller: bankNameController,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 5)),
                                  onChanged: (va) {
                                    dataModel.bankName.value = va;
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Người đại diện",
                                  style: TextStyle(
                                      color: titleBlackColor, fontSize: 16),
                                ),
                                TextField(
                                  controller: representativeController,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 5)),
                                  onChanged: (va) {
                                    dataModel.representName.value = va;
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Chức vụ",
                                  style: TextStyle(
                                      color: titleBlackColor, fontSize: 16),
                                ),
                                TextField(
                                  controller: positionController,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 5)),
                                  onChanged: (va) {
                                    controller
                                        .dataModel.representPosition.value = va;
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Ghi chú",
                                  style: TextStyle(
                                      color: titleBlackColor, fontSize: 16),
                                ),
                                TextField(
                                  controller: remarkController,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 5)),
                                  onChanged: (va) {
                                    dataModel.remark.value = va;
                                  },
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 8, color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 2, 12, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Thông tin người liên hệ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: titleBlackColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () async {
                                  var result =
                                      await SearchCustomerScreen.show();
                                  if (result != null) {
                                    // controller.workCreateDataModel
                                    //     .opportunityCode.value = "";
                                    dataModel.contactCode.value =
                                        result.customerCode ?? "";
                                    dataModel.contactName.value =
                                        result.fullName ?? "";
                                    dataModel.contactPhoneNo.value =
                                        result.phoneNo ?? "";
                                    dataModel.contactProvinceCode.value =
                                        result.provinceCode ?? "";
                                    dataModel.contactProvinceName.value =
                                        result.mpProvincename ?? "";
                                  }
                                },
                                icon: const Icon(Icons.filter_alt),
                                color: titleBlackColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextTitleWidget(
                            title: "Mã người liên hệ",
                            content: dataModel.contactCode.value,
                          ),
                          TextTitleWidget(
                            title: "Tên người liên hệ",
                            content: dataModel.contactName.value,
                          ),
                          TextTitleWidget(
                            title: "Điện thoại",
                            content: dataModel.contactPhoneNo.value,
                          ),
                          TextTitleWidget(
                            title: "Tỉnh/Thành phố",
                            content: dataModel.contactProvinceName.value,
                          ),
                          if (widget.mode ==
                              CreateCustomerControllerMode.create)
                            Row(
                              children: [
                                Expanded(
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          var re =
                                              await controller.createCustomer();
                                        },
                                        child: const Text(
                                          "Lưu",
                                          style: TextStyle(fontSize: 16),
                                        ))),
                              ],
                            ),
                          if (widget.mode ==
                              CreateCustomerControllerMode.update)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        var result =
                                            await controller.createCustomer();
                                        if (result == true){
                                          Get.back(result: true);
                                        }
                                      },
                                      child: const Text(
                                        "Cập nhật",
                                        style: TextStyle(fontSize: 16),
                                      )),
                                ),
                                const SizedBox(width: 32,),
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        controller.updateCustomerPhoneNo();
                                      },
                                      child: const Text(
                                        "Cập nhật SĐT",
                                        style: TextStyle(fontSize: 16),
                                      )),
                                ),
                              ],
                            ),
                          const SizedBox(height: 20)
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// ------------------------- event click  ------------------------**/
}

class TitleNStar extends StatelessWidget {
  const TitleNStar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 16,
              color: titleBlackColor,
            ),
          ),
          const TextSpan(
            text: " *",
            style: TextStyle(
              fontSize: 16,
              color: starColor,
            ),
          ),
        ],
      ),
    );
  }
}
