import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/base_controller/view/data_view.dart';
import 'package:idealer/10_app_commons/custom/custom_text_field.dart';
import 'package:idealer/11_apis/core/models/sp_sales_process_search_data.dart';

import 'controller/related_opportunity_controller.dart';

class RelatedOpportunityScreen extends StatefulWidget {
  const RelatedOpportunityScreen({Key? key}) : super(key: key);

  static Future<SPSalesProcessSearchData>? show() async {
    return await Get.to(const RelatedOpportunityScreen());
  }

  @override
  State<RelatedOpportunityScreen> createState() =>
      _RelatedOpportunityScreenState();
}

class _RelatedOpportunityScreenState extends State<RelatedOpportunityScreen> {
  late TextEditingController opportunityController;
  late TextEditingController cusNameController;
  late TextEditingController phoneController;
  late CustomTextFieldController fromDateController;
  late CustomTextFieldController toDateController;

  late RelatedOpportunityController controller;

  @override
  void initState() {
    // TODO: implement initState
    opportunityController = TextEditingController();
    cusNameController = TextEditingController();
    phoneController = TextEditingController();
    fromDateController = CustomTextFieldController();
    toDateController = CustomTextFieldController();
    fromDateController.textFieldController.addListener(() {
      controller.fromDateTime.value = fromDateController.text;
    });
    toDateController.textFieldController.addListener(() {
      controller.toDateTime.value = toDateController.text;
    });
    controller = RelatedOpportunityController();
    controller.reload();
    controller.setInit();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    opportunityController.dispose();
    fromDateController.textFieldController.dispose();
    toDateController.textFieldController.dispose();
    cusNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Danh sách cơ hội",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: DataView<List<SPSalesProcessSearchData>>(
        controller: controller,
        builder: (ct, data) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: opportunityController,
                            onChanged: (value) {
                              controller.opportunityCode.value = value;
                            },
                            decoration: InputDecoration(
                              labelText: "Mã cơ hội",
                              border: const OutlineInputBorder(),
                              contentPadding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    opportunityController.text = "";
                                    controller.opportunityCode.value = "";
                                  },
                                  icon: const Icon(Icons.clear)),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: cusNameController,
                            onChanged: (value) {
                              controller.cusName.value = value;
                            },
                            decoration: InputDecoration(
                              labelText: "Tên khách hàng",
                              border: const OutlineInputBorder(),
                              contentPadding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    cusNameController.text = "";
                                    controller.cusName.value = "";
                                  },
                                  icon: const Icon(Icons.clear)),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: phoneController,
                            onChanged: (value) {
                              controller.phone.value = value;
                            },
                            decoration: InputDecoration(
                              labelText: "Điện thoại",
                              border: const OutlineInputBorder(),
                              contentPadding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    phoneController.text = "";
                                    controller.phone.value = "";
                                  },
                                  icon: const Icon(Icons.clear)),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          DropdownSearch<String>(
                            popupProps: const PopupProps.dialog(
                              showSelectedItems: true,
                            ),
                            items: controller.userByDealers
                                .map((e) => e.userName ?? "")
                                .toList(),
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText: "Nhân viên",
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.only(left: 12, right: 12)),
                            ),
                            clearButtonProps: ClearButtonProps(
                              isVisible: (controller.staffName.value == "")
                                  ? false
                                  : true,
                              // icon: IconButton(onPressed: (){
                              //   controller.staffName.value = "";
                              // }, icon: const Icon(Icons.clear, size: 24))
                            ),
                            onChanged: (value) {
                              controller.staffName.value = value ?? "";
                            },
                            selectedItem: controller.staffName.value == ""
                                ? controller.userByDealerDefault
                                : controller.staffName.value,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                            ),
                            items: const [
                              "Tham khảo",
                              "Quan tâm",
                              "Đàm phán",
                              "Lái thử",
                            ],
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText: "Trạng thái",
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.only(left: 12, right: 12)),
                            ),
                            clearButtonProps: ClearButtonProps(
                              isVisible: (controller.status.value == "")
                                  ? false
                                  : true,
                              // icon: IconButton(onPressed: (){
                              //   controller.status.value = "";
                              // }, icon: const Icon(Icons.clear, size: 24))
                            ),
                            onChanged: (value) {
                              controller.status.value = value ?? "";
                            },
                            selectedItem: controller.status.value,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              Text("Ngày chọn",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[600])),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: CustomTextField(
                                  controller: fromDateController,
                                  inputType: CustomTextFieldInputType.date,
                                  isVisiblePrefIcon: false,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text("đến",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[600])),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  controller: toDateController,
                                  inputType: CustomTextFieldInputType.date,
                                  isVisiblePrefIcon: false,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        controller.setOpportunity(controller);
                                      },
                                      child: const Text(
                                        "Tìm kiếm cơ hội",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )))
                            ],
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  const ItemRelatedWidget(
                      cusName: "Tên khách hàng",
                      module: "Module tiềm năng",
                      textSize: 15,
                      fontWeight: FontWeight.bold),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                      );
                    },
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Get.back(result: data[index]);
                          },
                          child: ItemRelatedWidget(
                              cusName: data[index].fullName ?? "",
                              module: data[index].modelTiemNang ?? "",
                              textSize: 13,
                              fontWeight: FontWeight.normal));
                    },
                  ),
                ],
              ),
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

  ///**------------------------- set event ----------------------------*/

  void fromDateTimeClick(BuildContext context) {
    controller.setFromDateTime(context);
  }

  void toDateTimeClick(BuildContext context) {
    controller.setToDateTime(context);
  }

  void staffClick() {
    controller.setStaff();
  }
}

class ItemRelatedWidget extends StatelessWidget {
  const ItemRelatedWidget(
      {Key? key,
      required this.cusName,
      required this.module,
      required this.textSize,
      required this.fontWeight})
      : super(key: key);
  final String cusName;
  final String module;
  final double textSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 8, 0, 8),
      child: Row(
        children: [
          Expanded(
              child: Text(
            cusName,
            style: TextStyle(
                fontWeight: fontWeight, fontSize: textSize, color: blackColor),
            textAlign: TextAlign.center,
          )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(
            module,
            style: TextStyle(
                fontWeight: fontWeight, fontSize: textSize, color: blackColor),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }
}
