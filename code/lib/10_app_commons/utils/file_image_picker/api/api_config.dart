class ApiConfig {
  //api configuration
  static String getBaseUrl() {
    return "http://14.232.244.217:12088/idocNet.Test.MobileGate.V10.WA/";
  }

  static String getOrgApiBaseUrl() {
    return "https://test.inos.vn/api/orgapi/";
  }

  static int getConnectionTimeout() {
    return 5000;
  }

  static int getReceiveTimeout() {
    return 3000;
  }

  static Map<String, dynamic> getDefaultHeader() {
    return {
      "GwUserCode": "idocNet.idN.MobileGate.Sv",
      "GwPassword": "idocNet.idN.MobileGate.Sv",
    };
  }

  static String getBackgroundResource() {
    return "assets/modules/account/background_ios.png";
  }
}
