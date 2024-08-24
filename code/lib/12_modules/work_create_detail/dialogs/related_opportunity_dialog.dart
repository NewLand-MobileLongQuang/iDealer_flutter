import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';

class RelatedOpportunityDialog extends StatefulWidget {
  const RelatedOpportunityDialog({Key? key}) : super(key: key);

  static Future<void> show() {
    return Get.dialog(RelatedOpportunityDialog());
  }

  @override
  State<RelatedOpportunityDialog> createState() => _RelatedOpportunityDialogState();
}

class _RelatedOpportunityDialogState extends State<RelatedOpportunityDialog> {
  late TextEditingController opportunityController;
  @override
  void initState() {
    // TODO: implement initState
    opportunityController = TextEditingController();
    super.initState();
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
            child: const Text(
              "Danh sách cơ hội",
              style: TextStyle(
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
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: opportunityController,
              decoration: InputDecoration(hintText: "Mã cơ hội"),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 16,
            ),
          //  ListView.separated(
            //         itemBuilder: (context, index) {
            //           return GestureDetector(
            //             onTap: () {
            //               // Get.back(result: ItemChoice(name: listString[index], position: index));
            //             },
            //             child: Container(
            //               // color: Colors.transparent,
            //               padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            //               child: Text(
            //                 listString[index],
            //                 style: const TextStyle(
            //                   fontSize: 16,
            //                   color: blackColor,
            //                 ),
            //               ),
            //             ),
            //           );
            //         },
            //         separatorBuilder: (BuildContext context, int index) {
            //           return const Divider(
            //             height: 1,
            //           );
            //         },
            //         itemCount: listString.length,
            //       )
          ],
        ),
      ),
    );
  }
}
