import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/base_controller/view/data_view.dart';
import 'package:idealer/11_apis/core/models/code_name.dart';
import 'package:idealer/11_screens/app_bar_widget.dart';
import 'package:idealer/12_modules/work_create_detail/dialogs/view_image_dialog.dart';
import 'package:idealer/12_modules/work_create_detail/screens/customer_screen/customer_creen.dart';
import 'package:idealer/12_modules/work_create_detail/screens/related_opportunity_screen/related_opportunity_screen.dart';

import 'controller/work_create_controller.dart';

class WorkCreateScreen extends StatefulWidget {
  const WorkCreateScreen({Key? key, required this.mode, required this.schCode})
      : super(key: key);
  final WorkCreateControllerMode mode;
  final String schCode;

  static Future<bool>? show(WorkCreateControllerMode mode) async {
    return await Get.to(WorkCreateScreen(
      mode: mode,
      schCode: '',
    ));
  }

  static Future<bool>? showDetail(
      WorkCreateControllerMode mode, String schCode) async {
    return await Get.to(WorkCreateScreen(
      mode: mode,
      schCode: schCode,
    ));
  }

  @override
  State<WorkCreateScreen> createState() => _WorkCreateScreenState();
}

class _WorkCreateScreenState extends State<WorkCreateScreen> {
  late TextEditingController desController;
  late TextEditingController placeController;
  late WorkCreateController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = WorkCreateController();
    controller.mode = widget.mode;
    controller.schCode = widget.schCode;
    controller.reload();

    desController = TextEditingController();
    placeController = TextEditingController();
    controller.onState = () {
      desController = TextEditingController(
          text: controller.workCreateDataModel.decs.value);
      placeController = TextEditingController(
          text: controller.workCreateDataModel.location.value);
      setState(() {});
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = "Tạo mới công việc";
    switch (widget.mode) {
      case WorkCreateControllerMode.create:
        title = "Tạo mới công việc";
        break;
      case WorkCreateControllerMode.update:
        title = "Sửa công việc";
        break;
      case WorkCreateControllerMode.detail:
        title = "Chi tiết công việc";
        break;
    }
    return Scaffold(
      appBar: AppBarWidget(text: title),
      body: DataView<bool>(
          controller: controller,
          builder: (ct, data) {
            return SingleChildScrollView(
              child: Obx(() => IgnorePointer(
                    ignoring: (widget.mode == WorkCreateControllerMode.detail)
                        ? true
                        : false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextTitleWidget(
                                title: "Thời gian tạo",
                                content: controller.workCreateDataModel
                                    .createLongDateTime.value,
                                isSuffixIcon: true,
                              ),
                              TextTitleWidget(
                                title: "Mã công việc",
                                content: controller
                                    .workCreateDataModel.workCode.value,
                              ),
                              TextOptionWidget(
                                  title: "Tên công việc",
                                  isStar: true,
                                  content: controller.workCreateDataModel.work
                                          .value.kpiPlusName ??
                                      "",
                                  optionListener: () {
                                    controller.setWorkName();
                                  }),
                              const Text(
                                "Mô tả",
                                style: TextStyle(
                                    color: titleBlackColor, fontSize: 16),
                              ),
                              TextField(
                                controller: desController,
                                style: const TextStyle(fontSize: 16),
                                onChanged: (value) {
                                  controller.workCreateDataModel.decs.value =
                                      value;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "Địa điểm",
                                style: TextStyle(
                                    color: titleBlackColor, fontSize: 16),
                              ),
                              TextField(
                                controller: placeController,
                                style: const TextStyle(fontSize: 16),
                                onChanged: (value) {
                                  controller.workCreateDataModel.location
                                      .value = value;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextOptionWidget(
                                  title: "Thời gian thực hiện",
                                  isStar: true,
                                  content: AppConfig()
                                      .apiLongDatetimeFormat
                                      .format(controller.workCreateDataModel
                                          .processLongDateTime.value),
                                  iconData: Icons.calendar_month,
                                  optionListener: () {
                                    controller.setProcessDateTime(context);
                                  }),
                              Row(
                                children: [
                                  // Expanded(
                                  //   child: TextOptionWidget(
                                  //       title: "Mức độ ưu tiên",
                                  //       content: controller
                                  //           .workCreateDataModel.level.value.name,
                                  //       optionListener: () {
                                  //         controller.setPriorityLevel();
                                  //       }),
                                  // ),
                                  Expanded(
                                    child: DropdownSearch<CodeName>(
                                      popupProps: const PopupProps.menu(
                                        showSelectedItems: true,
                                      ),
                                      compareFn:
                                          (CodeName? value1, CodeName? value2) {
                                        return false;
                                      },
                                      items: controller.levelLst,
                                      dropdownDecoratorProps:
                                          const DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                labelText: "Mức độ ưu tiên",
                                                border: OutlineInputBorder(),
                                                contentPadding: EdgeInsets.only(
                                                    left: 12, right: 12)),
                                      ),
                                      clearButtonProps: ClearButtonProps(
                                          isVisible: (controller
                                                      .workCreateDataModel
                                                      .level
                                                      .value
                                                      .name ==
                                                  "")
                                              ? false
                                              : true,
                                          padding:
                                              const EdgeInsets.only(left: 8)),
                                      onChanged: (value) {
                                        controller.workCreateDataModel.level
                                            .value = value ?? CodeName('', '');
                                      },
                                      selectedItem: controller
                                          .workCreateDataModel.level.value,
                                      itemAsString: (item) {
                                        return item.name;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child:
                                        // TextOptionWidget(
                                        //     title: "Trạng thái *",
                                        //     content: controller
                                        //         .workCreateDataModel.status.value,
                                        //     optionListener: () {
                                        //       controller.setStatus();
                                        //     }),
                                        DropdownSearch<String>(
                                      popupProps: const PopupProps.menu(
                                        showSelectedItems: true,
                                      ),
                                      items: const ["P", "F", "C"],
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                // labelText: "Trạng thái *",
                                                label: RichText(
                                                  text: const TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "Trạng thái",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              titleBlackColor,
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
                                                border:
                                                    const OutlineInputBorder(),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 12, right: 12)),
                                      ),
                                      clearButtonProps: ClearButtonProps(
                                        isVisible: (controller
                                                    .workCreateDataModel
                                                    .status
                                                    .value ==
                                                "")
                                            ? false
                                            : true,
                                        // icon: IconButton(onPressed: (){
                                        //   controller.status.value = "";
                                        // }, icon: const Icon(Icons.clear, size: 24))
                                      ),
                                      onChanged: (value) {
                                        controller.workCreateDataModel.status
                                            .value = value ?? "";
                                      },
                                      selectedItem: controller
                                          .workCreateDataModel.status.value,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              // TextOptionWidget(
                              //     title: "Đánh giá",
                              //     content: controller.workCreateDataModel.evaluate
                              //         .value.name,
                              //     optionListener: () {
                              //       controller.setEvaluate();
                              //     }),
                              DropdownSearch<CodeName>(
                                popupProps: const PopupProps.menu(
                                  showSelectedItems: true,
                                ),
                                compareFn:
                                    (CodeName? value1, CodeName? value2) {
                                  return false;
                                },
                                items: controller.evaluateLst,
                                dropdownDecoratorProps:
                                    const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                      labelText: "Đánh giá",
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                          EdgeInsets.only(left: 12, right: 12)),
                                ),
                                clearButtonProps: ClearButtonProps(
                                    isVisible: (controller.workCreateDataModel
                                                .evaluate.value.name ==
                                            "")
                                        ? false
                                        : true,
                                    padding: const EdgeInsets.only(left: 8)),
                                onChanged: (value) {
                                  controller.workCreateDataModel.evaluate
                                      .value = value ?? CodeName('', '');
                                },
                                selectedItem: controller
                                    .workCreateDataModel.evaluate.value,
                                itemAsString: (item) {
                                  return item.name;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
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
                                      Icon(
                                        Icons.photo,
                                        color: Colors.black54,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Thêm ảnh",
                                        style: TextStyle(
                                            fontSize: 16, color: blackColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: Colors.white,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  ViewImageDialog.show(
                                                      controller
                                                          .workCreateDataModel
                                                          .attachImages[index]
                                                          .url);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 8.0,),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                          ("assets/file/png.png"),
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit
                                                              .scaleDown),
                                                      const SizedBox(width: 8,),
                                                      Expanded(
                                                        child: Text(
                                                          controller.workCreateDataModel.attachImages[index].fileName,
                                                          style: const TextStyle(color: kPrimaryColor, fontSize: 13),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                controller.removeImage(index);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      height: 1,
                                    );
                                  },
                                  itemCount: controller
                                      .workCreateDataModel.attachImages.length),
                            ],
                          ),
                        ),
                        Container(
                          height: 8,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 2, 12, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Cơ hội liên quan",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: titleBlackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      var result =
                                          await RelatedOpportunityScreen.show();
                                      if (result != null) {
                                        controller
                                            .workCreateDataModel
                                            .opportunityCode
                                            .value = result.salesId ?? "";
                                        controller.workCreateDataModel.cusCode
                                            .value = result.customerCode ?? "";
                                        controller.workCreateDataModel.cusName
                                            .value = result.fullName ?? "";
                                        controller.workCreateDataModel.cusPhone
                                            .value = result.phoneNo ?? "";
                                        controller.workCreateDataModel
                                                .contactCode.value =
                                            result.customerContactCode ?? "";
                                        controller.workCreateDataModel
                                                .contactName.value =
                                            result.customerContactName ?? "";
                                        controller.workCreateDataModel
                                                .contactPhone.value =
                                            result.customerContactPhoneNo ?? "";
                                      }
                                    },
                                    icon: const Icon(Icons.filter_alt),
                                    color: kPrimaryColor,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextTitleWidget(
                                title: "Mã cơ hội",
                                content: controller
                                    .workCreateDataModel.opportunityCode.value,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 8,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 2, 12, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Khách hàng",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: titleBlackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      var result = await CustomerScreen.show();
                                      if (result != null) {
                                        controller.workCreateDataModel
                                            .opportunityCode.value = "";
                                        controller.workCreateDataModel.cusCode
                                            .value = result.customerCode ?? "";
                                        controller.workCreateDataModel.cusName
                                            .value = result.fullName ?? "";
                                        controller.workCreateDataModel.cusPhone
                                            .value = result.phoneNo ?? "";
                                        controller.workCreateDataModel
                                                .contactCode.value =
                                            result.customerContactCode ?? "";
                                        controller.workCreateDataModel
                                                .contactName.value =
                                            result.customerContactName ?? "";
                                        controller.workCreateDataModel
                                                .contactPhone.value =
                                            result.customerContactPhoneNo ?? "";
                                      }
                                    },
                                    icon: const Icon(Icons.filter_alt),
                                    color: kPrimaryColor,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextTitleWidget(
                                title: "Mã khách hàng",
                                content: controller
                                    .workCreateDataModel.cusCode.value,
                              ),
                              TextTitleWidget(
                                title: "Tên khách hàng",
                                content: controller
                                    .workCreateDataModel.cusName.value,
                              ),
                              TextTitleWidget(
                                title: "Điện thoại khách hàng",
                                content: controller
                                    .workCreateDataModel.cusPhone.value,
                              ),
                              TextTitleWidget(
                                title: "Mã người liên hệ",
                                content: controller
                                    .workCreateDataModel.contactCode.value,
                              ),
                              TextTitleWidget(
                                title: "Tên người liên hệ",
                                content: controller
                                    .workCreateDataModel.contactName.value,
                              ),
                              TextTitleWidget(
                                title: "Điện thoại người liên hệ",
                                content: controller
                                    .workCreateDataModel.contactPhone.value,
                              ),
                              if (widget.mode !=
                                  WorkCreateControllerMode.detail)
                                Row(
                                  children: [
                                    Expanded(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              controller.saveWork();
                                            },
                                            child: const Text(
                                              "Lưu",
                                              style: TextStyle(fontSize: 16),
                                            ))),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          }),
    );
  }
}

// ignore: must_be_immutable
class TextTitleWidget extends StatelessWidget {
  TextTitleWidget(
      {Key? key,
      required this.title,
      required this.content,
      this.isSuffixIcon,
      this.isStar})
      : super(key: key);
  final String title;
  final String content;
  bool? isStar = false;
  bool? isSuffixIcon = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: const TextStyle(
                  fontSize: 16,
                  color: titleBlackColor,
                ),
              ),
              if (isStar == true)
                const TextSpan(
                  text: " *",
                  style: TextStyle(
                    fontSize: 16,
                    color: starColor,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 15,
                  color: titleBlackColor,
                ),
              ),
            ),
            if (isSuffixIcon == true)
              const SizedBox(
                width: 10,
              ),
            if (isSuffixIcon == true)
              const Icon(
                Icons.calendar_month,
                color: titleBlackColor,
              ),
            if (isSuffixIcon == true)
              const SizedBox(
                width: 4,
              ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 1,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

class TextOptionWidget extends StatelessWidget {
  TextOptionWidget({
    Key? key,
    required this.title,
    required this.content,
    this.isStar,
    this.iconData = Icons.arrow_drop_down,
    required this.optionListener,
  }) : super(key: key);
  final String title;
  final String content;
  IconData? iconData;
  bool? isStar = false;
  final VoidCallback optionListener;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: const TextStyle(
                  fontSize: 16,
                  color: titleBlackColor,
                ),
              ),
              if (isStar == true)
                const TextSpan(
                  text: " *",
                  style: TextStyle(
                    fontSize: 16,
                    color: starColor,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            optionListener.call();
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  content,
                  style: const TextStyle(
                    fontSize: 15,
                    color: blackColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                iconData,
                color: blackColor,
              ),
              const SizedBox(
                width: 6,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 1,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
