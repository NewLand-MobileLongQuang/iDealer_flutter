import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/base_controller/base_controller.dart';
import 'package:idealer/10_app_commons/base_controller/view/data_view.dart';
import 'package:idealer/10_app_commons/custom/name_circle_avatar.dart';
import 'package:idealer/10_app_commons/custom/search_field.dart';
import 'package:idealer/11_apis/core/models/zalo_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';

class ChooseZaloController extends BaseController<List<ZaloData>> {
  ChooseZaloController() {
    loadLimit = 100;
    pageSize = 100;
  }
  String keyword = "";

  @override
  Future<List<ZaloData>> load(int loadLimit) async {
    return IDealerApiService.getZalos(keyword);
  }

  void setNewKeyword(String newKeyword) {
    keyword = newKeyword;
    reload();
  }
}

class ChooseZaloDialog extends StatefulWidget {
  const ChooseZaloDialog({Key? key}) : super(key: key);

  static Future<ZaloData?> show() {
    return Get.dialog(const ChooseZaloDialog());
  }

  @override
  State<ChooseZaloDialog> createState() => _ChooseZaloDialogState();
}

class _ChooseZaloDialogState extends State<ChooseZaloDialog> {
  late ChooseZaloController viewModel;

  @override
  void initState() {
    // TODO: implement initState
    viewModel = ChooseZaloController();
    viewModel.addListener(() {
      setState(() {});
    });
    viewModel.reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      // titlePadding: EdgeInsets.zero,
      // contentPadding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 45,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              alignment: Alignment.center,
              child: const Text(
                "Zalo",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey[100]),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              height: kToolbarHeight,
              child: Row(
                children: [
                  Expanded(
                    child: SearchField(
                      autoFocus: true,
                      onSearch: (query) {
                        viewModel.setNewKeyword(query);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: DataView<List<ZaloData>>(
                controller: viewModel,
                builder: (context, data) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text("không có dũ liệu"),
                    );
                  }

                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(data[index]);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: true
                                ? null
                                : BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              leading: NamedCircleAvatar(
                                name: data[index].displayName,
                                avatar: data[index].avatar,
                                size: 18,
                              ),
                              title: Text(data[index].displayName ?? ""),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                            height: 0.5, color: Color(int.parse('0xFFC8C8C8')));
                      },
                      itemCount: data.length);
                },
                useLoading: true,
                usePullDown: true,
                //overrideOnPullDown: (){},
                usePullUp: true,
                //overrideOnPullUp : (){},,
                reverse: false,
                // loadingEmptyWidget: Container(),
                showDataOnLoading: false,
                errorEmptyWidget:
                    const Center(child: Text("Không có dữ liệu.")),
                showDataOnError: false,
                // errorDataBuilder: (context, data) {
                //   return const Center(child: Text("Không có dữ liệu."));
                // },
                //successEmptyWidget: Container(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
