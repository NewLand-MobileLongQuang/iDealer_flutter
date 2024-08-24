import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:idealer/04_core_modules/user_session/api/models/access_token.dart';
import 'package:idealer/04_core_modules/user_session/api/models/user_info.dart';
import 'package:idealer/04_core_modules/user_session/api/requests/user_info/response/select_org_response/select_org_response.dart';
import 'package:idealer/04_core_modules/user_session/api/requests/user_info/response/user_info_response/user_response.dart';
import 'package:idealer/04_core_modules/user_session/api/user_session_api_service.dart';
import 'package:idealer/05_main_app/main_app.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';
import 'package:idealer/11_screens/business_logic/permission_idealer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../11_screens/welcome/screens/welcome/select_org_screen.dart';
import 'models/login_info.dart';

class UserSessionController {
  /// Singleton
  UserSessionController._privateConstructor();

  static final UserSessionController _singleton =
      UserSessionController._privateConstructor();

  factory UserSessionController.instance() {
    return _singleton;
  }

  SharedPreferences? _prefs;
  LoginInfo? _loginInfo;
  UserInfoResponse? _userInfo;
  AccessToken? _accessToken;
  LstOSInosOrg? _org;

  AccessToken? get accessToken => _accessToken;

  LstOSInosOrg? get org => _org;

  String get token {
    if (_accessToken == null) return "";
    return _accessToken!.accessToken;
  }

  // org
  bool get isSelectOrg {
    return _org != null;
  }

  LoginInfo? get loginInfo {
    return _loginInfo;
  }

  UserInfoResponse? get userInfo {
    return _userInfo;
  }

  bool get isSignIn {
    return _userInfo != null;
  }

  void setSavePassword(bool isSave) {
    _loginInfo?.isSave = isSave;
  }

  // ============= Lưu thông tin đăng nhập =====================//

  void saveAccessToken(AccessToken accessToken) {
    _prefs!.setString("userSession.accessToken", jsonEncode(accessToken));
  }

  void saveUserInfo(UserInfoResponse userInfo) {
    _prefs!.setString("userSession.userInfo", jsonEncode(userInfo));
  }

  void saveLoginInfo(LoginInfo loginInfo) {
    _prefs!.setString("userSession.loginInfo", jsonEncode(loginInfo));
  }

  void saveOrg(LstOSInosOrg org) {
    _org = org;
    _prefs!.setString("userSession.org", jsonEncode(org));
  }

  // ============= Hàm login =====================//

  // login (loginScreen)
  Future<bool> signInByUsernamePasswordHaveHubProcess(
    String username,
    String password,
    bool isSave,
  ) async {
    try {
      // call api login --> userInfo
      var future = UserSessionApiService.signin(username, password);
      var userInfo = await MainGet.showHudProgress(future);

      // tạo loginInfo từ user, password, isSave đã nhập từ màn hình login
      LoginInfo loginInfo = LoginInfo(username, password, isSave);
      // Lưu thông tin đăng nhập
      _setLoginInfo(loginInfo, isSave, userInfo);

      // mở màn hình OrgScreen
      await SelectOrgScreen.show();
      // MainApp.restartToWelcome();

      return true;
    } catch (error) {
      MainGet.errorAlert(error: "Có lỗi xảy ra!!");
      return false;
    }
  }

  // login lại khi đã có thông tin login
  Future<void> reSignIn() async {
    if (_loginInfo == null) return;

    if (!_loginInfo!.isSave) return;

    var username = _loginInfo?.username ?? "";
    var password = _loginInfo?.password ?? "";

    try {
      await signInByUsernamePassword(username, password, false);
    } catch (e) {
      MainApp.restartToLogin();
    }
  }

  Future<bool> signInByUsernamePassword(
    String username,
    String password,
    bool isSave,
  ) async {
    try {
      var userInfo = await UserSessionApiService.signin(username, password);
      LoginInfo loginInfo = LoginInfo(username, password, isSave);
      _setLoginInfo(loginInfo, isSave, userInfo);
      return true;
    } catch (error) {
      return false;
    }
  }

  // ============= Token =====================//

  //Cờ bật hiển thị thông báo token hết hạn
  var needRestartBecauseOfTokenExpired = false.obs;

  // Token đã quá hạn
  bool get isTokenExpired {
    if (_accessToken != null) {
      return _accessToken!.isExpired(); // check time
    }
    return true;
  }

  // Token đã rất quá hạn
  bool get isTokenOverExpired {
    if (_accessToken != null) {
      return _accessToken!.isOverExpired();
    }
    return true;
  }

  Future<void> checkAndRefreshToken() async {
    // nếu token đã quá hạn thì lấy lại bằng cách đăng nhập lại
    if (isSignIn) {
      // print("checkAndRefreshToken");
      if (isTokenExpired) {
        if (isTokenOverExpired) {
          // print("checkAndRefreshToken isTokenOverExpired");
          tokenExpired();
        } else {
          // print("checkAndRefreshToken isTokenExpired");
          signInByRefreshToken();
        }
      }
    }
  }

  //bật cờ
  void tokenExpired() {
    needRestartBecauseOfTokenExpired.value = true;
    needRestartBecauseOfTokenExpired.update((val) {});
  }

  // lấy lại token mới
  Future<void> signInByRefreshToken() async {
    if (isSignIn == false) return;

    //giữ lại thông tin token đã hết hạn để cập nhật thông tin userCode và password
    var accessToken = this.accessToken!;

    //đăng nhập từ access_token
    var apiFuture = UserSessionApiService.signinByRefreshToken(
      loginInfo!.password,
      accessToken.refreshToken,
    );
    var response = await apiFuture;
    var accessTokenString = response.accessToken ?? "";
    var refreshToken = response.refreshToken ?? "";
    var expiresIn = int.parse("${_userInfo?.expiresIn ?? 0}");

    var accessTokenObject = AccessToken(
      accessTokenString,
      refreshToken,
      expiresIn,
    );

    //cập nhật token mới
    saveAccessToken(accessTokenObject);
  }

  /// tắt cờ, restart app
  void restartBecauseOfTokenExpired() async {
    needRestartBecauseOfTokenExpired.value = false;
    await signOut();
    MainApp.restartToWelcome();
  }

  // Lưu lại thông tin đăng nhập
  void _setLoginInfo(
      LoginInfo loginInfo, bool isSave, UserInfoResponse? userInfo) {
    _loginInfo = loginInfo;
    _userInfo = userInfo;

    // tạo mới 1 token mới
    var accessToken = userInfo?.accessToken ?? "";
    var refreshToken = userInfo?.refreshToken ?? "";
    var expiresIn = int.parse(userInfo?.expiresIn ?? "0");

    var accessTokenObject = AccessToken(
      accessToken,
      refreshToken,
      expiresIn,
    );
    _accessToken = accessTokenObject;

    // Nếu chọn lưu thông tin đăng nhập (isSave = true)
    if (isSave) {
      // lưu token
      saveAccessToken(accessTokenObject);
      // lưu userInfo
      if (userInfo != null) {
        saveUserInfo(userInfo);
      }
      // lưu loginInfo
      saveLoginInfo(loginInfo);
    }

    // gán dữ liệu phân quyền
    var permission = PermissionIdealer.instance();
    for (ListAccess mAccess in userInfo?.user?.listAccess ?? []) {
      if (mAccess.objectcode == "ADM_DEALERCUSTOMER_CREATE") {
        permission.access.isMenuCusCreate = true;
      }
      if (mAccess.objectcode == "MNU_DEALERCUSTOMER") {
        permission.access.isMenuCusManager = true;
      }

      if (mAccess.objectcode == "SALES_SALESPROCESS") {
        permission.access.isMenuOpportunityCreate = true;
      }
      if (mAccess.objectcode == "SALES_STATESALES") {
        permission.access.isMenuOpportunityManager = true;
      }

      if (mAccess.objectcode == "RPT_INVENTORY") {
        permission.access.isMenuReportRetain = true;
      }
      if (mAccess.objectcode == "RPT_TONGHOPXE") {
        permission.access.isMenuReportSyntheticVehicle = true;
      }

      if (mAccess.objectcode == "MNU_ADMIN_WK_USERSCHEDULE_MNG") {
        permission.access.isMenuWorkManager = true;
      }
      if (mAccess.objectcode == "MNU_ADMIN_WK_USERSCHEDULE_CALENDAR") {
        permission.access.isMenuWorkSchedule = true;
      }
    }
  }

  // ============= Lấy thông tin đăng nhập từ trong storage =====================//

  static Future<void> reInitialize() async {
    await _singleton._loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    _prefs = await SharedPreferences.getInstance();

    var accessTokenJson = _prefs!.getString("userSession.accessToken");
    if (accessTokenJson != null) {
      Map<String, dynamic> map = jsonDecode(accessTokenJson);
      _accessToken = AccessToken.fromJson(map);
    }

    var loginInfoJson = _prefs!.getString("userSession.loginInfo");
    if (loginInfoJson != null) {
      Map<String, dynamic> map = jsonDecode(loginInfoJson);
      _loginInfo = LoginInfo.fromJson(map);
    }

    var userInfo = _prefs!.getString("userSession.userInfo");
    if (userInfo != null) {
      Map<String, dynamic> map = jsonDecode(userInfo);
      _userInfo = UserInfoResponse.fromJson(map);
    }
    try {
      var org = _prefs!.getString("userSession.org");
      if (org != null) {
        Map<String, dynamic> map = jsonDecode(org);
        _org = LstOSInosOrg.fromJson(map);
      }
      log("TAG : _loadFromStorage _org?.id : ${_org?.id}");
    } catch (e) {
      log("TAG : _loadFromStorage error : ${e.toString()}");
    }
  }

  static Future<void> initialize() async {}

  // ============= Logout =====================//

  /// loại bỏ tất cả các thông tin
  Future<void> signOut() async {
    _accessToken = null;
    await _prefs!.remove("userSession.accessToken");
    // await _prefs!.remove("userSession.loginInfo");
    await _prefs!.remove("userSession.userInfo");
    await _prefs!.remove("userSession.org");
    // _loginInfo?.isSave = false;
    // _loginInfo = null;
    _userInfo = null;
    _accessToken = null;
    _org = null;
    // _setLoginInfo(_loginInfo ?? LoginInfo("", "", false), true, null);
  }
}
