import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/idealer_core_api_service.dart';

import 'main_app_loading_result.dart';

class MainApp {
  MainApp._privateConstructor();
  static final MainApp _singleton = MainApp._privateConstructor();

  factory MainApp() {
    return _singleton;
  }

  static MainApp instance() {
    return _singleton;
  }

  static late Future<void> initializeFuture;

  static Future<void> initialize({
    required Widget Function() welcomeScreen,
    required Widget Function() loginScreen,
    required Widget Function() homeScreen,
    required Future<void> Function() onInitialize,
    required Future<void> Function() onInitialized,
    required Future<void> Function() onReload,
    required Future<void> Function() onAuthorizedLoaded,
    required Future<void> Function() onReloaded,
  }) async {
    initializeFuture = _initialize(
      welcomeScreen: welcomeScreen,
      loginScreen: loginScreen,
      homeScreen: homeScreen,
      onInitialize: onInitialize,
      onInitialized: onInitialized,
      onReload: onReload,
      onAuthorizedLoaded: onAuthorizedLoaded,
      onReloaded: onReloaded,
    );
  }

  static Future<void> _initialize({
    required Widget Function() welcomeScreen,
    required Widget Function() loginScreen,
    required Widget Function() homeScreen,
    required Future<void> Function() onInitialize,
    required Future<void> Function() onInitialized,
    required Future<void> Function() onReload,
    required Future<void> Function() onAuthorizedLoaded,
    required Future<void> Function() onReloaded,
  }) async {
    instance().welcomeScreen = welcomeScreen;
    instance().loginScreen = loginScreen;
    instance().homeScreen = homeScreen;
    instance().onReload = onReload;
    instance().onReloaded = onReloaded;
    instance().onAuthorizedLoaded = onAuthorizedLoaded;
  }

  late Widget Function() welcomeScreen;
  late Widget Function() loginScreen;
  late Widget Function() homeScreen;
  late Future<void> Function() onReload;
  late Future<void> Function() onAuthorizedLoaded;
  late Future<void> Function() onReloaded;

  String? listDealerCode;

  static void restartToWelcome() {
    Get.offAll(instance().welcomeScreen);
  }

  static void restartToHome() {
    Get.offAll(instance().homeScreen);
  }

  static void restartToLogin() {
    Get.offAll(instance().loginScreen);
  }

  Future<MainAppLoadingResult> reload() async {
    await onReload.call();
    var result = await _reload();
    // if (result == MainAppLoadingResult.authorized) {
    //   await onAuthorizedLoaded.call();
    // }
    // await onReloaded.call();
    return result;
  }

  Future<MainAppLoadingResult> _reload() async {
    try {
      await initializeFuture;
      // Mở database và insert dữ liệu
      await UserSessionController.reInitialize();
      listDealerCode = null;
      // list cấp quyền
      listDealerCode = await IDealerCoreApiService.getListDealerCode();
      /*
        - nếu chưa đăng nhập : --> _userInfo == null
              --> vào màn hình login để đăng nhập
                    --> thành công : lưu _userInfo lại
                                --> mở màn hình selectOrg để chọn org
                                --> lưu org lại
                                --> vào màn hình home
                   --> Thất bại : hiển thị lỗi
        - nếu đã đăng nhập trước đó rồi : --> _userInfo != null
              --> tiến hành login lại theo userInfo đã lưu trước đó
              --> cập nhật lại trạng thái của login
              --> nếu đăng nhập thành công :
                      --> nếu đã có org rồi : _org != null
                            ---> vào thẳng màn hình main
                      --> nếu chưa có org : _orf == null
                            ---> vào màn hình org chọn org
        -
      */

      if (UserSessionController.instance().isSignIn) {
        await UserSessionController.instance().reSignIn();
        if (UserSessionController.instance().isSignIn) {
          if(UserSessionController.instance().isSelectOrg){
            return MainAppLoadingResult.selectedOrg;
          }
          return MainAppLoadingResult.authorized;
        }else{
          return MainAppLoadingResult.unauthorized;
        }
      }else{
        return MainAppLoadingResult.unauthorized;
      }
    } catch (error) {
    return MainAppLoadingResult.error;
    }
  }
}
