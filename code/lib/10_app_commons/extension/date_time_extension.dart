import 'package:flutter/cupertino.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String dateString() {
    return AppConfig.instance().dateFormat.format(this);
  }

  String datetimeString() {
    return AppConfig.instance().datetimeFormat.format(this);
  }

  String longDateTimeString() {
    return AppConfig.instance().apiLongDatetimeFormat.format(this);
  }

  // DateTime adjustUserTimezone() {
  //   return add(Duration(hours: UserInfoController.timezone));
  // }

  static DateTime? fromApiUTC(String? utcTime) {
    if (utcTime == null) return null;
    try {
      var result = AppConfig.instance().apiLongDatetimeFormat.parse(utcTime);
      return result;
    } catch (error) {
      return null;
    }
  }

  static String? fromApiUTCToDateTimeString(
    String? utcTime, {
    bool adjustUserTimezone = false,
    bool showTime = false,
    bool showLongTime = false,
  }) {
    DateTime? dateTime = fromApiUTC(utcTime);
    if (adjustUserTimezone) {
      // dateTime = fromApiUTC(utcTime)?.adjustUserTimezone();
      dateTime = fromApiUTC(utcTime);
    }
    if (showTime) {
      return dateTime?.datetimeString();
    } else if (showLongTime) {
      return dateTime?.longDateTimeString();
    }
    return dateTime?.dateString();
  }

  static DateTime? apiDatetimeToDateTime(String? apiDateTime) {
    if (apiDateTime == null) return null;
    apiDateTime = apiDateTime.trim();
    var now = DateTime.now();
    var dateAndTime = apiDateTime.split(" ");
    if (dateAndTime.length != 2) {
      return DateTime.now();
    }
    var yearMonthAndDay = dateAndTime[0].split("-");
    if (yearMonthAndDay.length != 3) {
      yearMonthAndDay = [
        now.year.toString(),
        now.month.toString(),
        now.day.toString(),
      ];
    }

    var hourMinute = dateAndTime[1].split(":");
    if (hourMinute.length != 2) {
      hourMinute = [now.hour.toString(), now.minute.toString()];
    }

    var date = DateTime(
      strToInt(yearMonthAndDay[0]),
      strToInt(yearMonthAndDay[1]),
      strToInt(yearMonthAndDay[2]),
      strToInt(hourMinute[0]),
      strToInt(hourMinute[1]),
    );

    // print("$yearMonthAndDay $hourMinute: $date");

    return date;
  }

  static int strToInt(String text, {int defaultValue = 0}) {
    return int.tryParse(text) ?? defaultValue;
  }

  String yyyyMMddHHmmss({String deli = "-"}) {
    return DateFormat('yyyy${deli}MM${deli}dd HH:mm:ss').format(this);
  }

  // String ddMMyyyy({String deli = "-"}) {
  //   return DateFormat('dd${deli}MM${deli}yyyy').format(this);
  // }
  //
  // String ddMMyyyyHHmm({String deli = "-"}) {
  //   return DateFormat('dd${deli}MM${deli}yyyy HH:mm').format(this);
  // }
  //
  // String yyyyMMddHHmm({String deli = "-"}) {
  //   return DateFormat('yyyy${deli}MM${deli}dd HH:mm').format(this);
  // }

  String timeStringFromNow(BuildContext context) {
    int now = DateTime.now().millisecondsSinceEpoch ~/ 1000; //in second;
    int current = this.millisecondsSinceEpoch ~/ 1000;
    int seconds = now - current;
    if (seconds < 60) {
      return "30 second";
    }
    int minutes = seconds ~/ 60;
    if (minutes < 60) {
      return "$minutes minute";
    }
    int hours = minutes ~/ 60;
    if (hours < 24) {
      return "$hours hour";
    }
    int days = hours ~/ 24;
    if (days < 7) {
      return "$days day";
    }
    int weeks = days ~/ 7;
    if (weeks < 4) {
      return "$weeks week";
    }
    int months = days ~/ 30;
    if (months < 12) {
      return "$months month";
    }
    int years = days ~/ 365;
    return "$years year";
  }
}

extension StringDateTimeExtension on String {
  String? fromApiUTCToDateTimeString({
    bool adjustUserTimezone = false,
    bool showTime = false,
    bool showLongTime = false,
  }) {
    return DateTimeExtension.fromApiUTCToDateTimeString(
      this,
      adjustUserTimezone: adjustUserTimezone,
      showTime: showTime,
      showLongTime: showLongTime,
    );
  }
}
