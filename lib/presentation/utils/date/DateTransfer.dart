import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:ody_flutter_app/domain/models/me/YoilType.dart';

class DateTransfer {
  static final krYoilList = ["월", "화", "수", "목", "금", "토", "일"];
  static final enYoilList = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  /// 오전 06시 23분
  static String dateTimeToAmPmTime(DateTime time) {
    var formatter = DateFormat('a h시 mm분', 'ko_KR');
    return formatter.format(time);
  }

  /// 오전 06:23
  static String dateTimeToAmPmTimeOnlyNumber(DateTime time) {
    var formatter = DateFormat('a h:mm', 'ko_KR');
    return formatter.format(time);
  }

  /// 2023 / 06 / 27
  static String dateTimeToYearMonthDay(DateTime time) {
    var formatter = DateFormat('yyyy / MM / dd', 'ko_KR');
    return formatter.format(time);
  }

  /// 6월 27일의 기록
  static String dateTimeToMonthDayRecord(DateTime time) {
    var formatter = DateFormat("MMMM d'일'의 기록", 'ko_KR');
    return formatter.format(time);
  }

  /// 6월 27일 수요일
  static String dateTimeToYearMonthDayYoil(DateTime time) {
    var formatter = DateFormat("MMMM d'일' EEEE", 'ko_KR');
    return formatter.format(time);
  }

  /// 월 -> Mon
  static String convertShortYoilKrToEn(String krYoil) {
    return enYoilList[krYoilList.indexOf(krYoil)];
  }

  /// Mon -> 월
  static String convertShortYoilEnToKr(String enYoil) {
    return krYoilList[enYoilList.indexOf(enYoil)];
  }

  /// Mon -> Day Type
  static Day? convertShortEnYoilToDayType(String enYoil) {
    final Map<String, Day> dayAbbreviations = {
      'Mon': Day.monday,
      'Tue': Day.tuesday,
      'Wed': Day.wednesday,
      'Thu': Day.thursday,
      'Fri': Day.friday,
      'Sat': Day.saturday,
      'Sun': Day.sunday,
    };
    return dayAbbreviations[enYoil];
  }

  /// Mon -> Day Type
  static YoilType? convertShortEnYoilToYoilType(String enYoil) {
    final Map<String, YoilType> dayAbbreviations = {
      'Mon': YoilType.MONDAY,
      'Tue': YoilType.TUESDAY,
      'Wed': YoilType.WEDNESDAY,
      'Thu': YoilType.THURSDAY,
      'Fri': YoilType.FRIDAY,
      'Sat': YoilType.SATURDAY,
      'Sun': YoilType.SUNDAY,
    };
    return dayAbbreviations[enYoil];
  }

  /// YoilType -> Day Type
  static Day? convertYoilTypeToDayType(YoilType type) {
    final Map<YoilType, Day> dayAbbreviations = {
      YoilType.MONDAY: Day.monday,
      YoilType.TUESDAY: Day.tuesday,
      YoilType.WEDNESDAY: Day.wednesday,
      YoilType.THURSDAY: Day.thursday,
      YoilType.FRIDAY: Day.friday,
      YoilType.SATURDAY: Day.saturday,
      YoilType.SUNDAY: Day.sunday,
    };
    return dayAbbreviations[type];
  }

  static Day convertDateTimeToDay(DateTime dateTime) {
    switch (dateTime.weekday) {
      case DateTime.monday:
        return Day.monday;
      case DateTime.tuesday:
        return Day.tuesday;
      case DateTime.wednesday:
        return Day.wednesday;
      case DateTime.thursday:
        return Day.thursday;
      case DateTime.friday:
        return Day.friday;
      case DateTime.saturday:
        return Day.saturday;
      case DateTime.sunday:
        return Day.sunday;
      default:
        throw ArgumentError('Invalid weekday');
    }
  }
}
