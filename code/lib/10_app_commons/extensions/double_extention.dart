import 'dart:math';

import 'package:intl/intl.dart';

extension DoubleExtension on double {
  static String currencyStringFormat(double value) {
    final formater = NumberFormat("###,###.##", "en_US");
    return formater.format(value);
  }

  String get toCurrency {
    final formater = NumberFormat("###,###.##", "en_US");
    return formater.format(this);
  }

  double roundToFraction(int digit) {
    var decaPow = pow(10, digit);
    return (this * decaPow).round() / decaPow;
  }
}
