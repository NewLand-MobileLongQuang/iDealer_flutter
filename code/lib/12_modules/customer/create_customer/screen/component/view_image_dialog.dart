import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';

class ViewImageDialog extends StatefulWidget {
  const ViewImageDialog({Key? key, required this.attachFilePath})
      : super(key: key);
  final String attachFilePath;
  static Future<void> show(String attachFilePath) {
    return Get.dialog(ViewImageDialog(
      attachFilePath: attachFilePath,
    ));
  }

  @override
  _ViewImageDialogState createState() => _ViewImageDialogState();
}

class _ViewImageDialogState extends State<ViewImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Image(
                  image: NetworkImage(
                      "${AppConfig.instance().accountMobileUrl}${widget.attachFilePath}")),
              Container(
                alignment: Alignment.centerRight,
                color: Colors.transparent,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 30,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
