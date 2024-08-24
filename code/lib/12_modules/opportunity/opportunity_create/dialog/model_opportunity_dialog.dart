import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';
import 'package:idealer/11_apis/core/models/car_color_data.dart';
import 'package:idealer/11_apis/core/models/car_model_data.dart';
import 'package:idealer/11_apis/core/models/car_spec_data.dart';
import 'package:idealer/11_apis/core/models/sp_sales_process_search_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';

class ModelOpportunityDialog extends StatefulWidget {
  const ModelOpportunityDialog({Key? key}) : super(key: key);

  static Future<ListSalesProcessDtl>? show() async {
    return await Get.dialog(const ModelOpportunityDialog());
  }

  @override
  State<ModelOpportunityDialog> createState() => _ModelOpportunityDialogState();
}

class _ModelOpportunityDialogState extends State<ModelOpportunityDialog> {
  Rx<CarModelData> carModelData = CarModelData().obs;
  Rx<CarSpecData> carSpecData = CarSpecData().obs;
  Rx<CarColorData> carColorData = CarColorData().obs;
  late TextEditingController numberController;
  int qty = 0;

  @override
  void initState() {
    // TODO: implement initState
    numberController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(8),
      title: Stack(
        children: [
          Container(
            height: 50,
            padding: EdgeInsets.only(left: 12),
            decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Chọn đặc tả xe",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                )),
          ),
        ],
      ),
      content: Obx(() => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Mã model *",
                    style: TextStyle(
                      fontSize: 16,
                      color: titleBlackColor,
                    ),
                  ),
                  DropdownSearch<CarModelData>(
                    popupProps: const PopupProps.menu(
                      showSelectedItems: true,
                    ),
                    compareFn: (CarModelData? value1, CarModelData? value2) {
                      return false;
                    },
                    asyncItems: (value) async {
                      return await IDealerApiService.getCarModel();
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      labelText: "",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    )),
                    // clearButtonProps: ClearButtonProps(
                    //     isVisible: (controller.opportunityModel.marketingData.value.campaignCode == null) ? false: true,
                    //     padding: const EdgeInsets.only(left: 8)),
                    onChanged: (value) {
                      carModelData.value = value ?? CarModelData();
                    },
                    selectedItem: carModelData.value,
                    itemAsString: (item) {
                      return (item.modelCode == null)
                          ? ""
                          : "${item.modelCode} - ${item.modelName}";
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
                    "Mã spec *",
                    style: TextStyle(
                      fontSize: 16,
                      color: titleBlackColor,
                    ),
                  ),
                  DropdownSearch<CarSpecData>(
                    popupProps: const PopupProps.menu(
                      showSelectedItems: true,
                    ),
                    compareFn: (CarSpecData? value1, CarSpecData? value2) {
                      return false;
                    },
                    asyncItems: (value) async {
                      if (carModelData.value.modelCode == null ||
                          carColorData.value.modelCode == "") {
                        MainGet.showToast("Yêu cầu chọn mã model trước");
                        return [];
                      }
                      return await IDealerApiService.getCarSpec(
                          carModelData.value.modelCode ?? "");
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      labelText: "",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    )),
                    clearButtonProps: ClearButtonProps(
                        isVisible: (carSpecData.value.specCode == null ||
                                carSpecData.value.specCode == "")
                            ? false
                            : true,
                        padding: const EdgeInsets.only(left: 8)),
                    onChanged: (value) {
                      carSpecData.value = value ?? CarSpecData();
                    },
                    selectedItem: carSpecData.value,
                    itemAsString: (item) {
                      return (item.specCode == null)
                          ? ""
                          : "${item.specCode} - ${item.specDescription}";
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
                    "Mã màu *",
                    style: TextStyle(
                      fontSize: 16,
                      color: titleBlackColor,
                    ),
                  ),
                  DropdownSearch<CarColorData>(
                    popupProps: const PopupProps.menu(
                      showSelectedItems: true,
                    ),
                    compareFn: (CarColorData? value1, CarColorData? value2) {
                      return false;
                    },
                    asyncItems: (value) async {
                      if (carModelData.value.modelCode == null ||
                          carColorData.value.modelCode == "") {
                        MainGet.showToast("Yêu cầu chọn mã model trước");
                        return [];
                      }
                      return await IDealerApiService.getCarColor(
                          carModelData.value.modelCode ?? "");
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      labelText: "",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    )),
                    clearButtonProps: ClearButtonProps(
                        isVisible: (carColorData.value.colorCode == null)
                            ? false
                            : true,
                        padding: const EdgeInsets.only(left: 8)),
                    onChanged: (value) {
                      carColorData.value = value ?? CarColorData();
                    },
                    selectedItem: carColorData.value,
                    itemAsString: (item) {
                      return (item.colorCode == null)
                          ? ""
                          : "${item.colorExtNameVn}/${item.colorIntNameVn}";
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
                    "Số lượng *",
                    style: TextStyle(color: titleBlackColor, fontSize: 16),
                  ),
                  TextField(
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 16),
                    maxLines: null,
                    onChanged: (value) {
                      qty = int.tryParse(value) ?? 0;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                saveClick();
                              },
                              child: const Text(
                                "Đồng ý",
                                style: TextStyle(fontSize: 16),
                              ))),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void saveClick() {
    if (carModelData.value.modelCode == null ||
        carModelData.value.modelCode == "") {
      MainGet.showToast("Yêu cầu nhập mã Model");
      return;
    }
    if (carSpecData.value.modelCode == null ||
        carSpecData.value.modelCode == "") {
      MainGet.showToast("Yêu cầu nhập mã Spec");
      return;
    }
    if (carColorData.value.modelCode == null ||
        carColorData.value.modelCode == "") {
      MainGet.showToast("Yêu cầu nhập mã Màu");
      return;
    }
    if (qty <= 0) {
      MainGet.showToast("Số lượng phải là số tự nhiên lớn hơn 0");
      return;
    }
    ListSalesProcessDtl sPSalesProcessDtl = ListSalesProcessDtl();
    sPSalesProcessDtl.salesId = "";
    sPSalesProcessDtl.modelCode = carModelData.value.modelCode;
    sPSalesProcessDtl.colorCode = carColorData.value.colorCode;
    sPSalesProcessDtl.specCode = carSpecData.value.specCode;
    sPSalesProcessDtl.qty = qty.toString();
    sPSalesProcessDtl.spStatusDtl = carColorData.value.status;
    sPSalesProcessDtl.remark = carColorData.value.remark;
    sPSalesProcessDtl.modelName = carModelData.value.modelName;
    sPSalesProcessDtl.specDesc = carSpecData.value.specDescription;
    sPSalesProcessDtl.namSanXuat = carSpecData.value.namSanXuat;
    sPSalesProcessDtl.xuatXu = carSpecData.value.xuatXu;
    sPSalesProcessDtl.colorIntNameVn = carColorData.value.colorIntNameVn;
    sPSalesProcessDtl.colorExtNameVn = carColorData.value.colorExtNameVn;
    sPSalesProcessDtl.price = carSpecData.value.price;
    sPSalesProcessDtl.vat = "";
    sPSalesProcessDtl.giaTruocVat = "";
    sPSalesProcessDtl.tongTienTruocVat = "";
    sPSalesProcessDtl.tongTienSauVat = "";

    Get.back(result: sPSalesProcessDtl);
  }
}
