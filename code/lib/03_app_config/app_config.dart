import 'package:dio/src/options.dart';
import 'package:idealer/01_env/env.dart';
import 'package:idealer/03_app_config/01_base/base_config.dart';
import 'package:idealer/03_app_config/dev/dev_config.dart';
import 'package:idealer/03_app_config/prod/prod_config.dart';
import 'package:intl/src/intl/date_format.dart';

class AppConfig extends BaseConfig {
  late BaseConfig _baseConfig;

  AppConfig._privateConstructor() {
    if (AppEnv.appFlavour == AppFlavour.develop) {
      _baseConfig = DevConfig();
    } else {
      _baseConfig = ProdConfig();
    }
  }

  static final AppConfig _singleton = AppConfig._privateConstructor();

  factory AppConfig() {
    return _singleton;
  }

  static AppConfig instance() {
    return _singleton;
  }

  @override
  String get accountMobileUrl => _baseConfig.accountMobileUrl;

  @override
  BaseOptions get apiBaseOptions => _baseConfig.apiBaseOptions;

  @override
  DateFormat get apiLongDatetimeFormat => _baseConfig.apiLongDatetimeFormat;

  @override
  DateFormat get dateFormat => _baseConfig.dateFormat;

  @override
  DateFormat get datetimeFormat => _baseConfig.datetimeFormat;

  @override
  String get msgtestUrl => _baseConfig.msgtestUrl;

  @override
  bool get isLogApiRequest => _baseConfig.isLogApiRequest;
}
