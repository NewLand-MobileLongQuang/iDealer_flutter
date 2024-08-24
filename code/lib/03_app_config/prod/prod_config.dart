import 'package:dio/src/options.dart';
import 'package:idealer/03_app_config/01_base/base_config.dart';
import 'package:intl/src/intl/date_format.dart';

class ProdConfig extends BaseConfig {
  @override
  // String get accountMobileUrl => "http://idn.vn029.web.idealer.vn/";
  String get accountMobileUrl => "https://sale.hyundaidongdo.com.vn/";

  @override
  String get msgtestUrl => "https://msgtest.ecore.vn/";

  @override
  BaseOptions get apiBaseOptions {
    return BaseOptions(connectTimeout: 30000, receiveTimeout: 10000);
  }

  @override
  bool get isLogApiRequest => false;

  @override
  DateFormat get dateFormat => DateFormat("yyyy-MM-dd");

  @override
  DateFormat get datetimeFormat => DateFormat("yyyy-MM-dd HH:mm");

  @override
  DateFormat get apiLongDatetimeFormat => DateFormat("yyyy-MM-dd HH:mm:ss");
}
