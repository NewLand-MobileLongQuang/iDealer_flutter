import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/11_apis/core/models/item_choice.dart';

class ChoiceCommonDialog extends StatelessWidget {
  const ChoiceCommonDialog(
      {Key? key, required this.title, required this.listString})
      : super(key: key);
  final String title;
  final List<String> listString;

  static Future<ItemChoice?>? show(String title, List<String> listString) {
    return Get.dialog(
        ChoiceCommonDialog(
          title: title,
          listString: listString,
        ),
        arguments: listString);
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
            decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
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
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.back(
                    result:
                        ItemChoice(name: listString[index], position: index));
              },
              child: Container(
                // color: Colors.transparent,
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                child: Text(
                  listString[index],
                  style: const TextStyle(
                    fontSize: 16,
                    color: blackColor,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 1,
            );
          },
          itemCount: listString.length,
        ),
      ),
    );
  }
}
