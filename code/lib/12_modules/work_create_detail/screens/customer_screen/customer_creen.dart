import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/base_controller/view/data_view.dart';
import 'package:idealer/11_apis/core/models/dealer_customer_contact_search_data.dart';
import 'package:idealer/12_modules/work_create_detail/screens/customer_screen/controller/customer_controller.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  static Future<DealerCustomerContactSearchData>? show() async {
    return await Get.to(const CustomerScreen());
  }

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late TextEditingController cusNameController;
  late TextEditingController phoneController;
  late CustomerController controller;

  @override
  void initState() {
    // TODO: implement initState
    cusNameController = TextEditingController();
    phoneController = TextEditingController();
    controller = CustomerController();
    controller.reload();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cusNameController.dispose();
    phoneController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Khách hàng",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: DataView<List<DealerCustomerContactSearchData>>(
        controller: controller,
        builder: (ct, data) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextFormField(
                  controller: cusNameController,
                  decoration: const InputDecoration(
                      labelText: "Tên khách hàng",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(left: 12, right: 12)),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      labelText: "Điện thoại",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(left: 12, right: 12)),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              controller.fullName.value =
                                  cusNameController.text;
                              controller.phoneNo.value = phoneController.text;
                              controller.setReload(controller);
                            },
                            child: const Text(
                              "Tìm kiếm khách hàng",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )))
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const ItemCustomerWidget(
                    cusName: "Mã khách hàng",
                    module: "Tên khách hàng",
                    textSize: 15,
                    fontWeight: FontWeight.bold),
                Expanded(
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                      );
                    },
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Get.back(result: data[index]);
                          },
                          child: ItemCustomerWidget(
                              cusName: data[index].customerCode ?? "",
                              module: data[index].fullName ?? "",
                              textSize: 13,
                              fontWeight: FontWeight.normal));
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
    );
  }
}

class ItemCustomerWidget extends StatelessWidget {
  const ItemCustomerWidget(
      {Key? key,
      required this.cusName,
      required this.module,
      required this.textSize,
      required this.fontWeight})
      : super(key: key);
  final String cusName;
  final String module;
  final double textSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 8, 0, 8),
      child: Row(
        children: [
          Expanded(
              child: Text(
            cusName,
            style: TextStyle(
                fontWeight: fontWeight, fontSize: textSize, color: blackColor),
            textAlign: TextAlign.center,
          )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(
            module,
            style: TextStyle(
                fontWeight: fontWeight, fontSize: textSize, color: blackColor),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }
}
