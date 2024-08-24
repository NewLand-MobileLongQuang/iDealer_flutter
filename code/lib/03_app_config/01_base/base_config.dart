import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

abstract class BaseConfig {
  String get accountMobileUrl;
  String get msgtestUrl;

  BaseOptions get apiBaseOptions;

  // có log api request hay không
  bool get isLogApiRequest;

  DateFormat get dateFormat;
  DateFormat get datetimeFormat;
  DateFormat get apiLongDatetimeFormat;
}
