import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/base_controller/view/data_view.dart';
import 'package:idealer/10_app_commons/custom/custom_text_field.dart';
import 'package:idealer/11_apis/core/models/customer_group_type_data.dart';
import 'package:idealer/11_apis/core/models/customer_type_data.dart';
import 'package:idealer/11_apis/core/models/mst_province_data.dart';
import 'package:idealer/11_apis/core/models/user_by_dealer_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';
import 'package:idealer/11_screens/app_bar_widget.dart';
import 'package:idealer/11_screens/business_logic/permission_idealer.dart';
import 'package:idealer/12_modules/customer/create_customer/controller/create_customer_controller.dart';
import 'package:idealer/12_modules/customer/create_customer/screen/create_customer_screen.dart';
import 'package:idealer/12_modules/customer/manage_customer/controller/customer_manage_controller.dart';
import 'package:idealer/12_modules/work_schedule/items/item_work_day.dart';

class ManageCustomerScreen extends StatefulWidget {
  const ManageCustomerScreen({Key? key}) : super(key: key);

  static Future<void> show() async {
    return await Get.to(const ManageCustomerScreen());
  }

  @override
  State<ManageCustomerScreen> createState() => _ManageCustomerScreenState();
}

class _ManageCustomerScreenState extends State<ManageCustomerScreen> {
  late TextEditingController dealerCodeController;
  late TextEditingController customerNameController;
  late TextEditingController phoneNoController;
  late TextEditingController phoneNoContactController;
  late TextEditingController emailController;
  late CustomTextFieldController fromDateController;
  late CustomTextFieldController toDateController;
  late CustomerManageController controller;
  bool expanded = false;

  @override
  void initState() {
    controller = CustomerManageController();
    dealerCodeController =
        TextEditingController(text: controller.dealerCode.value);
    customerNameController = TextEditingController();
    phoneNoController = TextEditingController();
    phoneNoContactController = TextEditingController();
    emailController = TextEditingController();
    fromDateController = CustomTextFieldController();
    fromDateController.text = controller.fromDate.value;
    toDateController = CustomTextFieldController();
    fromDateController.textFieldController.addListener(() {
      controller.fromDate.value = fromDateController.text.toString();
    });
    toDateController.textFieldController.addListener(() {
      controller.toDate.value = toDateController.text.toString();
    });
    controller.reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: "Quản lý khách hàng"),
      body: DataView<bool>(
        controller: controller,
        builder: (ct, data) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: dealerCodeController,
                            enabled: false,
                            decoration: const InputDecoration(
                              labelText: "Mã đại lý",
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.only(left: 12, right: 12),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DropdownSearch<UserByDealerData>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                            ),
                            compareFn: (UserByDealerData? value1,
                                UserByDealerData? value2) {
                              return false;
                            },
                            asyncItems: (value) async {
                              return await IDealerApiService.getUserByDealer();
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  label: RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Nhân viên sở hữu",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: titleBlackColor,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " *",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: starColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  border: const OutlineInputBorder(),
                                  contentPadding: const EdgeInsets.only(
                                      left: 12, right: 12)),
                            ),
                            onChanged: (value) {
                              controller.userByDealer.value =
                                  value ?? UserByDealerData();
                            },
                            selectedItem: controller.userByDealer.value,
                            itemAsString: (item) {
                              return (item.userCode == null)
                                  ? controller.userByDealerDefault
                                  : item.userName != null ? "${item.userCode} - ${item.userName}" :"${item.userCode}" ;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DropdownSearch<CustomerTypeData>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                            ),
                            compareFn: (CustomerTypeData? value1,
                                CustomerTypeData? value2) {
                              return false;
                            },
                            asyncItems: (value) async {
                              return await IDealerApiService.getCustomerType();
                            },
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText: "Loại khách hàng",
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.only(left: 12, right: 12)),
                            ),
                            clearButtonProps: ClearButtonProps(
                              isVisible:
                                  (controller.cusType.value.customerTypeCode ==
                                          "")
                                      ? false
                                      : true,
                            ),
                            onChanged: (value) {
                              controller.cusType.value =
                                  value ?? CustomerTypeData();
                            },
                            selectedItem: controller.cusType.value,
                            itemAsString: (item) {
                              return (item.customerTypeCode == null)
                                  ? ""
                                  : "${item.customerTypeName}";
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DropdownSearch<CustomerGroupTypeData>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                            ),
                            compareFn: (CustomerGroupTypeData? value1,
                                CustomerGroupTypeData? value2) {
                              return false;
                            },
                            asyncItems: (value) async {
                              return await IDealerApiService
                                  .getCustomerGroupType();
                            },
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText: "Nhóm khách hàng",
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.only(left: 12, right: 12)),
                            ),
                            clearButtonProps: ClearButtonProps(
                              isVisible:
                                  (controller.cusGroup.value.customerTypeCode ==
                                          "")
                                      ? false
                                      : true,
                            ),
                            onChanged: (value) {
                              controller.cusGroup.value =
                                  value ?? CustomerGroupTypeData();
                            },
                            selectedItem: controller.cusGroup.value,
                            itemAsString: (item) {
                              return (item.customerGrpType == null)
                                  ? ""
                                  : "${item.customerGrpTypeName}";
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DropdownSearch<MstProvinceData>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                            ),
                            compareFn: (MstProvinceData? value1,
                                MstProvinceData? value2) {
                              return false;
                            },
                            asyncItems: (value) async {
                              return await IDealerApiService.getMstProvince();
                            },
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText: "Tỉnh/Thành phố",
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.only(left: 12, right: 12)),
                            ),
                            clearButtonProps: ClearButtonProps(
                              isVisible:
                                  (controller.province.value.provinceCode == "")
                                      ? false
                                      : true,
                            ),
                            onChanged: (value) {
                              controller.province.value =
                                  value ?? MstProvinceData();
                            },
                            selectedItem: controller.province.value,
                            itemAsString: (item) {
                              return (item.provinceCode == null)
                                  ? ""
                                  : "${item.provinceName}";
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text("Ngày tạo",
                              style: TextStyle(
                                  fontSize: 16, color: titleBlackColor)),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: fromDateController,
                                  inputType: CustomTextFieldInputType.date,
                                  text: fromDateController.text,
                                  isVisiblePrefIcon: false,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text("đến",
                                  style: TextStyle(
                                      fontSize: 16, color: titleBlackColor)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  controller: toDateController,
                                  inputType: CustomTextFieldInputType.date,
                                  isVisiblePrefIcon: false,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: customerNameController,
                            onChanged: (value) {
                              controller.cusName.value = value;
                            },
                            decoration: const InputDecoration(
                              labelText: "Tên khách hàng",
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.only(left: 12, right: 12),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: phoneNoController,
                            onChanged: (value) {
                              controller.phone.value = value;
                            },
                            decoration: const InputDecoration(
                              labelText: "Điện thoại",
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.only(left: 12, right: 12),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: phoneNoContactController,
                            onChanged: (value) {
                              controller.phoneNoContract.value = value;
                            },
                            decoration: const InputDecoration(
                              labelText: "Điện thoại liên hệ",
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.only(left: 12, right: 12),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        controller.reload();
                                      },
                                      child: const Text(
                                        "Tìm kiếm",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )))
                            ],
                          ),
                        ],
                      ),
                    )),
                Container(height: 8, color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Danh sách khách hàng",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          if (PermissionIdealer.instance()
                              .isPermissionCusCreate)
                            ElevatedButton(
                                onPressed: () async {
                                  var result = await CreateCustomerScreen.show(
                                      CreateCustomerControllerMode.create);
                                },
                                child: const Text(
                                  "Thêm mới",
                                  style: TextStyle(fontSize: 15),
                                ))
                        ],
                      ),
                      const SizedBox(height: 16),
                      Obx(() => Row(
                            children: [
                              Text(
                                "Tất cả (${controller.dealerCustomers.length}) | Đã kích hoạt (${controller.flagActive.value.toString()}) | Chưa kích hoạt (${controller.flagActiveNot.value.toString()})",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          )),
                      const SizedBox(height: 8),
                      const ItemWorkDay(
                        // icon: Icons.sort,
                        workName: "Khách hàng",
                        cusName: "Số điện thoại",
                        phone: "Tỉnh/Thành phố",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        itemColor: Colors.transparent,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 1,
                          );
                        },
                        itemCount: controller.dealerCustomers.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.itemClick(index);
                            },
                            child: ItemWorkDay(
                              // icon: Icons.sort,
                              workName:
                                  controller.dealerCustomers[index].fullName ??
                                      "",
                              cusName:
                                  controller.dealerCustomers[index].phoneNo ??
                                      "",
                              phone: controller
                                      .dealerCustomers[index].mpProvincename ??
                                  "",
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              itemColor: (controller
                                          .dealerCustomers[index].flagActive ==
                                      "0")
                                  ? Colors.redAccent
                                  : Colors.transparent,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        useLoading: true,
        usePullDown: false,
        usePullUp: true,
        loadingEmptyWidget: Container(),
        showDataOnLoading: true,
        showDataOnError: true,
      ),
    );
  }

  /// ------------------------- event click  ------------------------**/
}
