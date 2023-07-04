import 'package:intl/intl.dart';

class DateTransfer {

  static final krYoilList = ["월", "화", "수", "목", "금", "토", "일"];
  static final enYoilList = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

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

  /// 월 -> Mon
  static String convertShortYoilKrToEn(String krYoil){
    return enYoilList[krYoilList.indexOf(krYoil)];
  }

  /// Mon -> 월
  static String convertShortYoilEnToKr(String enYoil){
    return krYoilList[enYoilList.indexOf(enYoil)];
  }
}
