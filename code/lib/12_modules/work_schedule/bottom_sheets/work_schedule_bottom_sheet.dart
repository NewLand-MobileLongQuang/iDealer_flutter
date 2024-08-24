import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/12_modules/work_create_detail/buisiness_logic/level_status.dart';

enum WorkSelect { edit, detail, delete }

/**
 * Khi chọn vào item công việc thì bật bottom sheet:
 * + Sửa công việc
 * + Chi tiết công việc
 * + Xóa công việc
 */

class WorkScheduleBottomSheet extends StatelessWidget {
  const WorkScheduleBottomSheet({Key? key, required this.usStatus})
      : super(key: key);
  final String usStatus;

  static Future<WorkSelect>? show(String usStatus) async {
    return await Get.bottomSheet(WorkScheduleBottomSheet(
      usStatus: usStatus,
    ));
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
              children: [
                if (LevelStatusExt.fromApiName(usStatus) == LevelStatus.P)
                  Center(
                    child: GestureDetector(
                        onTap: () {
                          Get.back(result: WorkSelect.edit);
                        },
                        child: Container(
                            width: 200,
                            height: 40,
                            color: Colors.transparent,
                            child: const Center(child: Text("Sửa công việc")))),
                  ),
                if (LevelStatusExt.fromApiName(usStatus) == LevelStatus.P)
                  const Divider(
                    height: 1,
                  ),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        Get.back(result: WorkSelect.detail);
                      },
                      child: Container(
                          width: 200,
                          height: 40,
                          color: Colors.transparent,
                          child:
                              const Center(child: Text("Chi tiết công việc")))),
                ),
                const Divider(
                  height: 1,
                ),
                if (LevelStatusExt.fromApiName(usStatus) == LevelStatus.P)
                  Center(
                    child: GestureDetector(
                        onTap: () {
                          Get.back(result: WorkSelect.delete);
                        },
                        child: Container(
                            width: 200,
                            height: 40,
                            color: Colors.transparent,
                            child: const Center(
                                child: Text(
                              "Xóa công việc",
                              style: TextStyle(color: Colors.red),
                            )))),
                  ),
                if (LevelStatusExt.fromApiName(usStatus) == LevelStatus.P)
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
