import 'package:flutter/material.dart';

Future<DateTime?> showDateTimePicker(BuildContext context) async {
  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2024),
        helpText: 'Select a date',
        builder: (context, child) => Theme(data: ThemeData.light(), child: child!),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) => Theme(data: ThemeData.light(), child: child!),
      );

  DateTime? date = await pickDate();
  if (date != null) {
    TimeOfDay? time = await pickTime();
    if (time != null) {
      return DateTime(date.year, date.month, date.day, time.hour, time.minute);
    }
  }
  return null;
}
