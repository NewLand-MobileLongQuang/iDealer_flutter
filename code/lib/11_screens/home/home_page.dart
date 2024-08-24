import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/05_main_app/main_app.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';
import 'package:idealer/11_screens/home/ui/dialogs/menu_dialog.dart';
import 'package:idealer/11_screens/home/ui/dialogs/notification_dialog.dart';
import 'package:idealer/11_screens/home/ui/items/item_idealer.dart';
import 'package:idealer/11_screens/welcome/screens/componets/background.dart';
import 'package:idealer/12_modules/customer/create_customer/controller/create_customer_controller.dart';
import 'package:idealer/12_modules/opportunity/opportunity_create/controller/opportunity_create_controller.dart';
import 'package:idealer/12_modules/opportunity/opportunity_create/opportunity_create_screen.dart';
import 'package:idealer/12_modules/opportunity/opportunity_manage/opportunity_manage_screen.dart';
import 'package:idealer/12_modules/customer/create_customer/screen/create_customer_screen.dart';
import 'package:idealer/12_modules/customer/manage_customer/screeen/manage_customer_screen.dart';
import 'package:idealer/12_modules/reports/report_retain/screens/report_retain_screen.dart';
import 'package:idealer/12_modules/reports/report_synthetic_vehicle/report_synthetic_vehicle_screen.dart';
import 'package:idealer/12_modules/work_manager/work_manage_screen.dart';
import 'package:idealer/12_modules/work_schedule/work_schedule_screen.dart';

enum SelectMenu { customer, opportunity, work, report }

enum SelectMenuDetail {
  cusCreate,
  cusManager,
  opCreate,
  opManager,
  workSchedule,
  workManager,
  reportCarTotal,
  reportRetain
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> listItem = [];
  Rx<int> numberNotify = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    listItem.add(ItemIdealer(
        title: "Khách hàng",
        icon: "assets/menu/ic_customer.png",
        itemClick: () {
          menuClick(SelectMenu.customer);
        }));
    listItem.add(ItemIdealer(
        title: "Cơ hội",
        icon: "assets/menu/ic_opportunity.png",
        itemClick: () {
          menuClick(SelectMenu.opportunity);
        }));
    listItem.add(ItemIdealer(
        title: "Công việc",
        icon: "assets/menu/ic_work.png",
        itemClick: () {
          menuClick(SelectMenu.work);
        }));
    listItem.add(ItemIdealer(
        title: "Báo cáo",
        icon: "assets/menu/ic_report.png",
        itemClick: () {
          menuClick(SelectMenu.report);
        }));

    notificationStart();

    super.initState();
  }

  void notificationStart() async {
    var result = await IDealerApiService.getWkUserSchedule(
        AppConfig.instance().dateFormat.format(DateTime.now()),
        AppConfig.instance().dateFormat.format(DateTime.now()),
        "P",
        "",
        "",
        0,
        300);
    if ((result.listElement ?? []).isNotEmpty) {
      numberNotify.value = (result.listElement ?? []).length;
    }
  }

  void menuClick(SelectMenu selectMenu) async {
    switch (selectMenu) {
      case SelectMenu.customer:
        var result = await MenuDialog.show(selectMenu);
        if (result == SelectMenuDetail.cusCreate) {
          CreateCustomerScreen.show(CreateCustomerControllerMode.create);
        }
        if (result == SelectMenuDetail.cusManager) {
          ManageCustomerScreen.show();
        }
        break;
      case SelectMenu.opportunity:
        var result = await MenuDialog.show(selectMenu);
        if (result == SelectMenuDetail.opCreate) {
          OpportunityCreateScreen.show(OpportunityCreateMode.create, "");
        }
        if (result == SelectMenuDetail.opManager) {
          OpportunityManageScreen.show();
        }
        break;
      case SelectMenu.work:
        var result = await MenuDialog.show(selectMenu);
        if (result == SelectMenuDetail.workSchedule) {
          WorkScheduleScreen.show();
        }
        if (result == SelectMenuDetail.workManager) {
          WorkManageScreen.show();
        }
        break;
      case SelectMenu.report:
        var result = await MenuDialog.show(selectMenu);
        if (result == SelectMenuDetail.reportCarTotal) {
          ReportSyntheticVehicleScreen.show();
        }
        if (result == SelectMenuDetail.reportRetain) {
          ReportRetainScreen.show();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("IDealer"),
        title: const Text("VELOCA"),
        actions: [
          GestureDetector(
            onTap: () {
              NotificationDialog.show();
            },
            child: Obx(() => badges.Badge(
                  badgeContent: Text(
                    numberNotify.value.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  position: const badges.BadgePosition(top: 0, end: -4),
                  padding: const EdgeInsets.all(5),
                  badgeColor: Colors.redAccent,
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                )),
          ),
          const SizedBox(
            width: 16,
          ),
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                  // value: 'white',
                child: TextButton(
                  // style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all(Colors.white)),
                  child: const Text(
                    "Đăng xuất",
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  onPressed: () async {
                    await UserSessionController.instance().signOut();
                    MainApp.restartToWelcome();
                  },
                ),
              ),
            ];
          }),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: const Background()),
          Center(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 8),
              shrinkWrap: true,
              children: listItem,
            ),
          ),
        ],
      ),
    );
  }
}
