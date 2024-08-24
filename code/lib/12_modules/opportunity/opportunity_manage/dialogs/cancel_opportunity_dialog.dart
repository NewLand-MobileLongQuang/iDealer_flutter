import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';
import 'package:idealer/11_apis/core/models/reason_cancel_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';

class CancelOpportunityDialog extends StatefulWidget {
  const CancelOpportunityDialog({Key? key, required this.salesId})
      : super(key: key);
  final String salesId;

  static Future<bool>? show(String salesId) async {
    return await Get.dialog(CancelOpportunityDialog(salesId: salesId));
  }

  @override
  State<CancelOpportunityDialog> createState() =>
      _ModelOpportunityDialogState();
}

class _ModelOpportunityDialogState extends State<CancelOpportunityDialog> {
  Rx<ReasonCancelData> reasonData = ReasonCancelData().obs;
  late TextEditingController decsController;
  late TextEditingController salesIdController;

  @override
  void initState() {
    // TODO: implement initState
    decsController = TextEditingController();
    salesIdController = TextEditingController(text: widget.salesId);
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
            padding: const EdgeInsets.only(left: 12),
            decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Hủy cơ hội",
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    enabled: false,
                    controller: salesIdController,
                    decoration: const InputDecoration(
                        labelText: "Mã cơ hội",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownSearch<ReasonCancelData>(
                    popupProps: const PopupProps.menu(
                      showSelectedItems: true,
                    ),
                    compareFn:
                        (ReasonCancelData? value1, ReasonCancelData? value2) {
                      return false;
                    },
                    asyncItems: (value) async {
                      return await IDealerApiService.getReasonCancel("");
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      labelText: "Lý do hủy *",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(left: 12),
                    )),
                    // clearButtonProps: ClearButtonProps(
                    //     isVisible: (reasonData.value.spCancelReasonCode == null)
                    //         ? false
                    //         : true,
                    //     padding: const EdgeInsets.only(left: 8)),
                    onChanged: (value) {
                      reasonData.value = value ?? ReasonCancelData();
                      decsController.text =
                          reasonData.value.spCancelReasonName ?? "";
                      setState(() {});
                    },
                    selectedItem: reasonData.value,
                    itemAsString: (item) {
                      return (item.spCancelReasonCode == null)
                          ? ""
                          : "${item.spCancelReasonCode} - ${item.spCancelReasonName}";
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: decsController,
                    decoration: const InputDecoration(
                        labelText: "Mô tả",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 12, right: 12)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                cancelClick();
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

  void cancelClick() async {
    if (reasonData.value.spCancelReasonCode == null ||
        reasonData.value.spCancelReasonCode == "") {
      MainGet.showToast("Yêu cầu chọn lý do hủy");
      return;
    }
    print(
        "reasonData.value.spCancelReasonCode ${reasonData.value.spCancelReasonCode}");
    print("salesId ${widget.salesId}");
    try {
      var future = IDealerApiService.cancelOpportunity(
          widget.salesId, reasonData.value.spCancelReasonCode ?? "");
      var result = await MainGet.showHudProgress(future);
      if (result == true) {
        Get.back(result: true);
      } else {
        MainGet.showToast("Hủy thất bại");
      }
    } catch (error) {
      MainGet.showToast("Hủy thất bại");
    }
  }
}
