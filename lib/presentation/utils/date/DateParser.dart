import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:ody_flutter_app/data/data_source/remote/Service.dart';

class DateParser {
  static String getGlobalTimeDate(DateTime time) {
    String formattedDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(time);
    String timeZoneOffset = _getTimeZoneOffset(time);
    String timeZoneName = Service.headers["Application-Time-Zone"].toString();
    String result = "$formattedDateTime$timeZoneOffset[$timeZoneName]";
    return result;
  }

  static String _getTimeZoneOffset(DateTime time) {
    Duration offset = time.timeZoneOffset;
    String hours = offset.inHours.toString().padLeft(2, '0');
    String minutes = (offset.inMinutes % 60).toString().padLeft(2, '0');
    String sign = offset.isNegative ? "-" : "+";
    return "$sign$hours:$minutes";
  }

  static String getTimeZoneName(DateTime date) {
    String timeZoneName = '';
    List<String> timeZoneIds = getTimeZoneIds(date);
    if (timeZoneIds.isNotEmpty) {
      timeZoneName = timeZoneIds[0];
    }
    return timeZoneName;
  }

  static List<String> getTimeZoneIds(DateTime date) {
    Set<String> timeZoneIds = <String>{};
    DateTime startDate = DateTime(date.year - 1);
    DateTime endDate = DateTime(date.year + 1);

    for (DateTime d = startDate; d.isBefore(endDate); d = d.add(const Duration(days: 1))) {
      timeZoneIds.add(d.timeZoneName);
    }

    return timeZoneIds.toList();
  }

  static int getNumberOfDays(int year, int month) {
    bool isLeapMonth() {
      if (month == DateTime.february && year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
        return true;
      }
      return false;
    }

    if (isLeapMonth()) {
      return 29; // Leap month has 29 days (February in a leap year)
    } else {
      return DateTime(year, month + 1, 0).day; // Get the number of days in the specified month
    }
  }

  static int getLastDayFromCurrentMonth() {
    DateTime now = DateTime.now();
    return getNumberOfDays(now.year, now.month);
  }

  static int getWeekNumberFromCurrentDay() {
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    int day = now.day;
    DateTime targetDate = DateTime(year, month, day);
    return ((targetDate.day - targetDate.weekday + 10) ~/ 7).toInt();
  }

}

