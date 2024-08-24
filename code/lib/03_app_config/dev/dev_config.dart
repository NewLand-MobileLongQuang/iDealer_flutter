import 'package:dio/src/options.dart';
import 'package:idealer/03_app_config/01_base/base_config.dart';
import 'package:intl/src/intl/date_format.dart';

class DevConfig extends BaseConfig {
  @override
  String get accountMobileUrl =>
      // "http://113.190.232.235:30100/idocNet.Test.iDealer.VN029/Services/";
      // "https://devidealer.inos.vn/";
      "https://idealerssodev.veloca.vn/";
      // "https://lqidealer.veloca.vn/";

  @override
  String get msgtestUrl => "https://msgtest.ecore.vn/";

  @override
  BaseOptions get apiBaseOptions {
    return BaseOptions(connectTimeout: 30000, receiveTimeout: 30000);
  }

  @override
  DateFormat get dateFormat => DateFormat("yyyy-MM-dd");

  @override
  DateFormat get datetimeFormat => DateFormat("yyyy-MM-dd HH:mm");

  @override
  DateFormat get apiLongDatetimeFormat => DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  bool get isLogApiRequest => true;
}
