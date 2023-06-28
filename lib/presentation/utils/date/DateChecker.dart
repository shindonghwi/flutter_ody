import 'package:flutter/cupertino.dart';

class DateChecker{
  static bool isDateToday(DateTime time){
    final now = DateTime.now();

    debugPrint("tasfdlkime: $time ${time.year == now.year} ${time.month == now.month} ${time.day == now.day}");
    debugPrint("tasfdlkime: $time ${time.year == now.year && time.month == now.month && time.day == now.day}");

    return time.year == now.year && time.month == now.month && time.day == now.day;
  }
}