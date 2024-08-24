import 'package:flutter/material.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';

class TextOptionWidget extends StatelessWidget {
  TextOptionWidget({
    Key? key,
    required this.title,
    required this.content,
    this.isStar,
    this.iconData = Icons.arrow_drop_down,
    required this.optionListener,
  }) : super(key: key);
  final String title;
  final String content;
  IconData? iconData;
  bool? isStar = false;
  final VoidCallback optionListener;

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
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            optionListener.call();
          },
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    content,
                    style: const TextStyle(
                      fontSize: 15,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                iconData,
                color: blackColor,
              ),
              const SizedBox(
                width: 6,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 1,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
