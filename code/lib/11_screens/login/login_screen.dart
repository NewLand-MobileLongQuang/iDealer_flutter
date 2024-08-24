import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/05_main_app/main_app.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';
import 'package:idealer/11_screens/welcome/screens/componets/background.dart';

/*
- Vào màn hình:
  + load danh sách đại lý
  + khi nhập đúng mã đại lý thì mới cho login
  + khi login thì lưu toàn bộ thông tin userInfo, username, password, isSave và chuyển sang màn hình Main
 */

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController nameController;
  late TextEditingController passController;
  late TextEditingController dealerCodeController;
  Rx<bool> isShowPass = false.obs;
  Rx<bool> isRememberPass = false.obs;

  @override
  void initState() {
    nameController = TextEditingController(
        text: UserSessionController.instance().loginInfo?.username);
    passController = TextEditingController(
        text: UserSessionController.instance().loginInfo?.password);
    isRememberPass.value =
        UserSessionController.instance().loginInfo?.isSave ?? false;
    isRememberPass.update((val) {});
    dealerCodeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Center(
            child: SingleChildScrollView(
              child: Card(
                margin: const EdgeInsets.all(25),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: "Tên đăng nhập",
                          fillColor: const Color(0xFFF3F3F3),
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          prefixIcon: const Icon(
                            Icons.mail_outline,
                            color: Colors.grey,
                          ),
                          suffixIcon: (nameController.text != "")
                              ? IconButton(
                                  onPressed: () {
                                    nameController.text = "";
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.cancel),
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(() => TextField(
                            expands: false,
                            controller: passController,
                            obscureText: !isShowPass.value,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "Mật khẩu",
                                fillColor: const Color(0xFFF3F3F3),
                                filled: true,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                prefixIcon: const Icon(
                                  Icons.key,
                                  color: Colors.grey,
                                ),
                                suffixIcon: (isShowPass.value)
                                    ? IconButton(
                                        onPressed: () {
                                          isShowPass.value = !isShowPass.value;
                                        },
                                        icon: const Icon(
                                          Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          isShowPass.value = !isShowPass.value;
                                        },
                                        icon: const Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                      )),
                            onChanged: (value) {},
                          )),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          const Text(
                            "Mã đại lý: ",
                            style: TextStyle(color: blackColor, fontSize: 15),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 30,
                              child: TextField(
                                controller: dealerCodeController,
                                textCapitalization:
                                    TextCapitalization.characters,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "VN101",
                                  fillColor: const Color(0xFFF3F3F3),
                                  filled: true,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(8, 9, 8, 9),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Obx(() => Row(
                            children: [
                              Checkbox(
                                  // fillColor:
                                  //     MaterialStateProperty.all(Colors.orange),
                                  value: isRememberPass.value,
                                  onChanged: (value) {
                                    isRememberPass.value =
                                        !isRememberPass.value;
                                    // UserSessionController.instance().setSavePassword(!isRememberPass.value);
                                  }),
                              const Text(
                                "Nhớ mật khẩu",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          String username = nameController.text;
                          String password = passController.text;
                          bool isSave = isRememberPass.value;

                          if (!checkDealer(dealerCodeController.text)) {
                            return;
                          }
                          await UserSessionController.instance()
                              .signInByUsernamePasswordHaveHubProcess(
                                  username, password, isSave);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(42)),
                        child: const Text("Đăng nhập"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool checkDealer(String dealerCode) {
    if (dealerCode.trim() == "") {
      MainGet.showToast("Yêu cầu nhập đại lý");
      return false;
    }
    List<String> dealerSplit =
        (MainApp.instance().listDealerCode ?? "").split(",");
    for (String mDealer in dealerSplit) {
      if (mDealer.toUpperCase().trim() == dealerCode.toUpperCase().trim()) {
        return true;
      }
    }
    MainGet.showToast("Mã đại lý không đúng");
    return false;
  }
}
