import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/base_controller/view/data_view.dart';
import 'package:idealer/11_apis/core/requests/get_wk_user_schedule/response/wk_user_schedule_response.dart';
import 'package:idealer/11_screens/app_bar_widget.dart';
import 'package:idealer/12_modules/work_create_detail/buisiness_logic/level_status.dart';
import 'package:idealer/12_modules/work_create_detail/controller/work_create_controller.dart';
import 'package:idealer/12_modules/work_schedule/items/item_work_day.dart';
import 'package:idealer/12_modules/work_create_detail/work_create_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import 'controller/work_schedule_controller.dart';

class WorkScheduleScreen extends StatefulWidget {
  const WorkScheduleScreen({Key? key}) : super(key: key);

  static Future<void> show() async {
    return await Get.to(const WorkScheduleScreen());
  }

  @override
  State<WorkScheduleScreen> createState() => _WorkScheduleScreenState();
}

class _WorkScheduleScreenState extends State<WorkScheduleScreen> {
  late WorkScheduleController controller;

  @override
  void initState() {
    // TODO: implement initState
    setData();
    super.initState();
  }

  Future<void> setData() async {
    controller = WorkScheduleController();
    controller.reload();
    await controller.getWorkInMonths(controller.selectedDay.value);
    controller.focusDay.value = controller.selectedDay.value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: "Lịch công việc"),
      body: DataView<WkUserScheduleResponse>(
        controller: controller,
        builder: (workController, data) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownSearch<String>(
                        itemAsString: (value) {
                          return value != null ? (value) : "";
                        },
                        onChanged: (value) {},
                        selectedItem: UserSessionController.instance()
                                .userInfo
                                ?.user
                                ?.userCode ??
                            "",
                        items: [
                          UserSessionController.instance().userInfo?.user?.userCode ??
                              ""
                        ],
                        // clearButtonProps: ClearButtonProps(isVisible: true),
                        // popupProps: PopupProps.dialog() ,
                      ),
                      Obx(
                        () => TableCalendar(
                          focusedDay: controller.focusDay.value,
                          firstDay: DateTime.utc(1900),
                          lastDay: DateTime.utc(2100),
                          startingDayOfWeek: StartingDayOfWeek
                              .sunday, // ngày bắt đầu là chủ nhật
                          daysOfWeekVisible: true, // hiển thị ngày trong tuần
                          availableGestures: AvailableGestures.none,
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false, // ẩn format button
                            titleCentered: true, // cho title header ra giữa
                          ),
                          calendarStyle: CalendarStyle(
                              isTodayHighlighted: true,
                              todayTextStyle:
                                  const TextStyle(color: Colors.red),
                              todayDecoration: const BoxDecoration(),
                              selectedDecoration: const BoxDecoration(
                                  color: Colors.blue, shape: BoxShape.circle),
                              selectedTextStyle: TextStyle(
                                  color: (AppConfig().dateFormat.format(
                                              controller.selectedDay.value) ==
                                          AppConfig()
                                              .dateFormat
                                              .format(DateTime.now()))
                                      ? Colors.red
                                      : Colors.white),
                              markerDecoration: const BoxDecoration(
                                color: Colors.orangeAccent,
                                shape: BoxShape.circle,
                              )),
                          onDaySelected:
                              (DateTime selectDay, DateTime focusDay) {
                            controller.setFilter(selectDay, controller);
                          },
                          selectedDayPredicate: (DateTime date) {
                            return isSameDay(controller.selectedDay.value,
                                date); // đổ màu cho ngày chọn
                          },
                          onHeaderTapped: (dateTime) async {
                            var newDate = await showDatePicker(
                                context: context,
                                initialDate: controller.selectedDay.value,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            if (newDate == null) return;
                            controller.setFilter(newDate, controller);
                            await controller.getWorkInMonths(newDate);
                            controller.focusDay.value = newDate;
                          },
                          onPageChanged: (dateTime) async {
                            await controller.getWorkInMonths(dateTime);
                            controller.focusDay.value = dateTime;
                          },

                          eventLoader: (dateTime) {
                            return controller.getEvents(dateTime);
                          },
                        ),
                      ),
                      const Text(
                        "Chú thích",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.orangeAccent),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                "Ngày có lịch",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                controller.addClick();
                              },
                              child: const Text(
                                "Tạo mới công việc",
                                style: TextStyle(fontSize: 13),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 8,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Công việc trong ngày",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text("Ghi chú:",
                                  style: TextStyle(
                                      fontSize: 14, color: blackColor)),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 12, right: 4),
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
                                    margin: const EdgeInsets.only(
                                        left: 12, right: 4),
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
                                    margin: const EdgeInsets.only(
                                        left: 12, right: 4),
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
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const ItemWorkDay(
                        // icon: Icons.sort,
                        workName: "Tên công việc",
                        cusName: "Khách hàng",
                        phone: "Số điện thoại",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        itemColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.itemClick(index);
                        },
                        child: ItemWorkDay(
                          // icon: Icons.settings,
                          workName:
                              (data.listElement ?? [])[index].kpiPlusName ?? "",
                          cusName:
                              (data.listElement ?? [])[index].fullName ?? "",
                          phone: (data.listElement ?? [])[index].phoneNo ?? "",
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          itemColor: LevelStatusExt.fromApiName(
                                  (data.listElement ?? [])[index].usStatus ??
                                      "")
                              ?.color,
                        ),
                      );
                    },
                    itemCount: data.listElement?.length ?? 0,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 1,
                      );
                    },
                  ),
                ),
              ],
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     controller.addClick();
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
