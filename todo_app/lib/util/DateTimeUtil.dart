import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtil {
  static String getCurrentDate() {
    return DateFormat('y-M-d').format(DateTime.now());
  }

  static String getCurrentDateFormatted({@required String formatter}) {
    return DateFormat(formatter).format(DateTime.now());
  }

  static String getFormattedDateTimeStr(
      {@required String dateTime, String formatter}) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm").parse(dateTime);
    return DateFormat(formatter).format(tempDate);
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
