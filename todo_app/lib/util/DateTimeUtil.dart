import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtil {

  static String getCurrentDate() {
    return DateFormat('y-M-d').format(DateTime.now());
  }

  static String getCurrentTime() {
    return DateFormat('Hms').format(DateTime.now());
  }

  static String formatTimeOfDay(TimeOfDay tod, {String formatter = "Hm"}) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat(formatter);
    return format.format(dt);
  }
}
