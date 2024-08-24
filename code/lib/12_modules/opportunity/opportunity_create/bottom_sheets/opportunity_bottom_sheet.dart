import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';

enum OpportunitySelect { edit, detail, delete }

class OpportunityBottomSheet extends StatelessWidget {
  const OpportunityBottomSheet({Key? key, required this.usStatus})
      : super(key: key);
  final String usStatus;

  static Future<OpportunitySelect>? show(String usStatus) async {
    return await Get.bottomSheet(OpportunityBottomSheet(
      usStatus: usStatus,
    ));
  }

  @override
  Widget build(BuildContext context) {
    bool checkOpportunity = false;
    if (usStatus != "KYHOPDONG") {
      if (usStatus != "HUY") {
        checkOpportunity = true;
      }
    }
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, //tự co kích thước về nội dung
              children: [
                if (checkOpportunity)
                  Center(
                    child: GestureDetector(
                        onTap: () {
                          Get.back(result: OpportunitySelect.edit);
                        },
                        child: Container(
                            width: 200,
                            height: 40,
                            color: Colors.transparent,
                            child: const Center(child: Text("Sửa cơ hội")))),
                  ),
                if (checkOpportunity)
                  const Divider(
                    height: 1,
                  ),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        Get.back(result: OpportunitySelect.detail);
                      },
                      child: Container(
                          width: 200,
                          height: 40,
                          color: Colors.transparent,
                          child: const Center(child: Text("Chi tiết cơ hội")))),
                ),
                const Divider(
                  height: 1,
                ),
                if (checkOpportunity)
                  Center(
                    child: GestureDetector(
                        onTap: () {
                          Get.back(result: OpportunitySelect.delete);
                        },
                        child: Container(
                            width: 200,
                            height: 40,
                            color: Colors.transparent,
                            child: const Center(
                                child: Text(
                              "Hủy cơ hội",
                              style: TextStyle(color: Colors.red),
                            )))),
                  ),
                if (checkOpportunity)
                  const Divider(
                    height: 1,
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Hủy",
                    style: TextStyle(
                        color: titleBlackColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ))),
        ],
      ),
    );
  }
}
