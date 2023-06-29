
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
}
