import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/base_controller/view/data_view.dart';
import 'package:idealer/10_app_commons/custom/custom_text_field.dart';
import 'package:idealer/11_screens/app_bar_widget.dart';
import 'package:idealer/11_screens/business_logic/permission_idealer.dart';
import 'package:idealer/12_modules/opportunity/opportunity_create/controller/opportunity_create_controller.dart';
import 'package:idealer/12_modules/opportunity/opportunity_create/opportunity_create_screen.dart';
import 'package:idealer/12_modules/opportunity/opportunity_manage/controller/opportunity_manage_controller.dart';

class OpportunityManageScreen extends StatefulWidget {
  const OpportunityManageScreen({Key? key}) : super(key: key);

  static Future<void>? show() {
    return Get.to(const OpportunityManageScreen());
  }

  @override
  State<OpportunityManageScreen> createState() =>
      _OpportunityManageScreenState();
}

class _OpportunityManageScreenState extends State<OpportunityManageScreen> {
  late CustomTextFieldController fromDateController;
  late CustomTextFieldController toDateController;
  late TextEditingController cusNameController;
  late OpportunityManageController controller;

  RxList<Widget> listItem = <Widget>[].obs;

  @override
  void initState() {
    // TODO: implement initState
    fromDateController = CustomTextFieldController();
    toDateController = CustomTextFieldController();
    fromDateController.textFieldController.addListener(() {
      controller.fromDate.value = fromDateController.text.toString();
    });
    toDateController.textFieldController.addListener(() {
      controller.toDate.value = toDateController.text.toString();
    });
    cusNameController = TextEditingController();
    controller = OpportunityManageController();
    controller.reload();
    addCheckBox();
    super.initState();
  }

  @override
  void dispose() {
    cusNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: "Quản lý cơ hội"),
      body: DataView<bool>(
        controller: controller,
        builder: (ct, data) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: cusNameController,
                            onChanged: (value) {
                              controller.cusfullname.value = value;
                            },
                            decoration: InputDecoration(
                              labelText: "Tên khách hàng",
                              hintText: "Nhập ...",
                              border: const OutlineInputBorder(),
                              contentPadding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    cusNameController.text = "";
                                    controller.cusfullname.value = "";
                                  },
                                  icon: const Icon(Icons.clear)),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text("Ngày tạo",
                              style: TextStyle(
                                  fontSize: 14, color: titleBlackColor)),
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
                            height: 16,
                          ),
                          const Text("Trạng thái",
                              style: TextStyle(
                                  fontSize: 16, color: titleBlackColor)),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 3.6,
                            children: listItem,
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                controller.searchClick();
                              },
                              child: const Text(
                                "Tìm kiếm",
                                style: TextStyle(fontSize: 16),
                              ))),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Danh sách cơ hội",
                    style: TextStyle(
                        fontSize: 16,
                        color: titleBlackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Tổng: ${controller.elements.length}",
                    style:
                        const TextStyle(color: titleBlackColor, fontSize: 13),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const ItemCusWidget(
                      cusName: "Tên khách hàng",
                      module: "Model tiềm năng",
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
                    itemCount: controller.elements.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            controller.itemClick(index);
                          },
                          child: ItemCusWidget(
                              cusName:
                                  controller.elements[index].fullName ?? "",
                              module:
                                  controller.elements[index].modelTiemNang ??
                                      "",
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

      floatingActionButton:
      (PermissionIdealer.instance().isPermissionOpportunityCreate)?
      FloatingActionButton(
        onPressed: () {
          OpportunityCreateScreen.show(OpportunityCreateMode.create, "");
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ) : null,
    );
  }

  void addCheckBox() {
    listItem.add(
      Obx(() => CheckboxListTile(
            title: const Text(
              "Tham khảo",
              style: TextStyle(fontSize: 15, color: blackColor),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: controller.isThamkhao.value,
            onChanged: (value) {
              controller.isThamkhao.value = !controller.isThamkhao.value;
            },
            contentPadding: EdgeInsets.zero,
          )),
    );
    listItem.add(
      Obx(() => CheckboxListTile(
            title: const Text("Quan tâm",
                style: TextStyle(fontSize: 15, color: blackColor)),
            controlAffinity: ListTileControlAffinity.leading,
            value: controller.isQuantam.value,
            onChanged: (value) {
              controller.isQuantam.value = !controller.isQuantam.value;
            },
            contentPadding: EdgeInsets.zero,
          )),
    );
    listItem.add(
      Obx(() => CheckboxListTile(
            title: const Text("Lái thử",
                style: TextStyle(fontSize: 15, color: blackColor)),
            controlAffinity: ListTileControlAffinity.leading,
            value: controller.isLaithu.value,
            onChanged: (value) {
              controller.isLaithu.value = !controller.isLaithu.value;
            },
            contentPadding: EdgeInsets.zero,
          )),
    );
    listItem.add(
      Obx(() => CheckboxListTile(
            title: const Text("Đàm phán",
                style: TextStyle(fontSize: 15, color: blackColor)),
            controlAffinity: ListTileControlAffinity.leading,
            value: controller.isDamphan.value,
            onChanged: (value) {
              controller.isDamphan.value = !controller.isDamphan.value;
            },
            contentPadding: EdgeInsets.zero,
          )),
    );
    listItem.add(
      Obx(() => CheckboxListTile(
            title: const Text("Ký hợp đồng",
                style: TextStyle(fontSize: 15, color: blackColor)),
            controlAffinity: ListTileControlAffinity.leading,
            value: controller.isKyhd.value,
            onChanged: (value) {
              controller.isKyhd.value = !controller.isKyhd.value;
            },
            contentPadding: EdgeInsets.zero,
          )),
    );
    listItem.add(
      Obx(() => CheckboxListTile(
            title: const Text("Hủy",
                style: TextStyle(fontSize: 15, color: blackColor)),
            controlAffinity: ListTileControlAffinity.leading,
            value: controller.isHuy.value,
            onChanged: (value) {
              controller.isHuy.value = !controller.isHuy.value;
            },
            contentPadding: EdgeInsets.zero,
          )),
    );
  }
}

class ItemCusWidget extends StatelessWidget {
  const ItemCusWidget({
    Key? key,
    required this.cusName,
    required this.module,
    required this.textSize,
    required this.fontWeight,
  }) : super(key: key);
  final String cusName;
  final String module;
  final double textSize;

  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10, 0, 10),
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
