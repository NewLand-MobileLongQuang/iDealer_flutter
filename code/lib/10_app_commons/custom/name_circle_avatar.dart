import 'package:flutter/material.dart';

class NamedCircleAvatar extends StatelessWidget {
  const NamedCircleAvatar({
    Key? key,
    this.name,
    this.size = 18,
    this.avatar,
    this.backgroundColor,
    this.opacity = 1,
  }) : super(key: key);

  final Color? backgroundColor;
  final String? name;
  final double size;
  final String? avatar;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    var name2 = name == null ? null : (name!.trim().isNotEmpty ? name : null);
    var avatar2 = avatar == null ? null : (avatar != "" ? avatar : null);

    var backgroundColor2 = backgroundColor ?? Color(int.parse('0xFFE2E0E0'));

    if (name2 == null && avatar2 == null) {
      return Opacity(
        opacity: opacity,
        child: CircleAvatar(
          backgroundColor: backgroundColor2, //Colors.brown.shade800,
          radius: size,
        ),
      );
    } else if (avatar2 != null) {
      return Opacity(
        opacity: opacity,
        child: CircleAvatar(
          backgroundColor: backgroundColor2, //Colors.brown.shade800,
          radius: size,
          backgroundImage: NetworkImage(avatar ?? ""),
        ),
      );
    } else {
      return Opacity(
        opacity: opacity,
        child: CircleAvatar(
          backgroundColor: backgroundColor2, //Colors.brown.shade800,
          radius: size,
          child: Text(
            getNameAlphabet(name2!),
            style: TextStyle(fontSize: size, color: Colors.black),
          ),
        ),
      );
    }
  }

  static String getNameAlphabet(String name) {
    var list = name.split(RegExp("[ -]+"));
    if (list.length >= 2) {
      int last = list.length - 1;
      String first = "";
      if (list[0].isNotEmpty) {
        first = list[0][0];
      }
      String lastStr = "";
      if (list[last].isNotEmpty) {
        lastStr = list[last][0];
      }
      return "${first.toUpperCase()}${lastStr.toUpperCase()}";
    }
    if (list.length == 1) {
      String first = "";
      if (list[0].isNotEmpty) {
        first = list[0][0];
      }
      return first.toUpperCase();
    }
    return "";
  }
}
