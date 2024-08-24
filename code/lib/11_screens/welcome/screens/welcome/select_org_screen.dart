import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idealer/04_core_modules/user_session/api/requests/user_info/response/select_org_response/select_org_response.dart';
import 'package:idealer/04_core_modules/user_session/api/user_session_api_service.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/05_main_app/main_app.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';

class SelectOrgScreen extends StatefulWidget {
  SelectOrgScreen({Key? key, required this.listOrg, required this.isError})
      : super(key: key);
  bool isError = false;
  final List<LstOSInosOrg> listOrg;

  static Future<bool?> show({bool isReload = false}) async {
    SelectOrgScreen screen;

    try {
      // lấy danh sách org được cấp quyền theo user-password
      var response = await UserSessionApiService.getOrgList();
      // log("TAG : AAAAAAAAAAAA : ${response.success}");

      if (response.isSuccess()) {
        screen =
            SelectOrgScreen(listOrg: response.lstOSInosOrg!, isError: false);
        // log("TAG : AAAAAAAAAAAA");
        // UserSessionController.instance().setOrg(response.lstOSInosOrg!);
      } else {
        screen = SelectOrgScreen(listOrg: [], isError: false);
      }
    } catch (e) {
      screen = SelectOrgScreen(listOrg: [], isError: true);
    }

    return MainGet.offAll(screen);
  }

  @override
  State<SelectOrgScreen> createState() => _SelectOrgScreenState();
}

class _SelectOrgScreenState extends State<SelectOrgScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chọn org"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.isError || widget.listOrg.isEmpty)
            Expanded(
              child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      SelectOrgScreen.show(isReload: true);
                    },
                    child: const Text("Thử lại")),
              ),
            ),
          Expanded(
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        UserSessionController.instance()
                            .saveOrg(widget.listOrg[index]);
                        MainApp.restartToHome();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        // color: Colors.grey,
                        decoration: BoxDecoration(
                          color: kSelectOrgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                                "assets/icons/ic_organization.svg"),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                widget.listOrg[index].name ?? "",
                                textAlign: TextAlign.left,
                                maxLines: null,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: widget.listOrg.length,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: const Divider(height: 2, color: Colors.black),
          ),
          SizedBox(
            height: 20.0 * 5,
            child: Center(
              child: TextButton(
                onPressed: () async {
                  await UserSessionController.instance().signOut();
                  MainApp.restartToWelcome();
                },
                child: const Text(
                  "ĐĂNG XUẤT",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
