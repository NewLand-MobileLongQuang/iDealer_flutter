import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';

import 'form_field_title.dart';

enum CustomTextFieldInputType {
  text,
  number,
  date,
  datetime,
  list,
}

class CustomTextFieldController {
  final textFieldController = TextEditingController();

  late CustomTextFieldInputType _inputType;
  late String _title;
  late bool _isRequired;

  void Function()? _setState;

  String? _errorText;
  String? _lastErrorText;

  set errorText(String errorText) {
    _errorText = errorText;
    _lastErrorText = errorText;
    _setState?.call();
  }

  void clearErrorText() {
    if (text != _lastErrorText) {
      _errorText = null;
      _setState?.call();
    }
  }

  String get text => textFieldController.text;

  set text(String newValue) {
    textFieldController.text = newValue;
    _setState?.call();
  }

  DateTime? get datetime {
    try {
      if (_inputType == CustomTextFieldInputType.datetime) {
        return AppConfig.instance().datetimeFormat.parse(text);
      }
      if (_inputType == CustomTextFieldInputType.date) {
        return AppConfig.instance().dateFormat.parse(text);
      }
    } on Exception catch (_) {}
    return null;
  }

  set datetime(DateTime? datetime) {
    if (datetime == null) text = "";
    if (_inputType == CustomTextFieldInputType.datetime) {
      text = AppConfig.instance().datetimeFormat.format(datetime!);
    }
    if (_inputType == CustomTextFieldInputType.date) {
      text = AppConfig.instance().dateFormat.format(datetime!);
    }
  }

  bool validateInputType() {
    if (text.trim().isEmpty) return true;
    if (_inputType == CustomTextFieldInputType.number) {
      if (double.tryParse(text) == null) {
        errorText = "Cần nhập đúng định dạng kiểu số";
        return false;
      }
    }
    clearErrorText();
    return true;
  }

  bool validateEmpty() {
    if (_isRequired && text.trim().isEmpty) {
      errorText = "Cần nhập $_title";
      return false;
    }
    clearErrorText();
    return true;
  }

  bool validate() {
    if (_isRequired && text.trim().isEmpty) {
      errorText = "Cần nhập $_title";
      return false;
    }
    if (_inputType == CustomTextFieldInputType.number) {
      if (double.tryParse(text) == null) {
        errorText = "Cần nhập đúng định dạng kiểu số";
        return false;
      }
    }
    clearErrorText();
    return true;
  }
}

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    required this.controller,
    this.inputType = CustomTextFieldInputType.text,
    this.inputAction = TextInputAction.newline,
    this.keyboardType,
    this.title,
    this.isEnable = true,
    this.isFilled = false,
    this.isClear = true,
    this.labelText,
    this.hintText,
    this.text,
    this.dateValue,
    this.password = false,
    this.minLines,
    this.maxLines = 1,
    this.bold = false,
    this.isRequired = false,
    this.autofocus = false,
    this.refNoList = const [],
    this.suffixIcon,
    this.fontSize,
    this.colorText,
    this.isVisiblePrefIcon = true,
  }) : super(key: key);

  // final CustomerTextField controller;
  final CustomTextFieldController controller;
  final CustomTextFieldInputType inputType;
  final TextInputAction? inputAction;
  final TextInputType? keyboardType;
  final String? labelText;
  final String? hintText;
  final String? text;
  final DateTime? dateValue;
  final String? title;
  final bool isEnable;
  final bool isFilled;
  final bool isClear;
  final bool password;
  final int? minLines;
  final int? maxLines;
  final bool bold;
  final bool isRequired;
  final bool autofocus;
  final List<String>? refNoList;
  final Widget? suffixIcon;
  final double? fontSize;
  final Color? colorText;
  final bool isVisiblePrefIcon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  GlobalKey textFieldKey = GlobalKey();
  late CustomTextFieldController controller;
  bool passwordVisible = false;

  void _setState() {
    setState(() {});
  }

  @override
  void initState() {
    controller = widget.controller;
    controller._inputType = widget.inputType;
    controller._title = widget.title ?? "";
    controller._isRequired = widget.isRequired;
    controller._setState = _setState;
    controller.textFieldController.addListener(() {
      controller.validateInputType();
    });
    if (widget.inputType == CustomTextFieldInputType.number) {
      if (widget.text == null || widget.text!.isEmpty) {
        controller.textFieldController.text = "0";
      } else {
        controller.textFieldController.text = widget.text!;
      }
    } else {
      controller.textFieldController.text = widget.text ?? "";
    }
    if (widget.inputType == CustomTextFieldInputType.date ||
        widget.inputType == CustomTextFieldInputType.datetime) {
      if (widget.dateValue == null) {
        controller.textFieldController.text = widget.text ?? "";
      } else {
        if (widget.inputType == CustomTextFieldInputType.date) {
          controller.textFieldController.text =
              AppConfig.instance().dateFormat.format(widget.dateValue!);
        } else {
          controller.textFieldController.text =
              AppConfig.instance().datetimeFormat.format(widget.dateValue!);
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.title != null)
          FormFieldTitle(title: widget.title!, isRequired: widget.isRequired),
        // SizedBox(
        //   height: kDefaultPadding / 4,
        // ),
        TextField(
          key: textFieldKey,
          controller: widget.controller.textFieldController,
          enabled: widget.isEnable,
          obscureText: widget.password && !passwordVisible,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          textInputAction: widget.inputAction,
          keyboardType: widget.keyboardType,
          inputFormatters: _textInputFormatters(),
          textAlignVertical: TextAlignVertical.center,
          autofocus: widget.autofocus,
          decoration: InputDecoration(
            filled: widget.isFilled,
            fillColor: Colors.grey[300],
            labelText: widget.labelText,
            hintText: widget.hintText,
            suffixIcon: buildSuffixIcon(),
            prefixIcon: buildPrefixIcon(),
            hintStyle:
            TextStyle(fontSize: widget.fontSize ?? 17, color: Colors.grey),
          ),
          style: TextStyle(
            fontSize: widget.fontSize ?? 17,
            color: widget.colorText,
            fontWeight: widget.bold == true ? FontWeight.bold : null,
          ),
          onTap: (widget.inputType == CustomTextFieldInputType.date ||
              widget.inputType == CustomTextFieldInputType.datetime ||
              widget.inputType == CustomTextFieldInputType.list)
              ? () async {
            DateTime? datetime;
            if (widget.inputType == CustomTextFieldInputType.date) {
              datetime = await _pickDate(context, controller.datetime);
              if (datetime != null) {
                controller.datetime = datetime;
              }
            } else if (widget.inputType ==
                CustomTextFieldInputType.datetime) {
              datetime =
              await _pickDateTime(context, controller.datetime);
              if (datetime != null) {
                controller.datetime = datetime;
              }
            } else if (widget.inputType ==
                CustomTextFieldInputType.list) {
              String? value = await pickFromList();
              if (value != null) {
                controller.text = value;
              }
            }
          }
              : null,
          readOnly: (widget.inputType == CustomTextFieldInputType.date ||
              widget.inputType == CustomTextFieldInputType.datetime ||
              widget.inputType == CustomTextFieldInputType.list),
        ),
        if (controller._errorText != null)
          Container(
              margin: const EdgeInsets.fromLTRB(
                  kDefaultPadding, kDefaultPadding / 2, kDefaultPadding, 0),
              child: Text(
                "${controller._errorText}",
                style: const TextStyle(
                    color: kTextFieldErrorColor,
                    fontStyle: FontStyle.italic,
                    fontSize: 14),
              )),
      ],
    );
  }

  Widget? buildPrefixIcon() {
    if ((widget.inputType == CustomTextFieldInputType.date ||
        widget.inputType == CustomTextFieldInputType.datetime) &&
        ((!widget.isVisiblePrefIcon && widget.controller.text == "") ||
            widget.isVisiblePrefIcon)) {
      return const Icon(Icons.date_range);
    }
  }

  Widget? buildSuffixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if (widget.password) {
      return controller.text.isNotEmpty && widget.isEnable
          ? IconButton(
          onPressed: () {
            passwordVisible = !passwordVisible;
            setState(() {});
          },
          icon: Icon(
            passwordVisible ? Icons.visibility_off : Icons.visibility,
            color: Colors.black,
          ))
          : null;
    } else {
      if (controller.text.isNotEmpty && widget.isEnable && widget.isClear) {
        return IconButton(
          onPressed: () {
            controller.text = "";
          },
          icon: const Icon(Icons.close),
        );
      }
    }
  }

  List<TextInputFormatter>? _textInputFormatters() {
    // if (widget.keyboardType == TextInputType.number) {
    //   return [FilteringTextInputFormatter.allow(RegExp([0-9,]*))];
    // }

    return null;
  }

  Future<DateTime?> _pickDate(
      BuildContext context, DateTime? selectedDate) async {
    var pickDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      keyboardType: TextInputType.text,
      firstDate: DateTime(1000),
      lastDate: DateTime(3000),
    );

    if (pickDate == null) return null;

    return DateTime(pickDate.year, pickDate.month, pickDate.day);
  }

  Future<DateTime?> _pickDateTime(
      BuildContext context, DateTime? selectedDate) async {
    final date = await _pickDate(context, selectedDate);
    if (date == null) return null;

    final time = await _pickTime(
        context,
        TimeOfDay(
            hour: selectedDate?.hour ?? 0, minute: selectedDate?.minute ?? 0));
    if (time == null) date;

    return DateTime(date.year, date.month, date.day, time!.hour, time.minute);
  }

  Future<TimeOfDay?> _pickTime(
      BuildContext context, TimeOfDay initialTime) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }

  Future<String?> pickFromList() async {
    RenderBox? box =
    textFieldKey.currentContext?.findRenderObject() as RenderBox;
    if (box != null) {
      Offset position = box.localToGlobal(Offset.zero);
      double left = position.dx;
      double top = position.dy;

      return await showMenu<String>(
        context: context,
        position: RelativeRect.fromLTRB(0, top, left + 1, top + 1),
        semanticLabel: widget.title,
        items: List.generate(widget.refNoList?.length ?? 0, (index) {
          return PopupMenuItem<String>(
              child: Text(widget.refNoList?[index] ?? ""),
              value: widget.refNoList?[index] ?? "");
        }),
        elevation: 8.0,
      );
    }
  }
}
