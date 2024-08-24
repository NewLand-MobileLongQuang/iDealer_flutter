// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class WorkScheduleInMonthData {
  WorkScheduleInMonthData({
    this.weekCode,
    this.indexWeekOfYear,
    this.indexWeekOfMonth,
    this.listDateOfWeek,
  });

  String? weekCode;
  String? indexWeekOfYear;
  String? indexWeekOfMonth;
  List<ListDateOfWeek>? listDateOfWeek;

  factory WorkScheduleInMonthData.fromRawJson(String str) => WorkScheduleInMonthData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkScheduleInMonthData.fromJson(Map<String, dynamic> json) => WorkScheduleInMonthData(
    weekCode: json["WeekCode"],
    indexWeekOfYear: json["IndexWeekOfYear"],
    indexWeekOfMonth: json["IndexWeekOfMonth"],
    listDateOfWeek: List<ListDateOfWeek>.from(json["ListDateOfWeek"].map((x) => ListDateOfWeek.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "WeekCode": weekCode,
    "IndexWeekOfYear": indexWeekOfYear,
    "IndexWeekOfMonth": indexWeekOfMonth,
    "ListDateOfWeek": List<dynamic>.from((listDateOfWeek??[]).map((x) => x.toJson())),
  };
}

class ListDateOfWeek {
  ListDateOfWeek({
    this.curDate,
    this.day,
    this.dayOfWeek,
    this.iDayOfWeek,
    this.dayOfYear,
    this.month,
    this.weekOfMonth,
    this.year,
    this.weekOfYear,
    this.countDaysInMonth,
    this.isCurrentDate,
    this.isWork,
  });

  String? curDate;
  String? day;
  String? dayOfWeek;
  int? iDayOfWeek;
  String? dayOfYear;
  String? month;
  String? weekOfMonth;
  String? year;
  String? weekOfYear;
  String? countDaysInMonth;
  bool? isCurrentDate;
  bool? isWork;

  factory ListDateOfWeek.fromRawJson(String str) => ListDateOfWeek.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListDateOfWeek.fromJson(Map<String, dynamic> json) => ListDateOfWeek(
    curDate: json["CurDate"],
    day: json["Day"],
    dayOfWeek: json["DayOfWeek"],
    iDayOfWeek: json["IDayOfWeek"],
    dayOfYear: json["DayOfYear"],
    month: json["Month"],
    weekOfMonth: json["WeekOfMonth"],
    year: json["Year"],
    weekOfYear: json["WeekOfYear"],
    countDaysInMonth: json["CountDaysInMonth"],
    isCurrentDate: json["IsCurrentDate"],
    isWork: json["IsWork"],
  );

  Map<String, dynamic> toJson() => {
    "CurDate": curDate,
    "Day": day,
    "DayOfWeek": dayOfWeek,
    "IDayOfWeek": iDayOfWeek,
    "DayOfYear": dayOfYear,
    "Month": month,
    "WeekOfMonth": weekOfMonth,
    "Year": year,
    "WeekOfYear": weekOfYear,
    "CountDaysInMonth": countDaysInMonth,
    "IsCurrentDate": isCurrentDate,
    "IsWork": isWork,
  };
}
