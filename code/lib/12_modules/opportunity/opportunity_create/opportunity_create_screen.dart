import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/base_controller/view/data_view.dart';
import 'package:idealer/11_apis/core/models/code_name.dart';
import 'package:idealer/11_apis/core/models/customer_source_data.dart';
import 'package:idealer/11_apis/core/models/marketing_strategy_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';
import 'package:idealer/11_screens/app_bar_widget.dart';
import 'package:idealer/12_modules/opportunity/items/item_model_widget.dart';
import 'package:idealer/12_modules/opportunity/opportunity_create/controller/opportunity_create_controller.dart';
import 'package:idealer/12_modules/opportunity/opportunity_create/dialog/model_opportunity_dialog.dart';
import 'package:idealer/12_modules/work_create_detail/screens/customer_screen/customer_creen.dart';
import 'package:idealer/10_app_commons/extensions/double_extention.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class OpportunityCreateScreen extends StatefulWidget {
  const OpportunityCreateScreen(
      {Key? key, required this.mode, required this.salesId})
      : super(key: key);
  final OpportunityCreateMode mode;
  final String salesId;
  static Future<bool>? show(OpportunityCreateMode mode, String salesId) async {
    return await Get.to(OpportunityCreateScreen(
      mode: mode,
      salesId: salesId,
    ));
  }

  @override
  State<OpportunityCreateScreen> createState() =>
      _OpportunityCreateScreenState();
}

class _OpportunityCreateScreenState extends State<OpportunityCreateScreen> {
  late OpportunityCreateController controller;
  late TextEditingController budgetPlanController;
  late TextEditingController remarkController;
  @override
  void initState() {
    // TODO: implement initState
    controller = OpportunityCreateController();
    controller.mode = widget.mode;
    controller.salesId = widget.salesId;
    controller.reload();
    budgetPlanController = TextEditingController();
    remarkController = TextEditingController();
    controller.onState = () {
      remarkController.text = controller.opportunityModel.remark.value;
      budgetPlanController.text =
          controller.opportunityModel.budgetPlan.value.toCurrency;
      setState(() {});
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = "Tạo mới cơ hội";
    switch (controller.mode) {
      case OpportunityCreateMode.create:
        title = "Tạo mới cơ hội";
        break;

      case OpportunityCreateMode.update:
        title = "Sửa cơ hội";
        break;
      case OpportunityCreateMode.detail:
        title = "Chi tiết cơ hội";
        break;
    }
    return Scaffold(
      appBar: AppBarWidget(text: title),
      body: DataView<bool>(
          controller: controller,
          builder: (ct, data) {
            return SingleChildScrollView(
              child: Obx(() => IgnorePointer(
                    ignoring: (controller.mode == OpportunityCreateMode.detail)
                        ? true
                        : false,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextTitleWidget(
                                title: "Mã cơ hội",
                                content:
                                    controller.opportunityModel.saleId.value,
                              ),
                              TextTitleWidget(
                                title: "Ngày tạo",
                                content: controller
                                    .opportunityModel.createDate.value,
                                isSuffixIcon: true,
                              ),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Trạng thái",
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
                              DropdownSearch<CodeName>(
                                popupProps: const PopupProps.menu(
                                  showSelectedItems: true,
                                ),
                                compareFn:
                                    (CodeName? value1, CodeName? value2) {
                                  return false;
                                },
                                items: controller.statusLst,
                                dropdownDecoratorProps:
                                    const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                      labelText: "",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero),
                                ),
                                clearButtonProps: ClearButtonProps(
                                    isVisible: (controller.opportunityModel
                                                .status.value.name ==
                                            "")
                                        ? false
                                        : true,
                                    padding: const EdgeInsets.only(left: 8)),
                                onChanged: (value) {
                                  controller.opportunityModel.status.value =
                                      value ?? CodeName('', '');
                                },
                                selectedItem:
                                    controller.opportunityModel.status.value,
                                itemAsString: (item) {
                                  return item.name;
                                },
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Dòng xe quan tâm",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: titleBlackColor,
                                      ),
                                    ),
                                    // TextSpan(
                                    //   text: " *",
                                    //   style: TextStyle(
                                    //     fontSize: 16,
                                    //     color: starColor,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              DropdownSearch<CodeName>(
                                popupProps: const PopupProps.menu(
                                  showSelectedItems: true,
                                ),
                                compareFn:
                                    (CodeName? value1, CodeName? value2) {
                                  return false;
                                },
                                items: controller.carModelLst,
                                dropdownDecoratorProps:
                                    const DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                  labelText: "",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                )),
                                clearButtonProps: ClearButtonProps(
                                    isVisible: (controller.opportunityModel
                                                .carMode.value.name ==
                                            "")
                                        ? false
                                        : true,
                                    padding: const EdgeInsets.only(left: 8)),
                                onChanged: (value) {
                                  controller.opportunityModel.carMode.value =
                                      value ?? CodeName('', '');
                                },
                                selectedItem:
                                    controller.opportunityModel.carMode.value,
                                itemAsString: (item) {
                                  return item.name;
                                },
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "Ngân sách dự kiến (Triệu vnd)",
                                style: TextStyle(
                                    color: titleBlackColor, fontSize: 16),
                              ),
                              TextField(
                                controller: budgetPlanController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [ThousandsFormatter()],
                                style: const TextStyle(fontSize: 16),
                                decoration: InputDecoration(
                                    hintText: "0",
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        budgetPlanController.text = "";
                                        controller.opportunityModel.budgetPlan
                                            .value = 0.0;
                                      },
                                      icon: const Icon(Icons.close),
                                    )),
                                onChanged: (value) {
                                  var formatValue = double.tryParse(
                                          value.replaceAll(",", "")) ??
                                      0.0;
                                  controller.opportunityModel.budgetPlan.value =
                                      formatValue;
                                  // controller.workCreateDataModel.location.value = value;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "Chương trình marketing",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: titleBlackColor,
                                ),
                              ),
                              DropdownSearch<MarketingStrategyData>(
                                popupProps: const PopupProps.menu(
                                  showSelectedItems: true,
                                ),
                                compareFn: (MarketingStrategyData? value1,
                                    MarketingStrategyData? value2) {
                                  return false;
                                },
                                asyncItems: (value) async {
                                  return await IDealerApiService
                                      .getMarketingStrategy();
                                },
                                dropdownDecoratorProps:
                                    const DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                  labelText: "",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                )),
                                clearButtonProps: ClearButtonProps(
                                    isVisible: (controller
                                                .opportunityModel
                                                .marketingData
                                                .value
                                                .campaignCode ==
                                            null)
                                        ? false
                                        : true,
                                    padding: const EdgeInsets.only(left: 8)),
                                onChanged: (value) {
                                  controller.opportunityModel.marketingData
                                      .value = value ?? MarketingStrategyData();
                                },
                                selectedItem: controller
                                    .opportunityModel.marketingData.value,
                                itemAsString: (item) {
                                  return item.campaignName ?? "";
                                },
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextOptionWidget(
                                  title: "Ngày dự kiến ký hợp đồng",
                                  content: controller.opportunityModel
                                      .planSignContractDate.value,
                                  isClear: (controller.opportunityModel
                                              .planSignContractDate.value ==
                                          "")
                                      ? false
                                      : true,
                                  clearListener: () {
                                    controller.opportunityModel
                                        .planSignContractDate.value = "";
                                  },
                                  iconData: Icons.calendar_month,
                                  optionListener: () {
                                    controller.setContactPlanDateTime(context);
                                  }),
                              const Text(
                                "Ghi chú",
                                style: TextStyle(
                                    color: titleBlackColor, fontSize: 16),
                              ),
                              TextField(
                                controller: remarkController,
                                style: const TextStyle(fontSize: 16),
                                maxLines: null,
                                onChanged: (value) {
                                  controller.opportunityModel.remark.value =
                                      value;
                                },
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
                                    padding: EdgeInsets.zero,
                                    onPressed: () async {
                                      var result = await CustomerScreen.show();
                                      if (result != null) {
                                        // controller.opportunityModel.cusCode
                                        //     .value = result.customerCode ?? "";
                                        // controller.opportunityModel.cusName
                                        //     .value = result.fullName ?? "";
                                        // controller.opportunityModel.cusPhone
                                        //     .value = result.phoneNo ?? "";
                                        // controller.opportunityModel.email
                                        //     .value = result.email ?? "";
                                        controller.opportunityModel
                                            .dealerCusContract.value = result;
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
                                isStar: true,
                                content: controller.opportunityModel
                                        .dealerCusContract.value.customerCode ??
                                    "",
                              ),
                              TextTitleWidget(
                                title: "Tên khách hàng",
                                isStar: true,
                                content: controller.opportunityModel
                                        .dealerCusContract.value.fullName ??
                                    "",
                              ),
                              TextTitleWidget(
                                title: "Điện thoại khách hàng",
                                isStar: true,
                                content: controller.opportunityModel
                                        .dealerCusContract.value.phoneNo ??
                                    "",
                              ),
                              TextTitleWidget(
                                title: "Email",
                                content: controller.opportunityModel
                                        .dealerCusContract.value.email ??
                                    "",
                              ),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Nguồn khách hàng ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: titleBlackColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "*",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: starColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              DropdownSearch<CustomerSourceData>(
                                popupProps: const PopupProps.menu(
                                  showSelectedItems: true,
                                ),
                                compareFn: (CustomerSourceData? value1,
                                    CustomerSourceData? value2) {
                                  return false;
                                },
                                asyncItems: (value) async {
                                  return await IDealerApiService
                                      .getCustomerSource();
                                },
                                dropdownDecoratorProps:
                                    const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                      labelText: "",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero),
                                ),
                                clearButtonProps: ClearButtonProps(
                                    isVisible: (controller
                                                .opportunityModel
                                                .cusSourceData
                                                .value
                                                .customerBaseCode ==
                                            null)
                                        ? false
                                        : true,
                                    padding: const EdgeInsets.only(left: 8)),
                                onChanged: (value) {
                                  controller.opportunityModel.cusSourceData
                                      .value = value ?? CustomerSourceData();
                                },
                                selectedItem: controller
                                    .opportunityModel.cusSourceData.value,
                                itemAsString: (item) {
                                  return item.customerBaseName ?? "";
                                },
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Model tiềm năng",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: titleBlackColor,
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        var result =
                                            await ModelOpportunityDialog.show();
                                        if (result != null) {
                                          controller.opportunityModel
                                              .sPSalesProcessDtls
                                              .add(result);
                                          setState(() {});
                                        }
                                      },
                                      child: const Text(
                                        "Thêm mới",
                                        style: TextStyle(fontSize: 14),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              ItemModelWidget(
                                  cusName: "Mã model",
                                  module: "Số lượng",
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
                                itemCount: controller
                                    .opportunityModel.sPSalesProcessDtls.length,
                                itemBuilder: (context, index) {
                                  return ItemModelWidget(
                                      cusName: controller
                                              .opportunityModel
                                              .sPSalesProcessDtls[index]
                                              .modelCode ??
                                          "",
                                      module: controller.opportunityModel
                                              .sPSalesProcessDtls[index].qty ??
                                          "",
                                      textSize: 13,
                                      isDelete: true,
                                      deleteListener: () {
                                        controller
                                            .opportunityModel.sPSalesProcessDtls
                                            .removeAt(index);
                                        setState(() {});
                                      },
                                      fontWeight: FontWeight.normal);
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              if (widget.mode != OpportunityCreateMode.detail)
                                Row(
                                  children: [
                                    Expanded(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              controller.saveOpportunityClick();
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
                width: 12,
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
    this.iconData = Icons.arrow_drop_down,
    this.isClear = false,
    required this.optionListener,
    this.clearListener,
  }) : super(key: key);
  final String title;
  final String content;
  IconData? iconData;
  final VoidCallback optionListener;
  bool? isClear;
  final VoidCallback? clearListener;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: titleBlackColor,
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
              if (isClear == true)
                GestureDetector(
                    onTap: () {
                      clearListener?.call();
                    },
                    child: const Icon(Icons.clear, color: Colors.black38)),
              if (isClear == true)
                const SizedBox(
                  width: 20,
                ),
              Icon(
                iconData,
                color: blackColor,
              ),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
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
