import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';

enum CustomerSelect { edit, detail, delete }

class CustomerManageBottomSheet extends StatelessWidget {
  const CustomerManageBottomSheet({Key? key}) : super(key: key);

  static Future<CustomerSelect>? show() async {
    return await Get.bottomSheet(const CustomerManageBottomSheet());
  }

  @override
  Widget build(BuildContext context) {
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
                  Center(
                    child: GestureDetector(
                        onTap: () {
                          Get.back(result: CustomerSelect.edit);
                        },
                        child: Container(
                            width: 200,
                            height: 40,
                            color: Colors.transparent,
                            child:
                                const Center(child: Text("Sửa khách hàng")))),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  // Center(
                  //   child: GestureDetector(
                  //       onTap: () {
                  //         Get.back(result: WorkSelect.detail);
                  //       },
                  //       child: Container(
                  //           width: 200,
                  //           height: 40,
                  //           color: Colors.transparent,
                  //           child: const Center(
                  //               child: Text("Chi tiết công việc")))),
                  // ),
                  // const Divider(
                  //   height: 1,
                  // ),
                  Center(
                    child: GestureDetector(
                        onTap: () {
                          Get.back(result: CustomerSelect.delete);
                        },
                        child: Container(
                            width: 200,
                            height: 40,
                            color: Colors.transparent,
                            child: const Center(
                                child: Text(
                              "Xóa Khách hàng",
                              style: TextStyle(color: Colors.red),
                            )))),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  // const Divider(
                  //   height: 1,
                  // ),
                ],
              )),
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
