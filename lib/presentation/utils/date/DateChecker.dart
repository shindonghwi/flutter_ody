import 'dart:ui';

import 'package:intl/intl.dart';

class DateChecker {
  static bool isDateToday(DateTime time) {
    final now = DateTime.now();
    return time.year == now.year && time.month == now.month && time.day == now.day;
  }

  static int isDateComparisonFromToday(DateTime time) {
    final now = DateTime.now();
    return "${now.year}-${now.month}-${now.day}".compareTo("${time.year}-${time.month}-${time.day}");
  }

  static int isDateComparison(DateTime time1, DateTime time2) {
    return "${time1.year}-${time1.month}-${time1.day}".compareTo("${time2.year}-${time2.month}-${time2.day}");
  }

  static int isDateYearMonthComparison(DateTime time1, DateTime time2) {
    return "${time1.year}-${time1.month}".compareTo("${time2.year}-${time2.month}");
  }

  static String getDayOfWeekFullNameFromDateTime(DateTime time) {
    DateFormat dateFormat = DateFormat('EEEE', window.locale.toString());
    String dayOfWeek = dateFormat.format(DateTime.now());
    final yoilList = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"];
    return yoilList[yoilList.indexOf(dayOfWeek)];
  }

  static String getDayOfWeekShortNameFromDateTime(DateTime time) {
    DateFormat dateFormat = DateFormat('EEEE', window.locale.toString());
    String dayOfWeek = dateFormat.format(DateTime.now());
    final yoilList = ["월", "화", "수", "목", "금", "토", "일"];
    return yoilList[yoilList.indexOf(dayOfWeek)];
  }

  static bool isTodayCheckFromYoil(String yoil) {
    DateFormat dateFormat = DateFormat('EEEE', window.locale.toString());
    String dayOfWeek = dateFormat.format(DateTime.now());
    return dayOfWeek[0] == yoil;
  }
}
