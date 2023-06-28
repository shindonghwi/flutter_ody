import 'package:intl/intl.dart';

class DateTransfer {

  /// 오전 06시 23분
  static String dateTimeToAmPmTime(DateTime time){
    var formatter = DateFormat('a h시 mm분', 'ko_KR');
    return formatter.format(time);
  }

  /// 오전 06:23
  static String dateTimeToAmPmTimeOnlyNumber(DateTime time){
    var formatter = DateFormat('a h:mm', 'ko_KR');
    return formatter.format(time);
  }

  /// 2023 / 06 / 27
  static String dateTimeToYearMonthDay(DateTime time){
    var formatter = DateFormat('yyyy / MM / dd', 'ko_KR');
    return formatter.format(time);
  }

  /// 6월 27일의 기록
  static String dateTimeToMonthDayRecord(DateTime time){
    var formatter = DateFormat("MMMM d'일'의 기록", 'ko_KR');
    return formatter.format(time);
  }

  /// 6월 27일 수요일
  static String dateTimeToYearMonthDayYoil(DateTime time){
    var formatter = DateFormat("MMMM d'일' EEEE", 'ko_KR');
    return formatter.format(time);
  }
}
