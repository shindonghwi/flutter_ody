import 'package:flutter/cupertino.dart';

class DateChecker {
  static bool isDateToday(DateTime time) {
    final now = DateTime.now();
    return time.year == now.year && time.month == now.month && time.day == now.day;
  }

  static int isDateComparisonFromToday(DateTime time) {
    final now = DateTime.now();

    final ddd = "${now.year}-${now.month}-${now.day}".compareTo("${time.year}-${time.month}-${time.day}");
    debugPrint("isDateComparisonFromToday: $ddd");
    return ddd;
  }
}
