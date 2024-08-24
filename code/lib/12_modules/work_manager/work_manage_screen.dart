import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/base_controller/view/data_view.dart';
import 'package:idealer/10_app_commons/custom/custom_text_field.dart';
import 'package:idealer/11_apis/core/models/code_name.dart';
import 'package:idealer/11_apis/core/requests/get_wk_user_schedule/response/wk_user_schedule_response.dart';
import 'package:idealer/11_screens/app_bar_widget.dart';
import 'package:idealer/12_modules/work_create_detail/buisiness_logic/level_status.dart';

import 'controller/work_manage_controller.dart';

class WorkManageScreen extends StatefulWidget {
  const WorkManageScreen({Key? key}) : super(key: key);

  static Future<void>? show() {
    return Get.to(const WorkManageScreen());
  }

  @override
  State<WorkManageScreen> createState() => _WorkManageScreenState();
}

class _WorkManageScreenState extends State<WorkManageScreen> {
  late WorkManageController controller;
  late TextEditingController cusNameController;
  late CustomTextFieldController fromDateController;
  late CustomTextFieldController toDateController;

  @override
  void initState() {
    // TODO: implement initState
    controller = WorkManageController();
    cusNameController = TextEditingController();
    fromDateController = CustomTextFieldController();
    toDateController = CustomTextFieldController();
    fromDateController.text = controller.fromDateTime.value;
    toDateController.text = controller.toDateTime.value;
    fromDateController.textFieldController.addListener(() {
      controller.fromDateTime.value = fromDateController.text;
    });
    toDateController.textFieldController.addListener(() {
      controller.toDateTime.value = toDateController.text;
    });
    controller.reload();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cusNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: "Quản lý công việc"),
      body: DataView<WkUserScheduleResponse>(
        controller: controller,
        builder: (ct, data) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                          DropdownSearch<CodeName>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                            ),
                            compareFn: (CodeName? value1, CodeName? value2) {
                              return false;
                            },
                            items: controller.statusLst,
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText: "Trạng thái công việc",
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.only(left: 12, right: 12)),
                            ),
                            clearButtonProps: ClearButtonProps(
                              isVisible: (controller.status.value.name == "")
                                  ? false
                                  : true,
                              // icon: IconButton(onPressed: (){
                              //   controller.staffName.value = "";
                              // }, icon: const Icon(Icons.clear, size: 24))
                            ),
                            onChanged: (value) {
                              controller.status.value =
                                  value ?? CodeName("", "");
                            },
                            selectedItem: controller.status.value,
                            itemAsString: (item) {
                              return item.name;
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          DropdownSearch<CodeName>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                            ),
                            compareFn: (CodeName? value1, CodeName? value2) {
                              return false;
                            },
                            items: controller.levelLst,
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  labelText: "Mức độ ưu tiên",
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.only(left: 12, right: 12)),
                            ),
                            clearButtonProps: ClearButtonProps(
                              isVisible: (controller.level.value.name == "")
                                  ? false
                                  : true,
                            ),
                            onChanged: (value) {
                              controller.level.value =
                                  value ?? CodeName('', '');
                            },
                            selectedItem: controller.level.value,
                            itemAsString: (item) {
                              return item.name;
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              Text("Ngày bắt đầu",
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
                                  text: fromDateController.text,
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
                                        controller.reloadData();
                                      },
                                      child: const Text(
                                        "Tìm kiếm",
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Tổng công việc: ${(data.listElement ?? []).length}",
                          style: const TextStyle(
                              color: titleBlackColor, fontSize: 13),
                        ),
                      ),
                      const Text("Ghi chú:",
                          style: TextStyle(fontSize: 14, color: blackColor)),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 12, right: 4),
                            width: 8,
                            height: 8,
                            color: LevelStatus.P.color,
                            child: const Text(""),
                          ),
                          Text(LevelStatus.P.toDisplayName,
                              style: const TextStyle(
                                  fontSize: 14, color: blackColor))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 12, right: 4),
                            width: 8,
                            height: 8,
                            color: LevelStatus.F.color,
                            child: const Text(""),
                          ),
                          Text(LevelStatus.F.toDisplayName,
                              style: const TextStyle(
                                  fontSize: 14, color: blackColor))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 12, right: 4),
                            width: 8,
                            height: 8,
                            color: LevelStatus.C.color,
                            child: const Text(""),
                          ),
                          Text(LevelStatus.C.toDisplayName,
                              style: const TextStyle(
                                  fontSize: 14, color: blackColor))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const ItemWorkWidget(
                    workName: "Tên công việc",
                    cusName: "Khách hàng",
                    phone: "Số điện thoại",
                    textSize: 15,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.transparent,
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                      );
                    },
                    itemCount: (data.listElement ?? []).length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            controller.itemClick(index);
                          },
                          child: ItemWorkWidget(
                            workName:
                                (data.listElement ?? [])[index].kpiPlusName ??
                                    "",
                            cusName:
                                (data.listElement ?? [])[index].fullName ?? "",
                            phone:
                                (data.listElement ?? [])[index].phoneNo ?? "",
                            textSize: 13,
                            fontWeight: FontWeight.normal,
                            backgroundColor: LevelStatusExt.fromApiName(
                                    (data.listElement ?? [])[index].usStatus ??
                                        "")
                                ?.color,
                          ));
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addClick();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemWorkWidget extends StatelessWidget {
  const ItemWorkWidget({
    Key? key,
    required this.workName,
    required this.cusName,
    required this.phone,
    required this.textSize,
    required this.fontWeight,
    required this.backgroundColor,
  }) : super(key: key);
  final String workName;
  final String cusName;
  final String phone;
  final double textSize;
  final FontWeight fontWeight;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10, 0, 10),
      child: Row(
        children: [
          Center(
            child: Container(
              width: 8,
              height: 8,
              color: backgroundColor,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(
            workName,
            style: TextStyle(
                fontWeight: fontWeight, fontSize: textSize, color: blackColor),
            textAlign: TextAlign.center,
          )),
          const SizedBox(
            width: 8,
          ),
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
            phone,
            style: TextStyle(
                fontWeight: fontWeight, fontSize: textSize, color: blackColor),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }
}
