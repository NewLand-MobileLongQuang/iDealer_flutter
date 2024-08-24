import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:idealer/04_core_modules/user_session/api/requests/user_info/get_access_token_request.dart';
import 'package:idealer/04_core_modules/user_session/api/requests/user_info/response/select_org_request.dart';
import 'package:idealer/04_core_modules/user_session/api/requests/user_info/response/user_info_response/user_response.dart';
import 'requests/user_info/response/select_org_response/select_org_response.dart';
import 'models/user_info.dart';
import 'requests/user_info/response/get_access_token/get_access_token_response.dart';
import 'requests/user_info/user_info_request.dart';

class UserSessionApiService {
  static Future<UserInfoResponse> signin(
      String username, String password) async {
    // var passHasMD5 = convertHashToString(password);
    var passHasMD5 = (password);
    var request = UserInfoRequest(username: username, password: passHasMD5);
    var response = await request.invoke();
    // if (response.success == true) {
    //   return UserInfo(
    //       userName: response.userName,
    //       password: response.password,
    //       dealerCode: response.dealerCode,
    //       userCur: response.userCur,
    //       sessionId: response.sessionId,
    //       flagSendSMS: response.flagSendSMS);
    // }

    return response
      ..username = username
      ..password = passHasMD5;
  }


  static Future<GetAccessTokenResponse> signinByRefreshToken(
      String username, String password) async {
    try {
      var request = GetAccessTokenRequest(username: username , password: password);
      var response = await request.invoke();
      return response;
    } catch (e) {
      //print("LOG LOGIN 3\n");
      //MainGet.errorToast(message: "Có lỗi xảy ra!");
      rethrow;
    }
  }

  static Future<SelectOrgResponse> getOrgList() async {
    // tạo request từ token lấy được từ user-password
    var request = SelectOrgRequest();
    var response = await request.invoke();
    return response;
  }

  static String convertHashToString(String text) {
    String pass = "${text}idocNet.iDealer";
    var base64 = base64Encode(md5.convert(utf8.encode(pass)).bytes);
    String passHash = base64.substring(0, base64.length - 2);
    print("password md5: $passHash");
    return passHash;
  }
}
