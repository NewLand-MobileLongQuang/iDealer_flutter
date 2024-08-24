import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:idealer/04_core_modules/api_libs/errors/network_error.dart';
import 'package:idealer/04_core_modules/user_session/api/base/errors/unknown_error.dart';

class MainGet {
  static Future<T?> offAll<T>(Widget widget,
      {Transition transition = Transition.fade, Duration? duration}) async {
    return await Get.offAll<T>(widget,
        transition: transition,
        duration: duration ?? const Duration(microseconds: 300));
  }

  static Color blackColor = const Color(0xff0E223D);
  static Color greenColor = const Color(0xff00703C);
  static Color greyColor = const Color(0xFF535353);

  // TODO: Thêm tham số cấu hình được title, nhãn của nút
  // TODO: Cho phép dùng icon của hệ thống: Icons.info
  static void successAlert({
    required String message,
    String title = "Thông báo",
    String iconAsset = "assets/icons/ic_success.png",
    IconData? iconData,
    bool isVisibleIcon = true,
    String close = "ĐÓNG",
  }) {
    Get.dialog(CommonDialog(
      title: title,
      iconAsset: iconAsset,
      iconData: iconData,
      message: message,
      isVisibleIcon: isVisibleIcon,
      close: close,
    ));
  }

  static Future<bool?> confirmAlert({
    String title = "Thông báo",
    required String message,
    String textOk = "ĐỒNG Ý",
    String textCancel = "HỦY",
    bool overlay = false,
  }) async {
    return Get.dialog(
      AlertDialog(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        content: Text(message, style: const TextStyle(fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: Text(
              textCancel,
              style: TextStyle(fontSize: 14, color: greenColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: Text(
              textOk,
              style: TextStyle(fontSize: 14, color: greenColor),
            ),
          ),
        ],
      ),
      barrierDismissible: !overlay,
    );
  }

  static void snackbar({
    String title = "Thông báo",
    required String message,
    bool isTop = false,
    bool overlay = false,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: isTop ? SnackPosition.TOP : SnackPosition.BOTTOM,
      overlayBlur: overlay ? 1 : null,
      overlayColor: overlay ? Colors.grey.withOpacity(0.1) : null,
    );
  }

  static void showToast(String message) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 2),
        borderRadius: 8,
        backgroundColor: const Color(0xFF303030),
      ),
    );
  }

  static Future<T> showHudProgress<T>(
    Future<T> future, {
    String? text,
    bool overlay = true,
  }) async {
    await Get.dialog(
          Builder(builder: (context) {
            future.whenComplete(() {
              Get.back();
            });
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: CupertinoActivityIndicator(
                  radius: 20,
                  color: Colors.white,
                ),
              ),
            );
          }),
          barrierDismissible: !overlay,
          // barrierColor: Colors.white70,
        ) ??
        false;

    return future;
  }

  static void errorAlert(
      {String title = "Thông báo",
      required Object error,
      String solution = "Inventory"}) {
    if (error is UnknownError) {
      error.errorCode = TranslateError.translate(error.errorCode);
      errorServerDialog(title: title, error: error, solution: solution);
    } else if (error is NetworkError) {
      errorDialog(title: title, error: "Lỗi kết nối mạng!");
    } else {
      errorDialog(title: title, error: "Có lỗi xảy ra!");
    }
  }

  static Future<bool?> errorServerDialog({
    String title = "Thông báo",
    required UnknownError error,
    required String solution,
  }) async {
    return await Get.dialog(
        ErrorServerDialog(title: title, error: error, solution: solution));
  }

  static Future<bool?> errorDialog({
    String title = "Thông báo",
    required String error,
  }) async {
    return await Get.dialog(ErrorDialog(
      title: title,
      error: error,
    ));
  }
}

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.iconAsset,
    required this.iconData,
    required this.isVisibleIcon,
    required this.close,
  }) : super(key: key);
  final String title;
  final String message;
  final String iconAsset;
  final IconData? iconData;
  final bool isVisibleIcon;
  final String close;

  @override
  Widget build(BuildContext context) {
    Color blackColor = const Color(0xff0E223D);
    Color greenColor = const Color(0xff00703C);
    Color greyColor = const Color(0xFF535353);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 12.0, 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 4,
                ),
                if (isVisibleIcon == true)
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: (iconData == null)
                        ? Image.asset(iconAsset)
                        : Icon(iconData),
                  ),
                if (isVisibleIcon == true)
                  const SizedBox(
                    width: 12,
                  ),
                Text(title,
                    style: TextStyle(
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              message,
              style: TextStyle(color: blackColor, fontSize: 14),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(height: 1, color: Colors.grey),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      close,
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 14,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorServerDialog extends StatefulWidget {
  const ErrorServerDialog(
      {Key? key,
      required this.title,
      required this.error,
      required this.solution})
      : super(key: key);
  final String title;
  final UnknownError error;
  final String solution;

  @override
  State<ErrorServerDialog> createState() => _ErrorServerDialogState();
}

class _ErrorServerDialogState extends State<ErrorServerDialog> {
  Rx<bool> isExpanded = false.obs;
  Rx<bool> isSendSuccess = false.obs;

  @override
  Widget build(BuildContext context) {
    Color blackColor = const Color(0xff0E223D);
    Color greenColor = const Color(0xff00703C);
    Color greyColor = const Color(0xFF535353);
    Color blueLightColor = const Color(0xFF5F7D95);
    return Dialog(
      child: Obx(() => Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: Image.asset("assets/icons/error.png"),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(widget.title,
                        style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  (widget.error.errorCode != "")
                      ? (widget.error.errorCode)
                      : "Có lỗi xảy ra!",
                  style: TextStyle(color: blackColor, fontSize: 14),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(
                        child: Divider(height: 1, color: Colors.grey)),
                    GestureDetector(
                      onTap: () {
                        isExpanded.value = !isExpanded.value;
                      },
                      child: SvgPicture.asset(
                        isExpanded.value
                            ? "assets/modules/work/icons/ic_more.svg"
                            : "assets/modules/work/icons/ic_hide.svg",
                        width: 20,
                        height: 20,
                        color: greyColor,
                      ),
                    ),
                    const Expanded(
                        child: Divider(height: 1, color: Colors.grey)),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                if (isExpanded.value)
                  const SizedBox(
                    height: 8,
                  ),
                if (isExpanded.value)
                  Text(
                    "Mã lỗi:",
                    style: TextStyle(
                        color: blueLightColor,
                        fontSize: 12,
                        fontStyle: FontStyle.italic),
                  ),
                if (isExpanded.value)
                  const SizedBox(
                    height: 8,
                  ),
                if (isExpanded.value)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        widget.error.message,
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 13,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                if (isExpanded.value)
                  const SizedBox(
                    height: 16,
                  ),
                if (isSendSuccess.value)
                  Container(
                    // color: Colors.black87,
                    padding: const EdgeInsets.all(4),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.done,
                          color: greenColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Gửi phản hồi thành công!",
                          style: TextStyle(color: greenColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                if (isExpanded.value)
                  const Divider(height: 1, color: Colors.grey),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "ĐÓNG",
                        style: TextStyle(
                          color: greenColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        // if (isSendSuccess.value) return;
                        // var result = await MailService.sendEmail(
                        //     widget.solution,
                        //     '${widget.error.errorCode}\n${widget.error.message}');
                        // if (result == true) {
                        //   isSendSuccess.value = true;
                        // }
                      },
                      child: Text(
                        "GỬI PHẢN HỒI",
                        style: TextStyle(
                          color:
                              (isSendSuccess.value) ? Colors.grey : greenColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () async {
                    //     if (isSendSuccess.value) return;
                    //     var result = await MailService.sendEmail(
                    //         widget.solution,
                    //         '${widget.error.errorCode}\n${widget.error.message}');
                    //     if (result == true) {
                    //       isSendSuccess.value = true;
                    //     }
                    //   },
                    //   child: Text(
                    //     "GỬI PHẢN HỒI",
                    //     style: TextStyle(
                    //       color:
                    //           (isSendSuccess.value) ? Colors.grey : greenColor,
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key, required this.title, required this.error})
      : super(key: key);
  final String title;
  final String error;
  @override
  Widget build(BuildContext context) {
    Color blackColor = const Color(0xff0E223D);
    Color greenColor = const Color(0xff00703C);
    Color greyColor = const Color(0xFF535353);
    Color blueLightColor = const Color(0xFF5F7D95);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 20.0, 12.0, 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  height: 25,
                  width: 25,
                  child: Image.asset("assets/icons/error.png"),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(title,
                    style: TextStyle(
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              (error != "") ? error : "Kiểm tra kết nối mạng!",
              style: TextStyle(color: blackColor, fontSize: 14),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(height: 1, color: Colors.grey),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "ĐÓNG",
                    style: TextStyle(
                      color: greenColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// dịch mã lỗi
class TranslateError {
  static String translate(String errorString) {
    String messageCode = errorString;
    if (messageCode.contains("CmSys_InvalidOutSite")) {
      messageCode = "Không thể lấy dữ liệu từ hệ thống tích hợp.";
    }
    return "";
  }
}
