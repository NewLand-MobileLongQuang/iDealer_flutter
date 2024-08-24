import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/11_screens/business_logic/permission_idealer.dart';
import 'package:idealer/11_screens/home/home_page.dart';
import 'package:idealer/11_screens/home/ui/items/item_idealer.dart';
import 'package:permission_handler/permission_handler.dart';

class MenuDialog extends StatefulWidget {
  const MenuDialog({Key? key, required this.selectMenu}) : super(key: key);
  final SelectMenu selectMenu;
  static Future<SelectMenuDetail>? show(selectMenu) async {
    return await Get.dialog(MenuDialog(selectMenu: selectMenu));
  }

  @override
  State<MenuDialog> createState() => _MenuDialogState();
}

class _MenuDialogState extends State<MenuDialog> {
  List<Widget> listItem = [];

  @override
  void initState() {
    // TODO: implement initState
    setShowMenu();
    super.initState();
  }

  void setShowMenu() {
    if (widget.selectMenu == SelectMenu.customer) {
      if (PermissionIdealer.instance().isPermissionCusCreate){
        listItem.add(
          ItemIdealer(
              title: "Tạo khách hàng",
              icon: "assets/menu/ic_add_user.png",
              itemClick: () {
                Get.back(result: SelectMenuDetail.cusCreate);
              }),
        );
      }

      if (PermissionIdealer.instance().isPermissionCusManager){
      listItem.add(
        ItemIdealer(
            title: "Quản lý khách hàng",
            icon: "assets/menu/ic_manager_user.png",
            itemClick: () {
              Get.back(result: SelectMenuDetail.cusManager);
            }),
      );}
    }
    if (widget.selectMenu == SelectMenu.opportunity) {
      if (PermissionIdealer.instance().isPermissionOpportunityCreate){
      listItem.add(
        ItemIdealer(
            title: "Tạo cơ hội",
            icon: "assets/menu/ic_taocohoi.png",
            itemClick: () {
              Get.back(result: SelectMenuDetail.opCreate);
            }),
      );}
      if (PermissionIdealer.instance().isPermissionOpportunityManager){
      listItem.add(
        ItemIdealer(
            title: "Quản lý cơ hội",
            icon: "assets/menu/ic_quanlycohoi.png",
            itemClick: () {
              Get.back(result: SelectMenuDetail.opManager);
            }),
      );}
    }
    if (widget.selectMenu == SelectMenu.work) {
      if (PermissionIdealer.instance().isPermissionWorkSchedule){
      listItem.add(
        ItemIdealer(
            title: "Lịch công việc",
            icon: "assets/menu/ic_lichcv.png",
            itemClick: () {
              Get.back(result: SelectMenuDetail.workSchedule);
            }),
      );}

      if (PermissionIdealer.instance().isPermissionCusManager){
      listItem.add(
        ItemIdealer(
            title: "Quản lý công việc",
            icon: "assets/menu/ic_quanlycv.png",
            itemClick: () {
              Get.back(result: SelectMenuDetail.workManager);
            }),
      );}
    }

    if (widget.selectMenu == SelectMenu.report) {
      if (PermissionIdealer.instance().isPermissionReportSyntheticVehicle){
      listItem.add(
        ItemIdealer(
            title: "Tổng hợp xe đại lý",
            icon: "assets/menu/ic_tonghopxedl.png",
            itemClick: () {
              Get.back(result: SelectMenuDetail.reportCarTotal);
            }),
      );}

      if (PermissionIdealer.instance().isPermissionReportRetain){
      listItem.add(
        ItemIdealer(
            title: "Tồn kho",
            icon: "assets/menu/ic_tonkho.png",
            itemClick: () {
              Get.back(result: SelectMenuDetail.reportRetain);
            }),
      );}
    }
  }

  @override
  Widget build(BuildContext context) {
    double number = 3.5;
    if (listItem.length > 1){
      number = 4.0* listItem.length;
    }
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/(number)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            alignment: Alignment.center,
            child: GridView.count(
              crossAxisCount: (listItem.isEmpty)? 2 : listItem.length,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: listItem,
            ),
          ),
        ],
      ),
    );
  }
}
