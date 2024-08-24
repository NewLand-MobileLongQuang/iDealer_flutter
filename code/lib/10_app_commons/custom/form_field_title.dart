import 'package:flutter/material.dart';

class FormFieldTitle extends StatelessWidget {
  const FormFieldTitle({
    Key? key,
    required this.title,
    this.isRequired = false,
  }) : super(key: key);

  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Text(
      isRequired ? "${title} *" : "${title}",
      style: TextStyle(
        fontSize: 17,
        color: Colors.grey[600],
      ),
    );
  }
}