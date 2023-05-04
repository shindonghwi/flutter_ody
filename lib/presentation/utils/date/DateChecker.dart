class DateChecker{
  static bool isDateToday(DateTime time){
    final now = DateTime.now();
    return time.year == now.year && time.month == now.month && time.day == now.day;
  }
}