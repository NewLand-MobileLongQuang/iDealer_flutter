import 'package:flutter/material.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';

class ItemModelWidget extends StatelessWidget {
   ItemModelWidget({Key? key,
    required this.cusName,
    required this.module,
    required this.textSize,
    required this.fontWeight,
    this.isDelete = false,
     this.deleteListener
  }) : super(key: key);
  final String cusName;
  final String module;
  final double textSize;
  bool? isDelete;
  VoidCallback? deleteListener;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 8, 0, 0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
              child: Text(
                cusName,
                style: TextStyle(fontWeight: fontWeight, fontSize: textSize, color: blackColor),
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 3,
              child: Text(
                module,
                style: TextStyle(fontWeight: fontWeight, fontSize: textSize, color: blackColor),
                textAlign: TextAlign.center,
              )),
          (isDelete == true)?
          Expanded(
            flex: 1,
            child: IconButton(
                onPressed: (){
                  deleteListener?.call();
                },
                icon: const Icon(Icons.delete, color: kPrimaryColor,),),
          )
          :Expanded(
            flex: 1,
            child: SizedBox(),
          )
        ],
      ),
    );
  }
}