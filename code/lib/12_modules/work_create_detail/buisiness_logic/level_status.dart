import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LevelStatus { P, F, C, none }

extension LevelStatusExt on LevelStatus {
  static LevelStatus? fromApiName(String name) {
    switch (name) {
      case "P":
        return LevelStatus.P;
      case "F":
        return LevelStatus.F;
      case "C":
        return LevelStatus.C;
    }
    return LevelStatus.none;
  }

  String get toDisplayName {
    switch (this) {
      case LevelStatus.P:
        return "P";
      case LevelStatus.F:
        return "F";
      case LevelStatus.C:
        return "C";
      default:
        return "";
    }
  }

  static bool compareFn(LevelStatus? one, LevelStatus? two) {
    if (one == null) {
      if (two == null) {
        return true;
      }
      return false;
    }
    if (two == null) {
      return false;
    }
    if (one == two) {
      return true;
    }
    return false;
  }

  get color {
    switch (this) {
      case LevelStatus.P:
        return Colors.redAccent;
      case LevelStatus.F:
        return Colors.green;
      case LevelStatus.C:
        return const Color(0xff767778);
      default:
        return Colors.transparent;
    }
  }
}
