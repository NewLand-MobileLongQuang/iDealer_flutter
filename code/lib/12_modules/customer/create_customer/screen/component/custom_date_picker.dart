import 'package:flutter/material.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';
import 'package:idealer/10_app_commons/extension/date_time_extension.dart';

class CustomDatePicker extends StatefulWidget {
  CustomDatePicker({
    Key? key,
    required this.header,
    this.isEnableViewDateTime = true,
    this.isShowViewDateTime = true,
    this.date,
    this.text,
    this.onChangeDateTime,
    this.isShowHeader = true,
    this.isDateFormat = false,
    this.isStar = false,
  }) : super(key: key);

  final String? header;
  final DateTime? date;
  final String? text;
  final bool isEnableViewDateTime;
  final bool isShowViewDateTime;
  //
  final bool isShowHeader;
  final bool isDateFormat;
  final bool isStar;

  Function(DateTime)? onChangeDateTime;

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowHeader)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.header ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    color: titleBlackColor,
                  ),
                ),
                if (widget.isStar == true)
                  const TextSpan(
                    text: " *",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        if (widget.isShowHeader) const SizedBox(height: 5),
        GestureDetector(
          onTap: () =>
              widget.isEnableViewDateTime ? pickDateTime(context) : null,
          child: Container(
            // color:
            //     widget.isEnableViewDateTime ? Colors.white : Colors.grey[300],
            child: Column(
              children: [
                widget.isShowViewDateTime
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.text != null
                                    ? widget.text ?? ""
                                    : widget.isDateFormat
                                        ? widget.date?.dateString() ?? ''
                                        : widget.date?.longDateTimeString() ??
                                            '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(
                              Icons.calendar_month,
                              color: titleBlackColor,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(height: 28),
                Container(height: 1, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    // final time = await pickTime(context);
    // if (time == null) return;

    DateTime? newDateTime;
    if (widget.isDateFormat) {
      newDateTime = DateTime(
        date.year,
        date.month,
        date.day,
      );
    } else {
      final time = await pickTime(context);
      if (time == null) return;

      newDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    }

    widget.onChangeDateTime!(newDateTime);
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: widget.date ?? initialDate,
      firstDate: DateTime(1000),
      lastDate: DateTime(2030),
      keyboardType: TextInputType.text
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    const initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: widget.date != null
          ? TimeOfDay(hour: widget.date!.hour, minute: widget.date!.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }
}
