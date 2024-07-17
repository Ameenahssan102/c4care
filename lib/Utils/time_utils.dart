import 'package:intl/intl.dart';

class TimeUtils {
  static intDayDifference(int date) {
    String stringDate = date.toString();
    String newInput = '${stringDate.substring(0, 4)}/${stringDate.substring(4, 6)}/${stringDate.substring(6, 8)}';
    var formattedDate = DateFormat('yyyy/MM/dd').parse(newInput);
    var difference = DateTime.now().difference(formattedDate);
    return difference.inDays;
  }

  static now2String(String format) {
    return DateFormat(format).format(DateTime.now());
  }

  static iso2DateString(DateTime iso, {String format = "MMM dd"}) {
    return DateFormat(format).format(iso);
  }
  static iso2DateString2(DateTime iso, {String format = "MMM dd"}) {
    return DateFormat(format).format(iso);
  }

  static iso2DateTime(DateTime iso, {String format = "MMM dd, hh:mm a"}) {
    return DateFormat(format).format(iso.toLocal());
  }

  static millis2DateString(int millis, {String format = "MMM dd, yyyy"}) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat(format).format(date);
  }

  static millis2TimeString(int millis, {String format = "hh:mm a"}) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat(format).format(date);
  }

  static millis2DateTimeString(int millis, {String format = "MMM dd, hh:mm a"}) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat(format).format(date);
  }

  static millis2TodayTomorrow(int millis, {String format = "MMM dd, hh:mm a"}) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millis);
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    int difference = DateTime(date.year, date.month, date.day).difference(now).inDays;

    if (difference == -1) {
      return "Yesterday, ${DateFormat('hh:mm a').format(date)}";
    } else if (difference == 0) {
      return "Today, ${DateFormat('hh:mm a').format(date)}";
    } else if (difference == 1) {
      return "Tomorrow, ${DateFormat('hh:mm a').format(date)}";
    }
    return DateFormat(format).format(date);
  }

  static int date2int(DateTime date) {
    return int.parse(DateFormat('yyyyMMdd').format(date));
  }

  static date2String(DateTime date, {String format = "MMM dd, yyyy"}) {
    return DateFormat(format).format(date);
  }

  static date2Date(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static date2Date2(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static int2String(int date, String? format) {
    String stringDate = date.toString();
    String newInput = '${stringDate.substring(0, 4)}/${stringDate.substring(4, 6)}/${stringDate.substring(6, 8)}';
    var formattedDate = DateFormat('yyyy/MM/dd').parse(newInput);
    return DateFormat(format).format(formattedDate);
  }

  static sting2Date(String date) {
    return DateFormat('MM-dd-yyyy').parse(date);

  }


  static getTimeDifference(DateTime date){
    DateTime now = DateTime.now();
    final difference = now.difference(date);
    return "${difference.inMinutes} Min";

  }
}
