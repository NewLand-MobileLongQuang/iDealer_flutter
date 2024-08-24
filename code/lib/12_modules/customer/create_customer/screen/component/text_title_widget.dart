import 'package:flutter/material.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';

class TextTitleWidget extends StatelessWidget {
  TextTitleWidget(
      {Key? key,
      required this.title,
      required this.content,
      this.isSuffixIcon,
      this.isStar})
      : super(key: key);
  final String title;
  final String content;
  bool? isStar = false;
  bool? isSuffixIcon = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: const TextStyle(
                  fontSize: 16,
                  color: titleBlackColor,
                ),
              ),
              if (isStar == true)
                const TextSpan(
                  text: " *",
                  style: TextStyle(
                    fontSize: 16,
                    color: starColor,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  content,
                  style: const TextStyle(
                    fontSize: 15,
                    color: titleBlackColor,
                  ),
                ),
              ),
            ),
            if (isSuffixIcon == true) const SizedBox(width: 10),
            if (isSuffixIcon == true)
              const Icon(Icons.calendar_month, color: titleBlackColor),
            if (isSuffixIcon == true) const SizedBox(width: 4),
          ],
        ),
        const SizedBox(height: 8),
        Container(height: 1, color: Colors.grey),
        const SizedBox(height: 16),
      ],
    );
  }
}
