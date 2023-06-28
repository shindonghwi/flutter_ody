import 'dart:ui';

import 'package:intl/intl.dart';

class DateTransfer {
  static String dateTimeToAmPmTime(DateTime time){
    var formatter = DateFormat('a h시 mm분', 'ko_KR');
    return formatter.format(time);
  }
  static String dateTimeToAmPmTimeOnlyNumber(DateTime time){
    var formatter = DateFormat('a h:mm', 'ko_KR');
    return formatter.format(time);
  }
  static String dateTimeToYearMonthDay(DateTime time){
    var formatter = DateFormat('yyyy / MM / dd', 'ko_KR');
    return formatter.format(time);
  }

  static String dateTimeToYearMonthDayYoil(DateTime time){
    var formatter = DateFormat("MMMM d'일' EEEE", 'ko_KR');
    return formatter.format(time);
  }
}
