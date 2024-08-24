import 'package:flutter/material.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';

class ItemWorkDay extends StatelessWidget {
  const ItemWorkDay({
    Key? key,
    // required this.icon,
    required this.workName,
    required this.cusName,
    required this.phone,
    required this.fontWeight,
    required this.fontSize,
    required this.itemColor,
  }) : super(key: key);
  // final IconData icon;
  final String workName;
  final String cusName;
  final String phone;
  final FontWeight fontWeight;
  final double fontSize;
  final Color itemColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      // color: itemColor,
      child: Row(
        children: [
          Center(
            child: Container(
              width: 8,
              height: 8,
              color: itemColor,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(
            workName,
            style: TextStyle(
                fontSize: fontSize, fontWeight: fontWeight, color: blackColor),
            textAlign: TextAlign.center,
          )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(cusName,
                  style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: blackColor),
                  textAlign: TextAlign.center)),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(phone,
                  style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: blackColor),
                  textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
